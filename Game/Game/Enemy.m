//
//  Enemy.m
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

-(id)init{
    if (self = [super init]) {
    
        NSString *path = [[NSBundle mainBundle] pathForResource:@"jelly" ofType:@"png" inDirectory:@"powerups"];
        
        SKSpriteNode *test = [SKSpriteNode spriteNodeWithImageNamed:path];
        
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:test.size.width/2];
        self.physicsBody.dynamic = YES;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.categoryBitMask = monsterCategory;
        self.physicsBody.contactTestBitMask = playerCategory;
        self.physicsBody.collisionBitMask = 0;
        
        [self addChild:test];
        
    }
    
    return self;
}

@end
