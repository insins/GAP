//
//  Bell.h
//  Game
//
//  Created by Ruben Van Wassenhove on 22/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Bell : SKNode

@property (nonatomic) float power;

-(id)initWithLevel:(int)level;

@end
