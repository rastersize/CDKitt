//
//  CDDispatchBlock.m
//  CDKitt
//
//  Created by Aron Cedercrantz on 13/01/14.
//  Copyright (c) 2014 Aron Cedercrantz. All rights reserved.
//

#import "CDDispatchBlock.h"

#pragma mark - Dispatching Blocks on Queues
void CDDispatchBlockOnMainQueue(dispatch_block_t block) {
	NSCParameterAssert(block != nil);
	dispatch_sync(dispatch_get_main_queue(), block);
}

void CDDispatchBlockOnMainQueueAsync(dispatch_block_t block) {
	NSCParameterAssert(block != nil);
	dispatch_async(dispatch_get_main_queue(), block);
}

void CDDispatchPossibleBlockOnQueue(dispatch_queue_t queue, dispatch_block_t block) {
	NSCParameterAssert(queue != nil);
	if (block) dispatch_sync(queue, block);
}

void CDDispatchPossibleBlockOnQueueAsync(dispatch_queue_t queue, dispatch_block_t block) {
	NSCParameterAssert(queue != nil);
	if (block) dispatch_async(queue, block);
}

void CDDispatchPossibleBlockOnMainQueue(dispatch_block_t block) {
	CDDispatchPossibleBlockOnQueue(dispatch_get_main_queue(), block);
}

void CDDispatchPossibleBlockOnMainQueueAsync(dispatch_block_t block) {
	CDDispatchPossibleBlockOnQueueAsync(dispatch_get_main_queue(), block);
}


#pragma mark - Executing a Block in Place
void CDExecutePossibleBlock(void (^block)(void)) {
	if (block) block();
}
