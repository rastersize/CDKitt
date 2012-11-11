// UIImage+CDKitt.m
//
// Copyright (c) 2012 Aron Cedercrantz
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UIImage+CDKitt.h"



// The implementation of the methods in UIImage(CDKittImageDrawing) were
// originally created by David Keegan (@kgn). The copyright notice below applies
// to them. The method names have been slightly modified (adding a `cd_` prefix).
//
// See the [original repository](https://github.com/kgn/BBlock/) and
// [blog post](http://kgn.github.com/blog/2012/03/21/caching-drawing-code/) for
// more information.
//
// Copyright (c) 2012 David Keegan
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
CD_FIX_CATEGORY_BUG_QA1490(UIImage, CDKittImageDrawing);
@implementation UIImage (CDKittImageDrawing)

#pragma mark - Cached Image Drawing
+ (NSCache *)cd_drawingCache
{
	static NSCache *cache = nil;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
		cache = [[NSCache alloc] init];
	});
	return cache;
}

+ (UIImage *)cd_imageForSize:(CGSize)size opaque:(BOOL)opaque withDrawingBlock:(void(^)())drawingBlock
{
	if (size.width <= 0 || size.height <= 0) {
		return nil;
	}
	
	UIGraphicsBeginImageContextWithOptions(size, opaque, 0.0f);
	drawingBlock();
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

+ (UIImage *)cd_imageForSize:(CGSize)size withDrawingBlock:(void(^)())drawingBlock
{
	return [self cd_imageForSize:size opaque:NO withDrawingBlock:drawingBlock];
}

+ (UIImage *)cd_imageWithIdentifier:(NSString *)identifier opaque:(BOOL)opaque forSize:(CGSize)size andDrawingBlock:(void(^)())drawingBlock
{
	UIImage *image = [[self cd_drawingCache] objectForKey:identifier];
	if (image == nil && (image = [self cd_imageForSize:size opaque:opaque withDrawingBlock:drawingBlock])) {
		[[self cd_drawingCache] setObject:image forKey:identifier];
	}
	return image;
}

+ (UIImage *)cd_imageWithIdentifier:(NSString *)identifier forSize:(CGSize)size andDrawingBlock:(void(^)())drawingBlock
{
	return [self cd_imageWithIdentifier:identifier opaque:NO forSize:size andDrawingBlock:drawingBlock];
}

@end

