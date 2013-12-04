//
//  Player.h
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Player : SKNode

@property (nonatomic, strong) SKSpriteNode *bell;
@property (nonatomic, strong) SKSpriteNode *fish;

-(void)scaleBell:(int)lives;
-(void)addPower:(NSString*)type;

@end
