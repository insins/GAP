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
@synthesize player = _player;
@synthesize background = _background;
@synthesize world = _world;
@synthesize lives = _lives;
@synthesize level = _level;
@synthesize interval = _interval;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.lives = 3;
        self.level = 1;
        
        self.backgroundColor = [SKColor whiteColor];
        
        self.frequency = 60;
        
        self.interval = 1;
        self.difficulty = 0;
        
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
    
    self.player.position = CGPointMake(self.frame.size.width/2 + (self.frame.size.width/2)*(roll),self.frame.size.height/2 - (self.frame.size.height/4)*(pitch/5));
    
    //[(World*)self.world moveEnemies];
    
    //Move bg en world
    self.world.position = CGPointMake(self.world.position.x,self.world.position.y-1);
    
    int yPos = self.world.position.y;
    
    if (!(yPos%self.interval)) {
        [(World*)self.world updateObjects];
        self.interval = round((800-self.difficulty)/4);
        NSLog(@"%i", self.difficulty);
        if(self.difficulty<270){
            self.difficulty += 1;
        }
        
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
