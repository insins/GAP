//
//  MyCocos2DClass.m
//  GAP
//
//  Created by Ruben Van Wassenhove on 23/11/13.
//  Copyright 2013 Devine. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

@synthesize motionManager = _motionManager;
@synthesize s = _s;
@synthesize frequency = _frequency;
@synthesize filteringFactor = _filteringFactor;
@synthesize xGyro = _xGyro;
@synthesize yGyro = _yGyro;
@synthesize player = _player;

-(id)init{
    if((self=[super init])){
        
        NSLog(@"init");
        
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
        
        [self initPhysics];
        [self scheduleUpdate];
         
         NSString *path = [[NSBundle mainBundle] pathForResource:@"spook" ofType:@"png" inDirectory:@"images"];
         
         self.player = [CCSprite spriteWithFile:path];
         self.player.position = ccp(self.s.width/2,self.s.height/2);
         
        self.objectsLayer = [CCLayer node];
        [self.objectsLayer addChild:self.player];
        
        [self addChild:self.objectsLayer];
         
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
    
    self.player.position = ccp(self.s.width/2 + (self.s.width/2)*(roll/1.5),self.s.height/2 - (self.s.height/4)*(pitch/1.5));
}

-(void)initPhysics{
    
}

@end
