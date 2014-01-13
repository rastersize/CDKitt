//
//  NSImage+CDKitt.m
//  CDKitt
//
//  Created by Aron Cedercrantz on 11-11-2012.
//  Copyright (c) 2012 Aron Cedercrantz. All rights reserved.
//

#import "NSImage+CDKitt.h"


// The implementation of the methods in NSImage(CDKittImageDrawing) were
// originally created by David Keegan (@kgn). The copyright notice below applies
// to them. The method names have been slightly modified (adding a `cd_` prefix)
// and fixing some redundant method calls.
//
// See the [original repository](https://github.com/kgn/BBlock/) and
// [blog post](http://kgn.github.com/blog/2012/03/21/caching-drawing-code/) for
// more information.
//
// Copyright (c) 2012 David Keegan
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
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


CD_FIX_CATEGORY_BUG_QA1490(NSImage, CDKittImageDrawing);
@implementation NSImage (CDKittImageDrawing)

+ (NSCache *)drawingCache
{
	static NSCache *cache = nil;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
		cache = [[NSCache alloc] init];
	});
	return cache;
}

+ (NSImage *)cd_imageWithIdentifier:(NSString *)identifier forSize:(NSSize)size flipped:(BOOL)flipped andDrawingBlock:(CDImageDrawingBlock)drawingBlock
{
	NSImage *image = [[self drawingCache] objectForKey:identifier];
	if (image == nil){
		image = [self imageWithSize:size flipped:flipped drawingHandler:^BOOL(NSRect dstRect) {
			drawingBlock();
			return YES;
		}];
		[[[self class] drawingCache] setObject:image forKey:identifier];
	}
	return image;
}

@end
