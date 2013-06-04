//
//  UIView+CDAutoLayout.m
//  CDKitt
//
//  Created by Aron Cedercrantz on 04-06-2013.
//  Copyright (c) 2013 Aron Cedercrantz. All rights reserved.
//

#import "UIView+CDAutoLayout.h"
#import "CDAutoLayoutHelper.h"

@implementation UIView (CDAutoLayout)

- (void)cd_addFillingAutoresizedSubview:(UIView *)subview
{
	CDAddFillingAutoresizedSubview(self, subview);
}


@end
