//
//  Enemy.h
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Enemy : SKNode

@property (nonatomic) int level;
@property (nonatomic) float power;

-(id)initWithLevel:(int)level;
-(void)createEnemy;

@end
