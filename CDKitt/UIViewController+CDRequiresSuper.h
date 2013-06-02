//
//  UIViewController+CDRequiresSuper.h
//  CDKitt
//
//  Created by Aron Cedercrantz on 03-06-2013.
//  Copyright (c) 2013 Aron Cedercrantz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CDRequiresSuper)

- (void)viewWillAppear:(BOOL)animated CD_REQUIRES_SUPER_ATTRIBUTE;
- (void)viewDidAppear:(BOOL)animated CD_REQUIRES_SUPER_ATTRIBUTE;
- (void)viewWillDisappear:(BOOL)animated CD_REQUIRES_SUPER_ATTRIBUTE;
- (void)viewDidDisappear:(BOOL)animated CD_REQUIRES_SUPER_ATTRIBUTE;
- (void)viewWillLayoutSubviews CD_REQUIRES_SUPER_ATTRIBUTE;
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration CD_REQUIRES_SUPER_ATTRIBUTE;
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration CD_REQUIRES_SUPER_ATTRIBUTE;
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation CD_REQUIRES_SUPER_ATTRIBUTE;
- (void)didReceiveMemoryWarning CD_REQUIRES_SUPER_ATTRIBUTE;

@end
