//
//  NSString+FGHash.h
//  HubScout
//
//  Created by Aron Cedercrantz on 2012-01-06.
//  Copyright (c) 2012 Fruit is Good. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FGHash)

- (NSString *)fg_SHA1Digest;
- (NSString *)fg_SHA256Digest;
- (NSString *)fg_SHA512Digest;

@end

@interface NSData (FGHash)

- (NSData *)fg_SHA1Digest;
- (NSData *)fg_SHA256Digest;
- (NSData *)fg_SHA512Digest;

@end
