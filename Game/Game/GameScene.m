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
        self.level = 1;
        
        self.backgroundColor = [SKColor whiteColor];
        
        self.frequency = 60;
        
        self.interval = 200;
        self.difficulty = self.level * 100;
        self.countUp = 0;
         self.blowBells = YES;
        
        // --------------------------------------
        // motionmanager instellen
        // --------------------------------------
        
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.gyroUpdateInterval = 1/self.frequency;
        
        if(self.motionManager.isDeviceMotionAvailable){
            [self.motionManager startDeviceMotionUpdates];
        }
        
        [self initPhysics];
        
         self.player = [[Player alloc] init];
         self.player.position = CGPointMake(self.frame.size.width/2,100);
         
        self.background = [[Background alloc] init];
        
         [self addChild:self.background];
         [self addChild:self.world];
         
         [self resetBellAndPlayer];
        
        [self initMicrofoon];
        
        //player stuurt notification als bel te klein is =(gameover)
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver:) name:@"gameover" object:nil];
        
    }
    return self;
}

-(void)resetBellAndPlayer{
     [self.player removeFromParent];
     Player * pl = (Player*)self.player;
     
     [pl scaleBell:-1];
     
     NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"lv%ibell",self.level] ofType:@"png" inDirectory:@"player"];
     
     self.nBell = [SKSpriteNode spriteNodeWithImageNamed:path];
     self.nBell.position = CGPointMake(self.size.width/2, -30);
     [self.nBell setScale:.22];
     [self addChild:self.nBell];
     [self addChild:self.player];
}

// --------------------------------------
// Toon de gameover scene
// --------------------------------------

-(void)gameOver:(id)sender{
    
    [self stopRecording];
    
    SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionDown duration:0.5];
    SKScene *gfScene = [[GameFinishedScene alloc] initWithSize:self.frame.size score:self.score];
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
     if (!self.blowBells) {
          
          CMDeviceMotion *currMotion = self.motionManager.deviceMotion;
    
          CMAttitude *currAttitude = currMotion.attitude;
          //roll mag niet hoger dan .5 en lager dan -.5
          //pitch mag niet hover dan 1 en lager dan 0
    
          float roll = (currAttitude.roll > .5) ? .5 : ((currAttitude.roll < -.5) ? -.5 : currAttitude.roll);
          float pitch = (currAttitude.pitch > 1) ? 1 : ((currAttitude.pitch < 0) ? 0 : currAttitude.pitch);
    
          //setup nieuwe x en y positie van de player adhv roll & pitch
          float newY = self.frame.size.height / 2 - (self.frame.size.height / 2.5) * ((pitch - .75) / 2);
          float newX = self.frame.size.width / 2 + (self.frame.size.width / 3) * 2 * roll;
    
          SKAction * movePlayer = [SKAction moveTo:CGPointMake(newX, newY) duration:.3];
          
          //vermijden dat bel in 1 keer van de ene kan van het scherm naar de andere kant verspringt
          if (fabsf(self.player.position.x - newX) < self.frame.size.width / 2) [self.player runAction:movePlayer];
    
          //bel een beetje roteren als je device rollt
          SKAction * rotatePlayer = [SKAction rotateToAngle:roll / 2 duration:.3];
          [self.player runAction:rotatePlayer];
    
          //Move bg en world
          self.world.position = CGPointMake(self.world.position.x, self.world.position.y - 1);
          self.yPos++;
    
          //om de zoveel tijd een nieuwe enemie/item toevoegen aan world
     
          int max = 8;
          
          if (!(self.yPos % self.interval)){
               self.yPos = 1;
               self.interval = round((1600 - self.difficulty) / 8);
          
               //counter bepaalt wanneer je naar volgend level gaat
               self.countUp ++;
               
               Player* pl = (Player*)self.player;
               [pl scaleBell:pl.size-.1];
               
               if (self.countUp == max && self.level < 3){
                    //naar volgend level gaan. alle waarden terugzetten
                    self.level++;
                    self.difficulty = self.level * 100;
                    self.countUp = 0;
                    self.blowBells = YES;
                    
                    [self resetBellAndPlayer];
                    
                    NSLog(@"pause");
               }else if(self.countUp != max - 1){
                    if (!(self.countUp % 4)) {
                         [(World*)self.world updateBubbles];
                    }else{
                         [(World*)self.world updateObjects];
                    }
               }
          }
     }else{
          
          //Alle animaties die nodig zijn voordat de bel moet worden geblazen
          
          Player *p = (Player*) self.player;
          World *w = (World*) self.world;
          
          self.blowBells = YES;
          
          SKAction *movePlayer = [SKAction moveTo:CGPointMake(self.frame.size.width / 2, 200) duration:.2];
          
          [p runAction:movePlayer];
          
          SKAction * moveWorld = [SKAction moveTo:CGPointMake(self.world.position.x, self.world.position.y - self.frame.size.height) duration:2];
          
          [w runAction:moveWorld];
          
          SKAction * moveNewBell = [SKAction moveTo:CGPointMake(self.frame.size.width / 2, 200) duration:.2];
          SKAction * wait = [SKAction waitForDuration:1];
          
          [self.nBell runAction:[SKAction sequence:@[moveNewBell,wait]] completion:^(){
          
               p.level = self.level;
               
               [p.bell setScale:.22];
               p.size = 0;
               [self.nBell removeFromParent];
          
          }];
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
    
    if ((first.categoryBitMask & dangerousCategory) != 0 && (second.categoryBitMask & playerCategory) != 0) {
        //player(first) hits monster(second)
        
        Enemy *en = (Enemy*)first.node;
        Player *pl = (Player*)self.player;
        
        [pl scaleBell:pl.size - en.power];
        
    }else if((first.categoryBitMask & playerCategory) != 0 && (second.categoryBitMask & powerCategory) != 0){
        //player(first) hits power(second)
        Player *pl = (Player *)first.node;
        Power *pwr = (Power *)second.node;
        [pwr removeFromParent];
        
        [pl addPower:pwr.power];
         self.score++;
    }else if((first.categoryBitMask & playerCategory) != 0 && (second.categoryBitMask & itemCategory) != 0){
         
         Player *pl = (Player*)self.player;
         Bell *bl = (Bell*)second.node;
         
         [pl scaleBell:pl.size + bl.power];
         [bl removeFromParent];
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
             Player *pl = (Player*)self.player;
             
             NSLog(@"%f", pl.size);
             if (pl.size != -1) {
                  [pl scaleBell:pl.size + .025];
             }
             
             //bell is opgeblazen, dus het spel mag beginnen
             
             if (pl.size >= 1) {
                  [pl scaleBell:1];
                  self.blowBells = NO;
             }
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
