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


#pragma mark Generic
#import <CDKitt/CDKittAttributes.h>
#import <CDKitt/CDKittMacros.h>
#import <CDKitt/CDKittTypes.h>

#import <CDKitt/NSFileManager+CDKitt.h>

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
	#pragma mark - iOS Specific
	#import <CDKitt/UIImage+CDKitt.h>
	#import	<CDKitt/UITextField+CDKitt.h>
	#import <CDKitt/UIView+CDAutoLayout.h>
	#import <CDKitt/UIViewController+CDRequiresSuper.h>
	#import <CDKitt/CDModelViewController.h>
#else
	#pragma mark - OS X Specific
	#import <CDKitt/NSImage+CDKitt.h>
	#import <CDKitt/NSView+CDAutoLayout.h>
#endif
