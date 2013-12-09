//
//  GameFinishedScene.m
//  Game
//
//  Created by Ruben Van Wassenhove on 07/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "GameFinishedScene.h"

@implementation GameFinishedScene

-(id)initWithSize:(CGSize)size score:(int)score{
    
    if (self = [super initWithSize:size]) {
    
        NSLog(@"game over");
        
        self.backgroundColor = [SKColor redColor];
        
        SKAction * waitAction = [SKAction waitForDuration:3.0];
        SKAction *transition = [SKAction runBlock:^{
            SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
            SKScene *scene = [[StartScene alloc] initWithSize:size];
            [self.view presentScene:scene transition:reveal];
        }];
        
        [self runAction:[SKAction sequence:@[waitAction, transition]]];
    
    }
    return self;
}

@end
