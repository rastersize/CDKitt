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

/**
 Updates the view when there is a change in the model.
 
 @warning Subclasses must call the super implementation.
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context CD_REQUIRES_SUPER_ATTRIBUTE;

@end

