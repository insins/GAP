//
//  GameScene.h
//  Game
//
//  Created by Ruben Van Wassenhove on 26/11/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PauseLayer.h"
@import CoreMotion;

@interface GameScene : SKScene

@property (nonatomic, strong) SKNode *pauseLayer;
@property (nonatomic, strong) SKSpriteNode *player;

@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic) float frequency;

@property (nonatomic) float yGyro;
@property (nonatomic) float xGyro;

@end
