//
//  World.h
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "Enemy.h"
#import "Item.h"

@interface World : SKNode

@property (nonatomic) CGRect frame;
@property (nonatomic) int luck;
@property (nonatomic) int counter;

-(void)updateObjects;
-(id)initWithFrame:(CGRect)frame;

@end
