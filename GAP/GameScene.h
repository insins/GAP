//
//  MyCocos2DClass.h
//  GAP
//
//  Created by Ruben Van Wassenhove on 23/11/13.
//  Copyright 2013 Devine. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CoreMotion/CoreMotion.h>

#import "cocos2d.h"
#import "Box2D.h"

@interface GameScene : CCScene

@property (nonatomic) CGSize s;

@property (nonatomic, strong) CCLayer *objectsLayer;
@property (nonatomic, strong) CCSprite *player;

@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic) float frequency;
@property (nonatomic) float filteringFactor;

@property (nonatomic) float yGyro;
@property (nonatomic) float xGyro;

@end
