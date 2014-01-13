//
//  NSBundle+CDSystemProperties.h
//  CDKitt
//
//  Created by Aron Cedercrantz on 11/01/14.
//  Copyright (c) 2014 Aron Cedercrantz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (CDSystemProperties)

- (NSString *)cd_bundleName;
- (NSString *)cd_bundleShortVersionString;
- (NSString *)cd_bundleVersion;
- (NSString *)cd_humanReadableCopyright;

@end
