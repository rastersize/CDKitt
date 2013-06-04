//
//  NSView+CDAutoLayout.m
//  CDKitt
//
//  Created by Aron Cedercrantz on 04-06-2013.
//  Copyright (c) 2013 Aron Cedercrantz. All rights reserved.
//

#import "NSView+CDAutoLayout.h"
#import "CDAutoLayoutHelper.h"

@implementation NSView (CDAutoLayout)

- (void)cd_addFillingAutoresizedSubview:(NSView *)subview
{
	CDAddFillingAutoresizedSubview(self, subview);
}

@end