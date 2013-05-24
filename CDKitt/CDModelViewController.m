//
//  CDViewController.m
//  CDKitt
//
//  Created by Aron Cedercrantz on 25-12-2012.
//  Copyright (c) 2012 Aron Cedercrantz. All rights reserved.
//

#import "CDModelViewController.h"
#import "BlocksKit.h"

@interface CDModelViewController ()
@property (assign, getter = isObservingModel) BOOL observingModel;
@property (strong) NSString *observableModelObservationsIdentifier;
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


#pragma mark - Updating The Controlled View
- (void)updateViewForModelKeyPath:(NSString *)keyPath { /**/ }

- (void)updateView
{
	for (NSString *keyPath in [[self class] observableModelKeyPaths]) {
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
	if (!self.isObservingModel) {
		self.observingModel = YES;
		
		id model = [self observableModel];
		NSArray *keyPaths = [[self class] observableModelKeyPaths];
		
		CDWeakSelf();
		self.observableModelObservationsIdentifier = [model addObserverForKeyPaths:keyPaths task:^(id obj, NSString *keyPath) {
			[weakSelf updateViewForModelKeyPath:keyPath];
		}];
	}
}

- (void)stopObservingModel
{
	id observableModelObservationsIdentifier = self.observableModelObservationsIdentifier;
	if (observableModelObservationsIdentifier) {
		id model = [self observableModel];
		[model removeObserversWithIdentifier:observableModelObservationsIdentifier];
		self.observingModel = NO;
		self.observableModelObservationsIdentifier = nil;
	}
}


@end
