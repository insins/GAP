//
//  Gradient.h
//  Game
//
//  Created by Ruben Van Wassenhove on 06/01/14.
//  Copyright (c) 2014 Devine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Gradient : SKTexture

+(SKTexture*)gradientWithSize:(const CGSize)SIZE colors:(NSArray*)colors;

@end
