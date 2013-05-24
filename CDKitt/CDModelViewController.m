//
//  CDViewController.m
//  CDKitt
//
//  Created by Aron Cedercrantz on 25-12-2012.
//  Copyright (c) 2012 Aron Cedercrantz. All rights reserved.
//

#import "CDModelViewController.h"

static void *const kCDModelViewControllerKVOContextModelObject;
static void *const kCDModelViewControllerKVOContextModelKeyPath;


@interface CDModelViewController (/*Private*/)

@property (assign, getter = isObservingModel) BOOL observingModel;
@property (strong, readonly) dispatch_queue_t observationControlQueue;

@end

@implementation CDModelViewController

#pragma mark - View Lifecycle
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self startObservingModel];
	[self updateView];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[self stopObservingModel];
}

- (void)dealloc
{
	[self stopObservingModel];
}


#pragma mark - Updating The Controlled View
- (void)updateViewForModelKeyPath:(NSString *)keyPath { /*NOP*/ }

- (void)updateView
{
	for (NSString *keyPath in self.class.observableModelKeyPaths) {
		[self updateViewForModelKeyPath:keyPath];
	}
}


#pragma mark - Observable Model
- (id)observableModel
{
	return nil;
}

+ (NSArray *)observableModelKeyPaths
{
	return nil;
}

- (void)startObservingModel
{
	dispatch_sync(self.observationControlQueue, ^{
		if (self.isObservingModel == NO) {
			self.observingModel = YES;
			
			[self addObserver:self forKeyPath:CDStringFromSelector(observableModel) options:0 context:kCDModelViewControllerKVOContextModelObject];
			
			id model = self.observableModel;
			NSArray *keyPaths = self.class.observableModelKeyPaths;
			for (NSString *keyPath in keyPaths) {
				[model addObserver:self forKeyPath:keyPath options:0 context:kCDModelViewControllerKVOContextModelKeyPath];
			}
		}
	});
}

- (void)stopObservingModel
{
	dispatch_sync(self.observationControlQueue, ^{
		if (self.isObservingModel) {
			self.observingModel = NO;
			
			[self removeObserver:self forKeyPath:CDStringFromSelector(observableModel) context:kCDModelViewControllerKVOContextModelObject];
			
			id model = self.observableModel;
			NSArray *keyPaths = self.class.observableModelKeyPaths;
			for (NSString *keyPath in keyPaths) {
				[model removeObserver:self forKeyPath:keyPath context:kCDModelViewControllerKVOContextModelKeyPath];
			}
		}
	});
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (context == kCDModelViewControllerKVOContextModelObject) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self updateView];
		});
	} else if (context == kCDModelViewControllerKVOContextModelKeyPath) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self updateViewForModelKeyPath:keyPath];
		});
	}
}

- (dispatch_queue_t)observationControlQueue
{
	static dispatch_queue_t _observationControlQueue = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSString *queueName = [NSString stringWithFormat:@"%@-ObservationControlQueue", CDStringFromClass(self)];
		_observationControlQueue = dispatch_queue_create(queueName.UTF8String, DISPATCH_QUEUE_SERIAL);
	});
	return _observationControlQueue;
}

@end
