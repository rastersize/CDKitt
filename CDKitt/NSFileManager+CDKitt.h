//
//  NSFileManager+CDDirectoryLocations.h
//
//  Created by Matt Gallagher on 06 May 2010
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//
//  Modified and extended by Aron Cedercrantz, 2011.
//

#import <Foundation/Foundation.h>

/**
 * DirectoryLocations is a set of global methods for finding the fixed location
 * directories.
 *
 * @warning Note: The implementation requires the CDCommon header file for its
 *          logging macros as well as the CD_FIX_CATEGORY_BUG_QA1490 macro.
 *
 * @author Matt Gallagher
 * @author Aron Cedercrantz
 */
@interface NSFileManager (CDKitt)

#pragma mark - Removing Files and Directories


#pragma mark - Getting the Path or URL to Directories
/** @name Getting the Path or URL to Directories */
/**
 * Finds an existing directory or creates one.
 *
 * Method to tie together the steps of:
 * 1. Locate a standard directory by search path and domain mask
 * 2. Select the first path in the results
 * 3. Append a subdirectory to that path
 * 4. Create the directory and intermediate directories if needed
 * 5. Handle errors by emitting a proper NSError object
 *
 * @param searchPathDirectory The search path passed to
 *            NSSearchPathForDirectoriesInDomains.
 * @param  The domain mask passed to NSSearchPathForDirectoriesInDomains.
 * @param  The subdirectory appended.
 * @param errorOut If an error occurs, upon return contains an NSError object
 *            that describes the problem. Pass NULL if you do not want error
 *            information.
 * @return A string containing the path of the directory if it exists, otherwise `nil`.
 * @author Matt Gallagher
 */
- (NSString *)cd_findOrCreateDirectory:(NSSearchPathDirectory)searchPathDirectory inDomain:(NSSearchPathDomainMask)inDomain appendPathComponent:(NSString *)appendPathComponent error:(NSError **)error;


#pragma mark - Getting the Path and URL to the Application Support Directory
/** @name Getting the Path or URL to Application Directories */
/**
 * Finds the application support directory (creates it if it doesn't exist) and
 * returns the path to it.
 */
- (NSString *)cd_applicationSupportDirectoryPathForApplication:(NSString *)applicationName;
+ (NSString *)cd_applicationSupportDirectoryPathForApplication:(NSString *)applicationName;

/**
 * Finds the application support directory (creates it if it doesn't exist) and
 * returns the file URL to it.
 */
- (NSURL *)cd_applicationSupportDirectoryURLForApplication:(NSString *)applicationName;
+ (NSURL *)cd_applicationSupportDirectoryURLForApplication:(NSString *)applicationName;


#pragma mark - Getting the Path and URL to the Documents Directory
- (NSString *)cd_documentsDirectoryPath;
+ (NSString *)cd_documentsDirectoryPath;
- (NSURL *)cd_documentsDirectoryURL;
+ (NSURL *)cd_documentsDirectoryURL;


#pragma mark - Getting the Path and URL to the Cache Directory
/**
 * Finds the application cache directory (creates it if it doesn't exist) and
 * returns the path to it.
 */
- (NSString *)cd_cacheDirectoryPathForBundleWithIdentifier:(NSString *)bundleIdentifier;
+ (NSString *)cd_cacheDirectoryPathForBundleWithIdentifier:(NSString *)bundleIdentifier;

/**
 * Finds the application cache directory (creates it if it doesn't exist) and
 * returns the file URL to it.
 */
- (NSURL *)cd_cacheDirectoryURLForBundleWithIdentifier:(NSString *)bundleIdentifier;
+ (NSURL *)cd_cacheDirectoryURLForBundleWithIdentifier:(NSString *)bundleIdentifier;


@end
