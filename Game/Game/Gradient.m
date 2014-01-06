//
//  Gradient.m
//  Game
//
//  Created by Ruben Van Wassenhove on 06/01/14.
//  Copyright (c) 2014 Devine. All rights reserved.
//

#import "Gradient.h"

@implementation Gradient

+(SKTexture*)gradientWithSize:(const CGSize)SIZE colors:(NSArray*)colors {
    // Hopefully this function would be platform independent one day.
    
    CGContextRef cgcontextref = MyCreateBitmapContext(SIZE.width, SIZE.height);
    NSAssert(cgcontextref != NULL, @"Failed creating context!");
    
    CAGradientLayer* gradient = CAGradientLayer.layer;
    //DLog(@"gradient.contentScale: %f", gradient.contentsScale);
    //gradient.contentsScale = SCALE;
    //DLog(@"gradient.contentScale: %f", gradient.contentsScale);
    gradient.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    
    NSMutableArray* convertedcolors = [NSMutableArray array];
    for (SKColor* skcolor in colors) {
        [convertedcolors addObject:(id)skcolor.CGColor];
    }
    gradient.colors = convertedcolors;
    [gradient renderInContext:cgcontextref];
    
    CGImageRef imageref = CGBitmapContextCreateImage(cgcontextref);
    //DLog(@"imageref pixel size: %zu %zu", CGImageGetWidth(imageref), CGImageGetHeight(imageref));
    
    SKTexture* texture1 = [SKTexture textureWithCGImage:imageref];
    //DLog(@"size of gradient texture: %@", NSStringFromSize(texture1.size));
    
    CGImageRelease(imageref);
    
    CGContextRelease(cgcontextref);
    
    return texture1;
}
CGContextRef MyCreateBitmapContext(const size_t POINTS_W, const size_t POINTS_H/*, const CGFloat SCALE*/) {
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    size_t             bitmapBytesPerRow;
    
    bitmapBytesPerRow   = (POINTS_W * 4);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    bitmapData = NULL;
    
#define kBitmapInfo     kCGImageAlphaPremultipliedLast
    
    CGBitmapInfo bitmapinfo = (CGBitmapInfo)kBitmapInfo;
    context = CGBitmapContextCreate (bitmapData,
                                     POINTS_W,
                                     POINTS_H,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     bitmapinfo
                                     );
    if (context == NULL) {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
        return NULL;
    }
    CGColorSpaceRelease(colorSpace);
    
    return context;
}

@end
