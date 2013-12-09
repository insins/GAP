
//
//  Player.m
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize bell = _bell;
@synthesize fish = _fish;
@synthesize canPlayerBlow = _canPlayerBlow;

-(id) init{
    
    if (self = [super init]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"fish" ofType:@"png" inDirectory:@"player"];
        
        self.fish = [SKSpriteNode spriteNodeWithImageNamed:path];
        
        path = [[NSBundle mainBundle] pathForResource:@"bell" ofType:@"png" inDirectory:@"player"];
        
        self.bell = [SKSpriteNode spriteNodeWithImageNamed:path];
        [self scaleBell:3];
        
        // Wanneer je het op true zet (bvb hij komt op een tijdstip dat hij de bel groter kan maken en een leven bijmaken)

        [self addChild:self.bell];
        [self addChild:self.fish];
        
        [self initMicrofoon];
    
    }
    return self;
}

// -------------------------------------
// Blazen goed zetten
// -------------------------------------

//roep deze functie op vanuit GameScene op het moment dat speler mag blazen

-(void)initMicrofoon{
        
        // Hiermee zet je alles goed voor audio input
        // Daarna ga je naar de functie die kijkt of er effectief geblazen wordt.
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:YES error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
    
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];;
    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat: 44100.0], AVSampleRateKey, [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey, [NSNumber numberWithInt: 1], AVNumberOfChannelsKey, [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey, nil];
        
    NSError *error;
        
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
        
    if ([self.recorder prepareToRecord]) {
        self.recorder.meteringEnabled = YES;
            
        if ([self.recorder record]) {
            NSLog(@"record");
            self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
        }
            
    } else {
        NSLog(@"%@", [error description]);
    }

}

-(void)stopRecording{
    [self.timer invalidate];
    self.timer = nil;
}

// -------------------------------------
// Functie voor bij het blazen
// -------------------------------------

- (void)levelTimerCallback:(NSTimer *)timer {
	[self.recorder updateMeters];
    
	const double ALPHA = 0.05;
	double peakPowerForChannel = pow(10, (0.05 * [self.recorder peakPowerForChannel:0]));
	self.lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * self.lowPassResults;
    
    // Er wordt geblazen
	if (self.lowPassResults > 0.70){
        //event uitsturen om leven te verhogen
        if (self.canPlayerBlow){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"blow" object:self];
        }
    }
}

// -------------------------------------
// Functie voor de bel te laten scalen
// -------------------------------------

-(void)scaleBell:(int)lives{
    
    //bell scalen adhv aantal lives
    [self.bell setScale:.18+lives*.07];
    [self resetPhysicsBody];
}

// -------------------------------------
// Functie om power te geven aan player
// -------------------------------------

-(void)addPower:(NSString*)type{
    //power geven aan player
    //= visuals aanpassen en meer player intput creeren
    NSLog(@"%@", type);
}

-(void)resetPhysicsBody{
    //physicsbody instellen adh grootte van bel
    
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.bell.size.width/2];
    self.physicsBody.dynamic = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = playerCategory;
    self.physicsBody.contactTestBitMask = monsterCategory;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.usesPreciseCollisionDetection = YES;
}

@end
