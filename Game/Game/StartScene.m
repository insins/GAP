//
//  MyScene.m
//  Game
//
//  Created by Ruben Van Wassenhove on 26/11/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "StartScene.h"

@implementation StartScene

@synthesize gameSceneItem = _gameSceneItem;
@synthesize achievementsSceneItem = _achievementsSceneItem;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        [self createMenu];
    }
    return self;
}

-(void)createMenu{
    
    self.gameSceneItem = [SKLabelNode labelNodeWithFontNamed:FONT];
    [self.gameSceneItem setText:@"Start"];
    [self.gameSceneItem setFontSize:22];
    [self.gameSceneItem setPosition:CGPointMake(CGRectGetMidX(self.frame)+5,self.frame.size.height - 60)];
    [self addChild:self.gameSceneItem];
    
    self.achievementsSceneItem = [SKLabelNode labelNodeWithFontNamed:FONT];
    [self.achievementsSceneItem setText:@"Achievements"];
    [self.achievementsSceneItem setFontSize:22];
    [self.achievementsSceneItem setPosition:CGPointMake(CGRectGetMidX(self.frame)+5,self.frame.size.height - 100)];
    [self addChild:self.achievementsSceneItem];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        if ([self.gameSceneItem containsPoint:location]) {
            // Scene Transition Animation
            SKTransition* reveal = [SKTransition fadeWithDuration:1];
            GameScene* gameScene = [[GameScene alloc] initWithSize:self.frame.size];
            [self.scene.view presentScene:gameScene transition:reveal];
        }else if ([self.achievementsSceneItem containsPoint:location]){
            SKTransition* reveal = [SKTransition fadeWithDuration:1];
            AchievementsScene* achievementsScene = [[AchievementsScene alloc] initWithSize:self.frame.size];
            [self.scene.view presentScene:achievementsScene transition:reveal];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
