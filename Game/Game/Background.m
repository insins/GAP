//
//  Background.m
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "Background.h"

@implementation Background

-(id)initWithMaxObjects:(int)m andFrame:(CGRect)frame{
    if (self = [super init]) {
        
        int w = frame.size.width;
        
        UIColor * startColor = [UIColor colorWithRed:21.0/255.0 green:103.0/255.0 blue:137.0/255.0 alpha:1.0];
        UIColor * secondColor = [UIColor colorWithRed:37.0/255.0 green:144.0/255.0 blue:143.0/255.0 alpha:1.0];
        UIColor * thirdColor = [UIColor colorWithRed:75.0/255.0 green:192.0/255.0 blue:154.0/255.0 alpha:1.0];
        UIColor * endColor = [UIColor colorWithRed:234.0/255.0 green:228.0/255.0 blue:191.0/255.0 alpha:1.0];
        
        int height1 = m * round((1600 - 100) / 8) + frame.size.height;
        SKTexture * gradient = [Gradient gradientWithSize:CGSizeMake(w*2, height1) colors:@[startColor, secondColor, thirdColor, endColor]];
        SKSpriteNode * rect = [[SKSpriteNode alloc] initWithTexture:gradient];
        rect.position = CGPointMake(0, height1 * .5);
        [self addChild:rect];
        
        startColor = endColor;
        secondColor = [UIColor colorWithRed:67.0/255.0 green:174.0/255.0 blue:192.0/255.0 alpha:1.0];
        thirdColor = [UIColor colorWithRed:21.0/255.0 green:103.0/255.0 blue:137.0/255.0 alpha:1.0];
        endColor = [UIColor colorWithRed:16.0/255.0 green:75.0/255.0 blue:99.0/255.0 alpha:1.0];

        int height2 = m * round((1600 - 200) / 8) + frame.size.height;
        gradient = [Gradient gradientWithSize:CGSizeMake(w*2, height2) colors:@[startColor, secondColor, thirdColor, endColor]];
        rect = [[SKSpriteNode alloc] initWithTexture:gradient];
        rect.position = CGPointMake(0, height2 * .5 + height1);
        [self addChild:rect];

        startColor = endColor;
        endColor = [UIColor colorWithRed:3.0/255.0 green:14.0/255.0 blue:19.0/255.0 alpha:1.0];
        
        int height3 = m * round((2000) / 8) + frame.size.height;
        gradient = [Gradient gradientWithSize:CGSizeMake(w*2, height3) colors:@[startColor, endColor]];
        rect = [[SKSpriteNode alloc] initWithTexture:gradient];
        rect.position = CGPointMake(0, height3 * .5 + height1 + height2);
        [self addChild:rect];
        
        
    }
    return self;
}

@end
