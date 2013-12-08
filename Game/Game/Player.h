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

<<<<<<< HEAD
@property (nonatomic) Boolean * canPlayerBlow;
@property (nonatomic) AVAudioRecorder *recorder;
@property (nonatomic) NSTimer *levelTimer;
@property (nonatomic) double lowPassResults;
@property (nonatomic) int aantalLevens;

-(void)scaleBell;
-(void)checkLevens;
-(void)checkBlazen;
=======
@property (nonatomic, strong) SKSpriteNode *bell;
@property (nonatomic, strong) SKSpriteNode *fish;

-(void)scaleBell:(int)lives;
-(void)addPower:(NSString*)type;
>>>>>>> 677b9b79bca4b93ccab25799f9a4b262e3e732bc

@end
