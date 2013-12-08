//
//  Player.h
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface Player : SKNode


@property (nonatomic) BOOL canPlayerBlow;

@property (nonatomic) AVAudioRecorder *recorder;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) double lowPassResults;

@property (nonatomic, strong) SKSpriteNode *bell;
@property (nonatomic, strong) SKSpriteNode *fish;

-(void)scaleBell:(int)lives;
-(void)addPower:(NSString*)type;

@end
