//
//  MenuLayer.m
//  GAP
//
//  Created by Ruben Van Wassenhove on 23/11/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "MenuLayer.h"

#import "cocos2d.h"
#import "Box2D.h"

@implementation MenuLayer

-(id)initWithSize:(CGSize)size{
    
    if((self=[super init])){
        
        [CCMenuItemFont setFontName:@"GillSans-BoldItalic"];
        [CCMenuItemFont setFontSize:22];
        
        CCMenuItem *start = [CCMenuItemFont itemWithString:@"Back to menu" target:self selector:@selector(showStart)];
        
        CCMenuItem *achievements = [CCMenuItemFont itemWithString:@"Retry" target:self selector:@selector(retry)];
        
        CCMenu *menu = [CCMenu menuWithItems:start, achievements, nil];
        [menu alignItemsVertically];
        [menu setPosition:ccp(size.width/2, size.height-40)];
        
        [self addChild:menu z:-1];
        
    }
    
    return self;
}

-(void)showStart{
    
    CCLayer *layer = [CCLayer node];
    CCScene *start = [SceneFactory createSceneWithBaseLayer:layer];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:start]];
}

-(void)retry{
    
}

@end
