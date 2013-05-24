import os.path as path
import string
import argparse
import glob
import re

def basename(filename):
    base = filename
    if filename.find('@2x') > 0:
        base = filename[:filename.find('@2x')]
    elif filename.find('~') > 0:
        base = filename[:filename.find('~')]
    elif filename.find('.') > 0:
        base = filename[:filename.find('.')]
    return base

def file_type(filename):
    isRetina = False
    isIpad = False
    if filename.find('@2x') > 0:
        isRetina = True
    if filename.find('~ipad') > 0:
        isIpad = True

    if isRetina:
        if isIpad:
            return 'ipad2x'
        else:
            return 'iphone2x'
    else:
        if isIpad:
            return 'ipad'
    return 'iphone'

def munged_name(basename):
    parts = re.split('[-_\s]', basename)
    capitalized = [word.capitalize() for word in parts]
    capitalized[0] = parts[0]
    return string.join(capitalized, '')

def image_class():
    return PLATFORM_IMAGE_CLASS_IOS if args.platform.lower() != 'osx' else PLATFORM_IMAGE_CLASS_OS_X;

def output_to_file(output, file_path):
    ### Florian Bruger ensures the file isn't updated needlessly.
    original_output = ''
    if path.exists(file_path):
        with open(file_path, 'r') as file:
            original_output += file.read()
            file.close()

    if original_output == output:
        pass
    else:
        with open(file_path, 'w') as file:
            file.write(output)
            file.close()


class ImageGroup:
    iphone = None
    iphone2x = None
    ipad = None
    ipad2x = None
    extras = []

    def __init__(self, file_name):
        setattr(self, file_type(file_name), file_name)

    def add_file(self, file_name):
        type = file_type(file_name)

        if getattr(self, type) is not None:
            self.extras.append(file_name)
        else:
            setattr(self, type, file_name)

    def warnings(self, iPhone=True, iPad=True, retina=True, duplicates=True):
        definition = ''
        if iPhone and self.iphone is None:
            definition += '#warning image formatted for iPhone %s not found\n' % filename
        if iPhone and retina and self.iphone2x is None:
            definition += '#warning image formatted for retina iPhone %s not found\n' % filename
        if iPad and self.ipad is None:
            definition += '#warning image formatted for iPad %s not found\n' % filename
        if iPad and retina and self.ipad2x is None:
            definition += '#warning image formatted for retina iPad %s not found\n' % filename
        if duplicates:
            for file in self.extras:
                definition += '#warning duplicate image %s found in project. Verify proper capitalization.\n' % file
        return definition

    def output_header(self, filename, prefix):
        return args.format_header % {'prefix':prefix, 'method':munged_name(filename)}

    def output_impl(self, filename, prefix):
        return args.format_impl % {'prefix':prefix, 'method':munged_name(filename), 'filename':filename}


DEFAULT_IMPL_FORMAT = '+ (instancetype)%(prefix)s%(method)s {\
 id image = [[self class] imageNamed:@"%(filename)s"];\
 ZAssert(image, @"Image %(filename)s not found");\
 return image;\
 }\n'

DEFAULT_HEADER_FORMAT = '+ (instancetype)%(prefix)s%(method)s;\n'

PLATFORM_IMAGE_CLASS_OS_X = 'NSImage'
PLATFORM_IMAGE_CLASS_IOS = 'UIImage'


### cmd folder outputFile
parser = argparse.ArgumentParser(description='Create a header file with contants for each image file in the given folder.')
parser.add_argument('-s', '--source', type=str, default='./', help='A folder which contains images.')
parser.add_argument('-d', '--destination', type=str, default='./images', help='The filename to write to (two files will be written with the extenstions .{h,m}.')
parser.add_argument('--platform', type=str, default='ios', help='The targeted platform (i.e. "osx" or "ios").')
parser.add_argument('--prefix', type=str, default='', help='The prefix added at the begining of each image\'s filename.')
parser.add_argument('--format-impl', type=str, default=DEFAULT_IMPL_FORMAT, help='The format string specifying how the implementation file should be written.')
parser.add_argument('--format-header', type=str, default=DEFAULT_HEADER_FORMAT, help='The format string specifying how the header file should be written.')
parser.add_argument('--warn-retina', dest='retina', type=bool, default=True, help='Warn for missing retina images.')
parser.add_argument('--warn-ipad', dest='ipad', type=bool, default=False, help='Warn for missing iPad (~ipad) images.')
parser.add_argument('--warn-iphone', dest='iphone', type=bool, default=False, help='Warn for missing iPhone (~iphone) images')
parser.add_argument('--warn-duplicates', dest='duplicates', type=bool, default=True, help='Warn for duplicate images.')

args = parser.parse_args()
source = path.join(path.expanduser(args.source), '*.png')
iterator = glob.iglob(source)
all_files = {}

for fullpath in iterator:
    (leading, filename) = path.split(fullpath)
    key = basename(filename)

    if key in all_files:
        current_file = all_files[key]
        current_file.add_file(filename)
    else:
        current_file = ImageGroup(filename)
        all_files[key] = current_file

header_file_path = path.join(path.expanduser('.'), args.destination) + '.h'
impl_file_path = path.join(path.expanduser('.'), args.destination) + '.m'

### Shared file header
output_prefix = '// Created using the image.py script written by Patrick Hughes. He\'s a pretty cool guy.\n'
output_prefix += '// Script then modified by Aron Cedercrantz to output a (NS|UI)Image category.\n'
output_prefix +='//\n// DO NOT EDIT THIS FILE. \n//\n'
output_prefix +='// This file is automatically generated. Any changes may be overwritten the next time images.py is invoked.\n\n'

### Create the implementation content    
header_import_file = path.normpath(header_file_path)
header_import_file = path.basename(header_import_file)

impl_output = output_prefix
impl_output += '#import "%(import)s"\n\n' % {'import':header_import_file} 
impl_output += '@implementation %(imageClass)s (%(prefix)sAppImages)\n\n' % {'imageClass':image_class(), 'prefix':args.prefix.upper()}

### Create the header
header_output = output_prefix
header_output += '@interface %(imageClass)s (%(prefix)sAppImages)\n\n' % {'imageClass':image_class(), 'prefix':args.prefix.upper()}

method_prefix = args.prefix.lower() + '_'

for key in all_files:
    image_group = all_files[key]
    warnings = image_group.warnings(iPhone=args.iphone, iPad=args.ipad, retina=args.retina, duplicates=args.duplicates)
    impl_output += warnings
    impl_output += image_group.output_impl(key, method_prefix)
    header_output += image_group.output_header(key, method_prefix)

header_output += '\n@end\n'
impl_output += '\n@end\n'

output_to_file(header_output, header_file_path)
output_to_file(impl_output, impl_file_path)

