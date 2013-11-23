//
//  MyCocos2DClass.m
//  GAP
//
//  Created by Ruben Van Wassenhove on 20/11/13.
//  Copyright 2013 Devine. All rights reserved.
//

#import "StartLayer.h"
#import "AppDelegate.h"

@implementation StartLayer

@synthesize motionManager = _motionManager;
@synthesize s = _s;
@synthesize frequency = _frequency;
@synthesize filteringFactor = _filteringFactor;
@synthesize xGyro = _xGyro;
@synthesize yGyro = _yGyro;

+(id)scene{
    CCScene *scene = [CCScene node];
    StartLayer *layer = [StartLayer node];
    [scene addChild:layer];
    return scene;
}

-(id)init{
    if((self=[super init])){
        self.touchEnabled = YES;
        self.s = [CCDirector sharedDirector].winSize;
        
        self.filteringFactor = .1;
        self.frequency = 60;
        
        self.xGyro = 0;
        self.yGyro = 0;
        
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.gyroUpdateInterval = 1/self.frequency;
        
        if(self.motionManager.isDeviceMotionAvailable){
            [self.motionManager startDeviceMotionUpdates];
        }
        
        [self createMenu];
        [self initPhysics];
        [self scheduleUpdate];
    }
    
    return self;
}

-(void)update:(ccTime)delta{
    CMDeviceMotion *currMotion = self.motionManager.deviceMotion;
    
    CMAttitude *currAttitude = currMotion.attitude;
    float roll = currAttitude.roll;
    float pitch = currAttitude.pitch;
    float yaw = currAttitude.yaw;
    
    NSLog(@"rpy [%0.2f, %0.2f, %0.2f]", roll, pitch, yaw);
    
    self.xGyro = pitch;
    self.yGyro = roll;
}

-(void)initPhysics{
    
}

-(void)createMenu{
    [CCMenuItemFont setFontName:@"GillSans-BoldItalic"];
    [CCMenuItemFont setFontSize:22];
    
    // to avoid a retain-cycle with the menuitem and blocks
	__block id copy_self = self;
    
    CCMenuItem *itemStart = [CCMenuItemFont itemWithString:@"Start" block:^(id sender) {
		
		//LOAD GAME
	}];
    
    CCMenuItem *itemAchievement = [CCMenuItemFont itemWithString:@"Achievements" block:^(id sender) {
		
		//LOAD ACHIEVMENTS
	}];
    
    CCMenu *menu = [CCMenu menuWithItems:itemStart, itemAchievement, nil];
    [menu alignItemsVertically];
    [menu setPosition:ccp(self.s.width/2, self.s.height-40)];
    
    [self addChild:menu z:-1];
}

@end