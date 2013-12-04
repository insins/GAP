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
@synthesize lives = _lives;
@synthesize level = _level;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.lives = 3;
        self.level = 1;
        
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
        
        self.world = [[World alloc] initWithFrame:self.frame];
        
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
    
    //NSLog(@"rpy [%0.2f, %0.2f, %0.2f]", roll, pitch, yaw);
    
    self.xGyro = pitch;
    self.yGyro = roll;
    
    self.player.position = CGPointMake(self.frame.size.width/2 + (self.frame.size.width/2)*(roll/1.5),self.frame.size.height/2 - (self.frame.size.height/4)*(pitch/1.5));
    
    //[(World*)self.world moveEnemies];
    
    //Move bg en world
    self.world.position = CGPointMake(self.world.position.x,self.world.position.y-1);
    
    int yPos = self.world.position.y;
    
    if (!(yPos%200)) {
        //NSLog(@"%i: deelbaar", yPos);
        [(World*)self.world updateObjects];
    }
}

-(void)initPhysics{
    NSLog(@"gravity: %f", self.physicsWorld.gravity.dy);
}

- (int)lives{
    return _lives;
}

- (void)setLives:(int)lives{
    _lives = lives;
    
    [(Player*)self.player scaleBell:lives];
}

- (int)level{
    return _level;
}

- (void)setLevel:(int)level{
    _level = level;
    
    //Setup new bg, enemies & items
}

@end
