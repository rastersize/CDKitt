//
//  CDViewController.h
//  CDKitt
//
//  Created by Aron Cedercrantz on 25-12-2012.
//  Copyright (c) 2012 Aron Cedercrantz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDModelViewController : UIViewController

#pragma mark - Updating The Controlled View
/**
 Updates the view.
 
 @discussion The `updateView` message is sent to the reciever when the model is updated. The defualt implementation sends the message `updateViewForModelKeyPath:` for all the observed key paths of the model.
 */
- (void)updateView;

@end


@interface CDModelViewController (ForSubclassEyesOnly)

#pragma mark - Updating The Controlled View
/**
 Updates the view for the given model key path.
 
 @discussion The `updateViewForModelKeyPath:` message is sent to the reciever when the model is updated. The defualt implementation does nothing.
 */
- (void)updateViewForModelKeyPath:(NSString *)keyPath;


#pragma mark - Observable Model
/**
 The model object which should be observed.
 
 @discussion Must return an object which is key-value compliant for the key paths returned by `obserableModelKeyPaths`. The default implementation returns `nil`.
 */
- (id)observableModel;

/**
 The key paths of the model object returned by `observableModel` which should be observed.
 
 @discussion The default implemetation return `nil`.
 */
+ (NSArray *)observableModelKeyPaths;

/**
 Start observing the model.
 
 @discussion This message is automatically sent when the view will appear (that is from `viewWillAppear:`).
 */
- (void)startObservingModel;

/**
 Stop observing the model.
 
 @discussion This message is automatically sent when the view has disappeared (that is from `viewDidDisappear:`).
 */
- (void)stopObservingModel;

@end

