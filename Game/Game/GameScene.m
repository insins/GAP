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
@synthesize background = _background;
@synthesize world = _world;

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
        
        self.background = [[Background alloc]init];
        
        self.player = [[Player alloc] init];
        self.player.position = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
        
        self.world = [[World alloc] init];
        
        [self addChild:self.background];
        [self addChild:self.player];
        [self addChild:self.world];
        
    }
    return self;
}

-(void)gameOver{
    
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
    
    [(Player*)self.player scaleBell];
    [(World*)self.world moveEnemies];
    
    //Move bg en world
}

-(void)initPhysics{
    NSLog(@"x: %f", self.physicsWorld.gravity.dx);
    NSLog(@"y: %f", self.physicsWorld.gravity.dy);
}

@end
