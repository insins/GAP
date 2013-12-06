//
//  GameScene.h
//  Game
//
//  Created by Ruben Van Wassenhove on 26/11/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Pause.h"
#import "Player.h"
#import "Background.h"
#import "World.h"

@import CoreMotion;

@interface GameScene : SKScene

@property (nonatomic, strong) SKNode *pause;
@property (nonatomic, strong) SKNode *player;
@property (nonatomic, strong) SKNode *background;
@property (nonatomic, strong) SKNode *world;

@property (nonatomic) int countUp;
@property (nonatomic) int yPos;
@property (nonatomic) int interval;
@property (nonatomic) int difficulty;

@property (nonatomic) int lives;
@property (nonatomic) int level;

@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic) float frequency;

- (int)lives;
- (void)setLives:(int)lives;

- (int)level;
- (void)setLevel:(int)level;

@end
