//
//  Player.m
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "Player.h"

@implementation Player

-(id) init{
    
    if (self = [super init]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"spook" ofType:@"png" inDirectory:@"images"];
    
        SKSpriteNode *fish = [SKSpriteNode spriteNodeWithImageNamed:path];
        
        [self addChild:fish];
        
        path = [[NSBundle mainBundle] pathForResource:@"spook" ofType:@"png" inDirectory:@"images"];
        
        SKSpriteNode *bell = [SKSpriteNode spriteNodeWithImageNamed:path];
        
        [self addChild:bell];
        
        // -------------------------------------
        // Levens logica
        // -------------------------------------
        
        // Je begint met 3 levens ( je kan dan 4 keer in totaal geraakt worden)
        // 3 - 2 - 1 - 0. Wanneer je leven op "-1" komt is het gameover.
        _aantalLevens = 3;
        
        
        // -------------------------------------
        // Blazen
        // -------------------------------------
        [self checkLevens];
        [self checkBlazen];
        
        // Can player blow staat default op false.
        _canPlayerBlow = false;
        
        // Wanneer je het op true zet (bvb hij komt op een tijdstip dat hij de bel groter kan maken en een leven bijmaken)
        
    
    }
    return self;
}
// -------------------------------------
// Blazen goed zetten
// -------------------------------------
-(void)checkBlazen{
    
    // Als hij kan blazen dan zet je alles goed
    if (_canPlayerBlow){
        NSLog(@"je kan blazen");
        
        // Hiermee zet je alles goed voor audio input
        // Daarna ga je naar de functie die kijkt of er effectief geblazen wordt.
        NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
        
        NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                                  [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                  [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
                                  [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                                  nil];
        
        NSError *error;
        
        _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
        
        if (_recorder) {
            [_recorder prepareToRecord];
            _recorder.meteringEnabled = YES;
            [_recorder record];
            _levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
        } else
            NSLog([error description]);
    }
    // Kan hij niet blazen dan gaan we gewoon tracen dat hij niet hoeft te blazen
    else{
        NSLog(@"Speler moet niet blazen");
    }

}


// -------------------------------------
// Functie voor bij het blazen
// -------------------------------------

- (void)levelTimerCallback:(NSTimer *)timer {
	[_recorder updateMeters];
    
	const double ALPHA = 0.05;
	double peakPowerForChannel = pow(10, (0.05 * [_recorder peakPowerForChannel:0]));
	_lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * _lowPassResults;
	
    // Er wordt niet geblazen
	if (0.70 < _lowPassResults < 0.95){
		NSLog(@"no blowing");
    }
    // Er wordt wel geblazen
    else{
        NSLog(@"Blowing");
    }
}

// -------------------------------------
// Functie om levens te checken
// -------------------------------------
-(void)checkLevens{
    
    if(_aantalLevens < 0){
        NSLog(@"Game over");
    }
    else if(_aantalLevens == 3){
        NSLog(@"Er moet niet geblazen worden want full HP");
    }
    else{
        NSLog(@"Er moet geblazen worden want je hebt geen full HP");
        // Hier zet je dan canPlayerBlow op true zodat je kan blazen
        _canPlayerBlow = true;
        
    }
    
    
}

// -------------------------------------
// Functie voor de bel te laten scalen
// -------------------------------------
-(void)scaleBell{
    
}



@end
