// UIImage+CDKitt.h
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


@interface UIImage (CDKittImageDrawing)

#pragma mark - Cached Image Drawing
/** @name Cached Image Drawing */
/** Returns a `UIImage` rendered with the drawing code in the block.
 This method does not cache the image object. */
+ (UIImage *)cd_imageForSize:(CGSize)size withDrawingBlock:(void(^)())drawingBlock;
+ (UIImage *)cd_imageForSize:(CGSize)size opaque:(BOOL)opaque withDrawingBlock:(void(^)())drawingBlock;

/** Returns a cached `UIImage` rendered with the drawing code in the block.
 The `UIImage` is cached in an `NSCache` with the identifier provided. */
+ (UIImage *)cd_imageWithIdentifier:(NSString *)identifier forSize:(CGSize)size andDrawingBlock:(void(^)())drawingBlock;
+ (UIImage *)cd_imageWithIdentifier:(NSString *)identifier opaque:(BOOL)opaque forSize:(CGSize)size andDrawingBlock:(void(^)())drawingBlock;

@end

