//
//  GameFinishedScene.h
//  Game
//
//  Created by Ruben Van Wassenhove on 07/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "StartScene.h"

@interface GameFinishedScene : SKScene

-(id)initWithSize:(CGSize)size collected:(int)collected score:(int)score;

@end
