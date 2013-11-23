//
//  MyCocos2DClass.h
//  GAP
//
//  Created by Ruben Van Wassenhove on 20/11/13.
//  Copyright 2013 Devine. All rights reserved.
//
#include <CoreMotion/CoreMotion.h>

#import "cocos2d.h"
#import "Box2D.h"

#define PTM_RATIO 32.0

@interface StartLayer : CCLayer{
    
}

@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic) float frequency;
@property (nonatomic) float filteringFactor;

@property (nonatomic) float yGyro;
@property (nonatomic) float xGyro;

@property (nonatomic) CGSize s;

+ (id) scene;
-(void) createMenu;

@end