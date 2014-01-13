//
//  NSBundle+CDSystemProperties.m
//  CDKitt
//
//  Created by Aron Cedercrantz on 11/01/14.
//  Copyright (c) 2014 Aron Cedercrantz. All rights reserved.
//

#import "NSBundle+CDSystemProperties.h"

@implementation NSBundle (CDSystemProperties)

- (NSString *)cd_bundleName
{
	return [self objectForInfoDictionaryKey:(__bridge NSString *)kCFBundleNameKey];
}

- (NSString *)cd_bundleShortVersionString
{
	return [self objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *)cd_bundleVersion
{
	return [self objectForInfoDictionaryKey:(__bridge NSString *)kCFBundleVersionKey];
}

- (NSString *)cd_humanReadableCopyright
{
	return [self objectForInfoDictionaryKey:@"NSHumanReadableCopyright"];
}

@end
