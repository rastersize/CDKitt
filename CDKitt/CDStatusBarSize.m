//
//  CDView.m
//  CDKitt
//
//  Created by Aron Cedercrantz on 11/01/14.
//  Copyright (c) 2014 Aron Cedercrantz. All rights reserved.
//

#import "CDStatusBarSize.h"

// Based on a hack by MattDiPasquale
// http://stackoverflow.com/a/16598350/12917
CGSize CDStatusBarSize()
{
    CGSize statusBarSize = UIApplication.sharedApplication.statusBarFrame.size;
    if (statusBarSize.width < statusBarSize.height) {
		statusBarSize.height = statusBarSize.width;
		statusBarSize.width = statusBarSize.height;
	}
	return statusBarSize;
}


CGFloat CDStatusBarHeight()
{
	return CDStatusBarSize().height;
}


CGFloat CDStatusBarWidth()
{
    return CDStatusBarSize().width;
}
