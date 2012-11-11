//
//  NSFileManager+CDDirectoryLocations.m
//
//  Created by Matt Gallagher on 06 May 2010
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//
//  Modified and extended to by Aron Cedercrantz, 2011.
//

#import "NSFileManager+CDKitt.h"
#import "CDKittMacros.h"


enum {
	kDirectoryLocationErrorNoPathFound,
	kDirectoryLocationErrorFileExistsAtLocation
};

NSString *const kDirectoryLocationDomain = @"DirectoryLocationDomain";

CD_FIX_CATEGORY_BUG_QA1490(NSFileManager, CDKitt);
@implementation NSFileManager (CDKitt)

#pragma mark - Getting the Path or URL to Directories
- (NSString *)cd_findOrCreateDirectory:(NSSearchPathDirectory)searchPathDirectory
							  inDomain:(NSSearchPathDomainMask)domainMask
				   appendPathComponent:(NSString *)appendComponent
								 error:(NSError **)errorOut
{
	NSString *resolvedPath = nil;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(searchPathDirectory, domainMask, YES);
	if ([paths count] > 0) {
		resolvedPath = paths[0];
		resolvedPath = [appendComponent length] > 0 ? [resolvedPath stringByAppendingPathComponent:appendComponent] : resolvedPath;
		
		BOOL exists = NO;
		BOOL isDirectory = NO;
		exists = [self fileExistsAtPath:resolvedPath isDirectory:&isDirectory];
		if (!exists || !isDirectory) {
			if (exists) {
				if (errorOut) {
					NSDictionary *userInfo = @{
				NSLocalizedDescriptionKey:	NSLocalizedString(@"A file already exist at the requested directory location.", @"A file exist at the requested directory location"),
					@"NSSearchPathDirectory":	@(searchPathDirectory),
					@"NSSearchPathDomainMask":	@(domainMask)
					};
					*errorOut = [NSError errorWithDomain:kDirectoryLocationDomain code:kDirectoryLocationErrorFileExistsAtLocation userInfo:userInfo];
				}
				return nil;
			}
			
			NSError *error = nil;
			BOOL success = [self createDirectoryAtPath:resolvedPath withIntermediateDirectories:YES attributes:nil error:&error];
			if (!success) {
				if (errorOut) {
					*errorOut = error;
				}
				return nil;
			}
		}
	} else {
		if (errorOut) {
			NSDictionary *userInfo = @{
		NSLocalizedDescriptionKey:	NSLocalizedString(@"No matching directory for the search path in the given domain(s).", @"No matching directory for the search path in the given domain(s)."),
			@"NSSearchPathDirectory":	@(searchPathDirectory),
			@"NSSearchPathDomainMask":	@(domainMask)
			};
			*errorOut = [NSError errorWithDomain:kDirectoryLocationDomain code:kDirectoryLocationErrorNoPathFound userInfo:userInfo];
		}
		return nil;
	}
	
	return resolvedPath;
}


#pragma mark - Getting the Path and URL to Application Directories
- (NSString *)cd_applicationSupportDirectoryPathForApplication:(NSString *)applicationName
{
	NSError *error = nil;
	NSString *result = [self cd_findOrCreateDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appendPathComponent:applicationName error:&error];
	ZAssert(result != nil, @"Unable to find or create application support directory:\n%@", error);
	return result;
}

+ (NSString *)cd_applicationSupportDirectoryPathForApplication:(NSString *)applicationName
{
	return [[self new] cd_applicationSupportDirectoryPathForApplication:applicationName];
}

- (NSURL *)cd_applicationSupportDirectoryURLForApplication:(NSString *)applicationName
{
	NSString *filePath = [self cd_applicationSupportDirectoryPathForApplication:applicationName];
	NSURL *fileUrl = [NSURL fileURLWithPath:filePath isDirectory:YES];
	return fileUrl;
}

+ (NSURL *)cd_applicationSupportDirectoryURLForApplication:(NSString *)applicationName
{
	return [[self new] cd_applicationSupportDirectoryURLForApplication:applicationName];
}


#pragma mark - Getting the Path and URL to the Documents Directory
- (NSString *)cd_documentsDirectoryPath
{
	NSError *error = nil;
	NSString *result = [self cd_findOrCreateDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appendPathComponent:nil error:&error];
	ZAssert(result != nil, @"Unable to find or create application documents directory:\n%@", error);
	return result;
}

+ (NSString *)cd_documentsDirectoryPath
{
	return [[self new] cd_documentsDirectoryPath];
}

- (NSURL *)cd_documentsDirectoryURL
{
	NSString *path = [self cd_documentsDirectoryPath];
	NSURL *url = [NSURL fileURLWithPath:path isDirectory:YES];
	return url;
}

+ (NSURL *)cd_documentsDirectoryURL
{
	return [[self new] cd_documentsDirectoryURL];
}


#pragma mark - Getting the Path and URL to the Cache Directory
- (NSString *)cd_cacheDirectoryPathForBundleWithIdentifier:(NSString *)bundleIdentifier
{
	NSError *error = nil;
	NSString *result = [self cd_findOrCreateDirectory:NSCachesDirectory inDomain:NSUserDomainMask appendPathComponent:bundleIdentifier error:&error];
	
	ZAssert(result != nil, @"Unable to find or create application cache directory:\n%@", error);
	return result;
}

+ (NSString *)cd_cacheDirectoryPathForBundleWithIdentifier:(NSString *)bundleIdentifier
{
	return [[self new] cd_cacheDirectoryPathForBundleWithIdentifier:bundleIdentifier];
}

- (NSURL *)cd_cacheDirectoryURLForBundleWithIdentifier:(NSString *)bundleIdentifier
{
	NSString *path = [self cd_cacheDirectoryPathForBundleWithIdentifier:bundleIdentifier];
	NSURL *url = [NSURL fileURLWithPath:path isDirectory:YES];
	return url;
}

+ (NSURL *)cd_cacheDirectoryURLForBundleWithIdentifier:(NSString *)bundleIdentifier
{
	return [[self new] cd_cacheDirectoryURLForBundleWithIdentifier:bundleIdentifier];
}


@end
