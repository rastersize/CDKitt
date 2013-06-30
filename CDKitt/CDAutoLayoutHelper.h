//
//  CDAutoLayoutHelper.h
//  CDKitt
//
//  Created by Aron Cedercrantz on 04-06-2013.
//  Copyright (c) 2013 Aron Cedercrantz. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
extern void CDAddFillingAutoresizedSubview(UIView *view, UIView *subview);
#else
extern void CDAddFillingAutoresizedSubview(NSView *view, NSView *subview);
#endif