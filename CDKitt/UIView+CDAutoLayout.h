//
//  UIView+CDAutoLayout.h
//  CDKitt
//
//  Created by Aron Cedercrantz on 04-06-2013.
//  Copyright (c) 2013 Aron Cedercrantz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CDAutoLayout)

/**
 * Add the given view to this view as a subview and autoresizes it to fill the
 * receiving view.
 */
- (void)cd_addFillingAutoresizedSubview:(UIView *)subview;

@end
