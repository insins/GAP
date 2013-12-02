//
//  Pause.h
//  Game
//
//  Created by Ruben Van Wassenhove on 26/11/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "StartScene.h"

@interface Pause : SKNode

@property(nonatomic, strong) SKLabelNode* menuSceneItem;
@property(nonatomic, strong) SKLabelNode* resumeItem;
@property(nonatomic, strong) SKLabelNode* restartItem;

@end
