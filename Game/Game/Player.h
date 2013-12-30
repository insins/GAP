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

@property (nonatomic) NSTimer *timer;

@property (nonatomic) float size;
@property (nonatomic) int level;

-(void)scaleBell:(float)size;
-(void)addPower:(NSString*)type;

- (int)level;
- (void)setLevel:(int)level;

@end
