//
//  Projectile.m
//  Game
//
//  Created by Ruben Van Wassenhove on 05/01/14.
//  Copyright (c) 2014 Devine. All rights reserved.
//

#import "Projectile.h"

@implementation Projectile

-(id)init{
    if (self = [super init]) {
        self.power = .1;
        
        SKShapeNode * balleke = [[SKShapeNode alloc] init];
        
        CGMutablePathRef myPath = CGPathCreateMutable();
        CGPathAddArc(myPath, NULL, 0,0, 15, 0, M_PI*2, YES);
        balleke.path = myPath;
        
        balleke.fillColor = [SKColor blueColor];
        
        [self addChild:balleke];
        
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:15];
        self.physicsBody.dynamic = YES;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.categoryBitMask = dangerousCategory;
        self.physicsBody.contactTestBitMask = playerCategory;
        self.physicsBody.collisionBitMask = 0;
        
    }
    return self;
}

@end
