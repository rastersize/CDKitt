//
//  NSString+FGHash.m
//  HubScout
//
//  Created by Aron Cedercrantz on 2012-01-06.
//  Copyright (c) 2012 Aron Cedercrantz. All rights reserved.
//

#import "NSString+FGHash.h"
#import <CommonCrypto/CommonDigest.h>

@interface NSData (FGHashPrivate)

- (NSData *)fg_hashDataUsing:(unsigned char * (*)(const void *, CC_LONG, unsigned char *))hashFunction digestLength:(NSUInteger)digestLength;

@end

@interface NSString (FGHashPrivate)

- (NSString *)fg_hashedStringUsing:(NSData * (^)(NSData *))block;

@end


@implementation NSString (FGHash)

- (NSString *)fg_hashedStringUsing:(NSData * (^)(NSData *))block
{
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
	NSData *hashedData = block(data);
	NSString *hashedString = [[NSString alloc] initWithData:hashedData encoding:NSUTF8StringEncoding];
	
	return hashedString;
}

- (NSString *)fg_SHA1Digest
{
	return [self fg_hashedStringUsing:^NSData * (NSData *data) {
		return [data fg_SHA1Digest];
	}];
}

- (NSString *)fg_SHA256Digest
{
	return [self fg_hashedStringUsing:^NSData * (NSData *data) {
		return [data fg_SHA256Digest];
	}];
}

- (NSString *)fg_SHA512Digest
{
	return [self fg_hashedStringUsing:^NSData * (NSData *data) {
		return [data fg_SHA512Digest];
	}];
}

@end


@implementation NSData (FGHash)

- (NSData *)fg_SHA1Digest
{
	return [self fg_hashDataUsing:&CC_SHA1 digestLength:CC_SHA1_DIGEST_LENGTH];
}

- (NSData *)fg_SHA256Digest
{
	return [self fg_hashDataUsing:&CC_SHA256 digestLength:CC_SHA256_DIGEST_LENGTH];
}

- (NSData *)fg_SHA512Digest
{
	return [self fg_hashDataUsing:&CC_SHA512 digestLength:CC_SHA512_DIGEST_LENGTH];
}

- (NSData *)fg_hashDataUsing:(unsigned char * (*)(const void *, CC_LONG, unsigned char *))hashFunction digestLength:(NSUInteger)digestLength
{
	NSData *hashedData = nil;
	unsigned char hash[digestLength];
	
	if (hashFunction([self bytes], (CC_LONG)[self length], hash)) {
		hashedData = [[NSData alloc] initWithBytes:hash length:digestLength];
	}
	
	return hashedData;
}

@end

