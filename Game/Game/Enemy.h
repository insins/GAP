//
//  Enemy.h
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Projectile.h"

@interface Enemy : SKNode

@property (nonatomic) int level;
@property (nonatomic) int side;
@property (nonatomic) int width;
@property (nonatomic) float power;
@property (nonatomic, strong) NSString * vijand;
@property (nonatomic, strong) SKSpriteNode *obj;

-(id)initWithLevel:(int)level side:(int)s width:(int)w pos:(CGPoint)p;
-(void)createEnemy;
-(void)addProjectile:(CGRect)frame;

@end
