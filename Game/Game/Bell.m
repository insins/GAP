//
//  Bell.m
//  Game
//
//  Created by Ruben Van Wassenhove on 22/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "Bell.h"

@implementation Bell

-(id)initWithLevel:(int)level{
    if (self = [super init]) {
    
        int randomNummer = arc4random_uniform(3)+1;
    
        self.power = (float)randomNummer/5;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"lv%iitem%i", level, randomNummer] ofType:@"png" inDirectory:@"items"];
        
        SKSpriteNode* obj = [SKSpriteNode spriteNodeWithImageNamed:path];
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:obj.size.width/2];
        self.physicsBody.categoryBitMask = itemCategory;
    
        self.physicsBody.dynamic = YES;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.contactTestBitMask = playerCategory;
        self.physicsBody.collisionBitMask = 0;
    
        [self addChild:obj];
    }
    return self;
}

@end
