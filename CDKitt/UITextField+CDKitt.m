// UITextField+CDKitt.m
//
// Copyright (c) 2012 Aron Cedercrantz
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

#import "UITextField+CDKitt.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>


static void *kCDKittUITextFieldShouldDrawInnerShadow;
static void *kCDKittUITextFieldInnerShadowLayer;

@implementation UITextField (CDKitt)

- (BOOL)cd_shouldDrawInnerShadow
{
	NSNumber *shouldDrawInnerShadowNumber = objc_getAssociatedObject(self, kCDKittUITextFieldShouldDrawInnerShadow);
	return [shouldDrawInnerShadowNumber boolValue];
}

- (void)cd_setShouldDrawInnerShadow:(BOOL)shouldDrawInnerShadow
{
	NSNumber *shouldDrawInnerShadowNumber = [NSNumber numberWithBool:shouldDrawInnerShadow];
	objc_setAssociatedObject(self, kCDKittUITextFieldShouldDrawInnerShadow, shouldDrawInnerShadowNumber, OBJC_ASSOCIATION_ASSIGN);
	
	CAGradientLayer *gradient = objc_getAssociatedObject(self, kCDKittUITextFieldInnerShadowLayer);
	if (shouldDrawInnerShadow) {
		if (!gradient) {
			// make a gradient off-white background
			gradient = [CAGradientLayer layer];
			CGRect gradRect = CGRectInset([self bounds], 3, 3);    // Reduce Width and Height and center layer
			gradRect.size.height += 2;  // minimise Bottom shadow, rely on clipping to remove these 2 pts.
			
			gradient.frame = gradRect;
			struct CGColor *topColor = [UIColor colorWithWhite:0.6f alpha:1.0f].CGColor;
			struct CGColor *bottomColor = [UIColor colorWithWhite:0.9f alpha:1.0f].CGColor;
			// We need to use this fancy __bridge object in order to get the array we want.
			gradient.colors = [NSArray arrayWithObjects:(__bridge id)topColor, (__bridge id)bottomColor, nil];
			[gradient setCornerRadius:4.0f];
			[gradient setShadowOffset:CGSizeMake(0, 0)];
			[gradient setShadowColor:[[UIColor whiteColor] CGColor]];
			[gradient setShadowOpacity:1.0f];
			[gradient setShadowRadius:3.0f];
			
			// Now we need to Blur the edges of this layer "so it blends"
			// This rasterizes the view down to 4x4 pixel chunks then scales it back up using bilinear filtering...
			// it's EXTREMELY fast and looks ok if you are just wanting to blur a background view under a modal view.
			// To undo it, just set the rasterization scale back to 1.0 or turn off rasterization.
			[gradient setRasterizationScale:0.25];
			[gradient setShouldRasterize:YES];
			
			objc_setAssociatedObject(self, kCDKittUITextFieldInnerShadowLayer, gradient, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		}
		
		[self.layer insertSublayer:gradient atIndex:0];
	} else {
		[gradient removeFromSuperlayer];
	}
}

@end
