//
//  GameScene.m
//  Game
//
//  Created by Ruben Van Wassenhove on 26/11/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

@synthesize motionManager = _motionManager;
@synthesize frequency = _frequency;
@synthesize xGyro = _xGyro;
@synthesize yGyro = _yGyro;
@synthesize player = _player;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
        
        self.frequency = 60;
        
        self.xGyro = 0;
        self.yGyro = 0;
        
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.gyroUpdateInterval = 1/self.frequency;
        
        if(self.motionManager.isDeviceMotionAvailable){
            [self.motionManager startDeviceMotionUpdates];
        }
        
        [self initPhysics];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"spook" ofType:@"png" inDirectory:@"images"];
        
        self.player = [SKSpriteNode spriteNodeWithImageNamed:path];
        
        self.player.position = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
        
        [self addChild:self.player];
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    CMDeviceMotion *currMotion = self.motionManager.deviceMotion;
    
    CMAttitude *currAttitude = currMotion.attitude;
    float roll = currAttitude.roll;
    float pitch = currAttitude.pitch;
    float yaw = currAttitude.yaw;
    
    NSLog(@"rpy [%0.2f, %0.2f, %0.2f]", roll, pitch, yaw);
    
    self.xGyro = pitch;
    self.yGyro = roll;
    
    self.player.position = CGPointMake(self.frame.size.width/2 + (self.frame.size.width/2)*(roll/1.5),self.frame.size.height/2 - (self.frame.size.height/4)*(pitch/1.5));
}

-(void)initPhysics{
    
}

@end
