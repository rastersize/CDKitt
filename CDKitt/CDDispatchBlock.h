//
//  CDDispatchBlock.h
//  CDKitt
//
//  Created by Aron Cedercrantz on 13/01/14.
//  Copyright (c) 2014 Aron Cedercrantz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDKittTypes.h"


#pragma mark - Dispatching Blocks on Queues
/** @name Dispatching Blocks on Queues */
/// Dispatch a block on the main queue synchronously.
extern inline void CDDispatchBlockOnMainQueue(dispatch_block_t block);

/// Dispatch a block on the main queue asynchronously.
extern inline void CDDispatchBlockOnMainQueueAsync(dispatch_block_t block);

/// Dispatch a _block_, unless it is `nil` on the given _queue_ synchronously.
extern inline void CDDispatchPossibleBlockOnQueue(dispatch_queue_t queue, dispatch_block_t block);

/// Dispatch a _block_, unless it is `nil` on the given _queue_ asynchronously.
extern inline void CDDispatchPossibleBlockOnQueueAsync(dispatch_queue_t queue, dispatch_block_t block);

/// Dispatch a _block_, unless it is `nil` on the main queue synchronously.
extern inline void CDDispatchPossibleBlockOnMainQueue(dispatch_block_t block);

/// Dispatch a _block_, unless it is `nil` on the main queue asynchronously.
extern inline void CDDispatchPossibleBlockOnMainQueueAsync(dispatch_block_t block);


#pragma mark - Executing a Block in Place
/** @name Executing a Block in Place */
/// Execute a block unless it is `nil`.
extern inline void CDExecutePossibleBlock(CDVoidBlock block);