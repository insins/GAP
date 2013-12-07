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
        self.difficulty = 1;
        self.countUp = 0;
        
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.gyroUpdateInterval = 1/self.frequency;
        
        if(self.motionManager.isDeviceMotionAvailable){
            [self.motionManager startDeviceMotionUpdates];
        }
        
        [self initPhysics];
        
        self.background = [[Background alloc] init];
        
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
    SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionDown duration:0.5];
    SKScene *gfScene = [[GameFinishedScene alloc] initWithSize:self.frame.size collected:self.collected score:self.score];
    [self.view presentScene:gfScene transition:reveal];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    CMDeviceMotion *currMotion = self.motionManager.deviceMotion;
    
    CMAttitude *currAttitude = currMotion.attitude;
    float roll = (currAttitude.roll > .5) ? .5 : ((currAttitude.roll < -.5) ? -.5 : currAttitude.roll);
    float pitch = (currAttitude.pitch > 1) ? 1 : ((currAttitude.pitch < 0) ? 0 : currAttitude.pitch);
    
    float newY = self.frame.size.height / 2 - (self.frame.size.height / 2.5) * ((pitch - .75) / 2);
    float newX = self.frame.size.width / 2 + (self.frame.size.width / 3) * 2 * roll;
    
    if (fabsf(self.player.position.x - newX) < self.frame.size.width / 2) self.player.position = CGPointMake(newX, newY);
    
    self.player.zRotation = roll / 2;
    
    //Move bg en world
    self.world.position = CGPointMake(self.world.position.x, self.world.position.y - 1);
    self.yPos++;
    
    if (!(self.yPos % self.interval)){
        
        self.yPos = 1;
        self.interval = round((3200 - self.difficulty) / 8);
        [(World*)self.world updateObjects];
        
        int new = self.difficulty + 60;
        if(new < 1500){
            self.difficulty = new;
        }else if(self.level < 3){
            self.countUp ++;
            if (self.countUp == 16 * self.level) {
                
                self.level++;
                self.difficulty = (self.level - 1) * 128;
                self.countUp = 0;
            }
        }
        
    }
}

-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    SKPhysicsBody *first, *second;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        first = contact.bodyA;
        second = contact.bodyB;
    }else{
        first = contact.bodyB;
        second = contact.bodyA;
    }
    
    if ((first.categoryBitMask & monsterCategory) != 0 && (second.categoryBitMask & playerCategory) != 0) {
        SKSpriteNode *monster = (SKSpriteNode *)first.node;
        [monster removeFromParent];

        self.lives--;
        
    }else if((first.categoryBitMask & playerCategory) != 0 && (second.categoryBitMask & itemCategory) != 0){
        SKSpriteNode *item = (SKSpriteNode *)second.node;
        [item removeFromParent];
        
        self.collected++;
        
    }
}

-(void)initPhysics{
    NSLog(@"gravity: %f", self.physicsWorld.gravity.dy);
    self.physicsWorld.contactDelegate = self;
}

- (int)lives{
    return _lives;
}

- (void)setLives:(int)lives{
    if (lives > 0) {
        _lives = lives;
        [(Player*)self.player scaleBell:lives];
    }else{
        [self gameOver];
    }
}

- (int)level{
    return _level;
}

- (void)setLevel:(int)level{
    _level = level;
    
    //Setup new bg, enemies & items
}

@end
