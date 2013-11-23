//
//  MyCocos2DClass.m
//  GAP
//
//  Created by Ruben Van Wassenhove on 20/11/13.
//  Copyright 2013 Devine. All rights reserved.
//

#import "StartScene.h"

@implementation StartScene

-(id)init{
    if((self=[super init])){
        
        self.s = [CCDirector sharedDirector].winSize;
        
        [self createMenu];
        
    }
    
    return self;
}

-(void)createMenu{
    [CCMenuItemFont setFontName:@"GillSans-BoldItalic"];
    [CCMenuItemFont setFontSize:22];
    
    CCMenuItem *start = [CCMenuItemFont itemWithString:@"Start" target:self selector:@selector(showGame)];
    
    CCMenuItem *achievements = [CCMenuItemFont itemWithString:@"Achievements" target:self selector:@selector(showAchievements)];
    
    CCMenu *menu = [CCMenu menuWithItems:start, achievements, nil];
    [menu alignItemsVertically];
    [menu setPosition:ccp(self.s.width/2, self.s.height-80)];
    
    [self addChild:menu z:-1];
}

-(void) showAchievements{
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[AchievementsScene alloc] init]]];
}

-(void) showGame{
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[GameScene alloc] init]]];
}

@end