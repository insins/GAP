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
        
        SKNode *test = [SKSpriteNode spriteNodeWithImageNamed:path];
        
        [self addChild:test];
        
    }
    
    return self;
}

@end
