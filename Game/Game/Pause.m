//
//  Pause.m
//  Game
//
//  Created by Ruben Van Wassenhove on 26/11/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "Pause.h"

@implementation Pause

-(id)initWithSize:(CGSize)size{
    
    if((self=[super init])){
        
        self.menuSceneItem = [SKLabelNode labelNodeWithFontNamed:FONT];
        [self.menuSceneItem setText:@"Menu"];
        [self.menuSceneItem setFontSize:22];
        [self.menuSceneItem setPosition:CGPointMake(CGRectGetMidX(self.frame)+5,self.frame.size.height - 60)];
        [self addChild:self.menuSceneItem];
        
        self.resumeItem = [SKLabelNode labelNodeWithFontNamed:FONT];
        [self.resumeItem setText:@"Menu"];
        [self.resumeItem setFontSize:22];
        [self.resumeItem setPosition:CGPointMake(CGRectGetMidX(self.frame)+5,self.frame.size.height - 60)];
        [self addChild:self.resumeItem];
        
        self.restartItem = [SKLabelNode labelNodeWithFontNamed:FONT];
        [self.restartItem setText:@"Menu"];
        [self.restartItem setFontSize:22];
        [self.restartItem setPosition:CGPointMake(CGRectGetMidX(self.frame)+5,self.frame.size.height - 60)];
        [self addChild:self.restartItem];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        if ([self.menuSceneItem containsPoint:location]) {
            // Scene Transition Animation
            SKTransition* reveal = [SKTransition fadeWithDuration:1];
            StartScene* startScene = [[StartScene alloc] initWithSize:self.frame.size];
            [self.scene.view presentScene:startScene transition:reveal];
        }else if ([self.resumeItem containsPoint:location]){
            //remove pause menu
            
        }else if([self.restartItem containsPoint:location]){
            //restart game and remove pause menu
            
        }
    }
}

@end
