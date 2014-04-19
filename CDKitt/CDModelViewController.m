// CDKitt
//
// The MIT License (MIT)
//
// Copyright (c) 2014 Aron Cedercrantz
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
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "CDModelViewController.h"

static void *const CDModelViewControllerKVOContextModelObject;
static void *const CDModelViewControllerKVOContextModelKeyPath;


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
			
			[self addObserver:self forKeyPath:CDStringFromSelector(observableModel) options:0 context:CDModelViewControllerKVOContextModelObject];
			
			id model = self.observableModel;
			NSArray *keyPaths = self.class.observableModelKeyPaths;
			for (NSString *keyPath in keyPaths) {
				[model addObserver:self forKeyPath:keyPath options:0 context:CDModelViewControllerKVOContextModelKeyPath];
			}
		}
	});
}

- (void)stopObservingModel
{
	dispatch_sync(self.observationControlQueue, ^{
		if (self.isObservingModel) {
			self.observingModel = NO;
			
			[self removeObserver:self forKeyPath:CDStringFromSelector(observableModel) context:CDModelViewControllerKVOContextModelObject];
			
			id model = self.observableModel;
			NSArray *keyPaths = self.class.observableModelKeyPaths;
			for (NSString *keyPath in keyPaths) {
				[model removeObserver:self forKeyPath:keyPath context:CDModelViewControllerKVOContextModelKeyPath];
			}
		}
	});
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (context == CDModelViewControllerKVOContextModelObject) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self updateView];
		});
	} else if (context == CDModelViewControllerKVOContextModelKeyPath) {
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
