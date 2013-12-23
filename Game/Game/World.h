//
//  World.h
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "Enemy.h"
#import "Power.h"
#import "Bell.h"

@interface World : SKNode

@property (nonatomic) CGRect frame;
@property (nonatomic) int luck;
@property (nonatomic) int level;

-(void)updateObjects;
-(void)updateBubbles;
-(id)initWithFrame:(CGRect)frame;

- (int)level;
- (void)setLevel:(int)level;

@end
