//
//  GameScene.m
//  Game
//
//  Created by Ruben Van Wassenhove on 26/11/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

@synthesize motionManager = _motionManager;
@synthesize frequency = _frequency;
@synthesize player = _player;
@synthesize background = _background;
@synthesize world = _world;
@synthesize level = _level;
@synthesize interval = _interval;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.world = [[World alloc] initWithFrame:self.frame];
        self.level = 3;
        
        self.backgroundColor = [SKColor whiteColor];
        
        self.frequency = 60;
        
        self.interval = 1;
        self.difficulty = self.level * 150;
        self.countUp = 0;
        
        // --------------------------------------
        // motionmanager instellen
        // --------------------------------------
        
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.gyroUpdateInterval = 1/self.frequency;
        
        if(self.motionManager.isDeviceMotionAvailable){
            [self.motionManager startDeviceMotionUpdates];
        }
        
        [self initPhysics];
        
        self.background = [[Background alloc] init];
        
        self.player = [[Player alloc] init];
        self.player.position = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
        
        [self addChild:self.background];
        [self addChild:self.player];
        [self addChild:self.world];
        
        [self initMicrofoon];
        
        //player stuurt notification als bel te klein is =(gameover)
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver:) name:@"gameover" object:nil];
        
    }
    return self;
}

// --------------------------------------
// Toon de gameover scene
// --------------------------------------

-(void)gameOver:(id)sender{
    
    [self stopRecording];
    
    SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionDown duration:0.5];
    SKScene *gfScene = [[GameFinishedScene alloc] initWithSize:self.frame.size collected:self.collected score:self.score];
    [self.view presentScene:gfScene transition:reveal];
}

// --------------------------------------
// Deze method wordt per frame uitgevoerd
// --------------------------------------

//stel hier de positie van de player in
//beweeg world (waar enemies en items op worden geplaatst)
//voeg enemies en items toe aan world adhv interval

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    CMDeviceMotion *currMotion = self.motionManager.deviceMotion;
    
    CMAttitude *currAttitude = currMotion.attitude;
    //roll mag niet hoger dan .5 en lager dan -.5
    //pitch mag niet hover dan 1 en lager dan 0
    
    float roll = (currAttitude.roll > .5) ? .5 : ((currAttitude.roll < -.5) ? -.5 : currAttitude.roll);
    float pitch = (currAttitude.pitch > 1) ? 1 : ((currAttitude.pitch < 0) ? 0 : currAttitude.pitch);
    
    //setup nieuwe x en y positie van de player adhv roll & pitch
    float newY = self.frame.size.height / 2 - (self.frame.size.height / 2.5) * ((pitch - .75) / 2);
    float newX = self.frame.size.width / 2 + (self.frame.size.width / 3) * 2 * roll;
    
    //vermijden dat bel in 1 keer van de ene kan van het scherm naar de andere kant verspringt
    if (fabsf(self.player.position.x - newX) < self.frame.size.width / 2) self.player.position = CGPointMake(newX, newY);
    
    //bel een beetje roteren als je device rollt
    self.player.zRotation = roll / 2;
    
    //Move bg en world
    self.world.position = CGPointMake(self.world.position.x, self.world.position.y - 1);
    self.yPos++;
    
    //om de zoveel tijd een nieuwe enemie/item toevoegen aan world
    if (!(self.yPos % self.interval)){
        
        self.yPos = 1;
        self.interval = round((1600 - self.difficulty) / 8);
        
        [(World*)self.world updateObjects];
        
        if(self.level < 3){
            //counter bepaalt wanneer je naar volgend level gaat
            self.countUp ++;
            
            if (self.countUp == 16) {
                //naar volgend level gaan. alle waarden terugzetten
                self.level++;
                self.difficulty = self.level * 150;
                self.countUp = 0;
                
            }
        }
        
    }
}

// -------------------------------------
// Hitdetection
// -------------------------------------

// er zijn 5 categorieeen:
// (volgens strength)

// projectile
// enemie
// player
// powerup
// item

-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    //Collision detection
    
    SKPhysicsBody *first, *second;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        first = contact.bodyA;
        second = contact.bodyB;
    }else{
        first = contact.bodyB;
        second = contact.bodyA;
    }
    
    if ((first.categoryBitMask & monsterCategory) != 0 && (second.categoryBitMask & playerCategory) != 0) {
        //player(first) hits monster(second)
        
        SKSpriteNode *monster = (SKSpriteNode *)first.node;
        [monster removeFromParent];
        
        Enemy *en = (Enemy*)monster;
        Player *pl = (Player*)self.player;
        
        [pl scaleBell:pl.size - en.power];
        
    }else if((first.categoryBitMask & playerCategory) != 0 && (second.categoryBitMask & itemCategory) != 0){
        //player(first) hits item(second)
        
        SKSpriteNode *item = (SKSpriteNode *)second.node;
        [item removeFromParent];
        
        self.collected++;
        
    }else if((first.categoryBitMask & playerCategory) != 0 && (second.categoryBitMask & powerupCategory) != 0){
        //player(first) hits power(second)
        Player *pl = (Player *)first.node;
        Item *pwr = (Item *)second.node;
        [pwr removeFromParent];
        
        [pl addPower:pwr.power];
    }
}

-(void)initPhysics{
    //nodig voor gravity en hitdetection
    
    NSLog(@"gravity: %f", self.physicsWorld.gravity.dy);
    self.physicsWorld.contactDelegate = self;
}

// -------------------------------------
// Microfoon initializen
// -------------------------------------

//roep deze functie op vanuit GameScene op het moment dat speler mag blazen

-(void)initMicrofoon{
    
    // Hiermee zet je alles goed voor audio input
    // Daarna ga je naar de functie die kijkt of er effectief geblazen wordt.
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:YES error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
    
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    
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
        //er wordt geblazen
        if (self.blowBells) {
            //maak een nieuwe bel
        }
    }
}

// -------------------------------------
// Levens logica
// -------------------------------------

// Niet meer met leventjes, maar met grootte van bel


// -------------------------------------
// Levels
// -------------------------------------

//er zijn 3 levels, als je hoger raakt dan ga je naar volgend level
//dat wordt bepaald in de update method ^^

- (int)level{
    return _level;
}

- (void)setLevel:(int)level{
    _level = level;
    
    //Setup new bg, enemies & items
    World *w = (World*) self.world;
    w.level = level;
}

@end
