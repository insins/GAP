//
//  Player.m
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "Player.h"

@implementation Player

-(id) init{
    if (self = [super init]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"spook" ofType:@"png" inDirectory:@"images"];
    
        SKSpriteNode *fish = [SKSpriteNode spriteNodeWithImageNamed:path];
        
        [self addChild:fish];
        
        path = [[NSBundle mainBundle] pathForResource:@"spook" ofType:@"png" inDirectory:@"images"];
        
        SKSpriteNode *bell = [SKSpriteNode spriteNodeWithImageNamed:path];
        
        [self addChild:bell];
        
    
    }
    return self;
}

-(void)scaleBell{
    
}

@end
