
//
//  Player.m
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize bell = _bell;
@synthesize fish = _fish;

-(id) init{
    if (self = [super init]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"fish" ofType:@"png" inDirectory:@"player"];
        
        self.fish = [SKSpriteNode spriteNodeWithImageNamed:path];
        
        path = [[NSBundle mainBundle] pathForResource:@"bell" ofType:@"png" inDirectory:@"player"];
        
        self.bell = [SKSpriteNode spriteNodeWithImageNamed:path];
        [self scaleBell:3];
        
        [self addChild:self.bell];
        [self addChild:self.fish];
    
    }
    return self;
}

-(void)scaleBell:(int)lives{
    
    [self.bell setScale:.18+lives*.07];
    [self resetPhysicsBody];
}

-(void)resetPhysicsBody{
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.bell.size.width/2];
    self.physicsBody.dynamic = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = playerCategory;
    self.physicsBody.contactTestBitMask = monsterCategory;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.usesPreciseCollisionDetection = YES;
}

-(void)addPower:(NSString*)type{
    NSLog(@"%@", type);
}

@end
