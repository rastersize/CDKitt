//
//  CDAutoLayoutHelper.m
//  CDKitt
//
//  Created by Aron Cedercrantz on 04-06-2013.
//  Copyright (c) 2013 Aron Cedercrantz. All rights reserved.
//

#import "CDAutoLayoutHelper.h"

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
void CDAddFillingAutoresizedSubview(UIView *view, UIView *subview)
#else
void CDAddFillingAutoresizedSubview(NSView *view, NSView *subview)
#endif
{
	if (subview != nil) {
		[subview setTranslatesAutoresizingMaskIntoConstraints:NO];
		[view addSubview:subview];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(subview);
		[view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[subview]|" options:0 metrics:nil views:views]];
		[view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]|" options:0 metrics:nil views:views]];
	}
}
