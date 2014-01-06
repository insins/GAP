//
//  Background.h
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Gradient.h"

@interface Background : SKNode

@property (nonatomic) int starsStart;

-(id)initWithMaxObjects:(int)m andFrame:(CGRect)frame;
-(void)addStarsAtPos:(CGPoint)p;

@end
