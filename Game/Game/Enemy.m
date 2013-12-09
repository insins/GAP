//
//  Enemy.m
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

-(id)initWithLevel:(int)level{
    if (self = [super init]) {
        // ---------------------
        // RANDOM ENEMIES PER LEVEL
        // ---------------------
        
        // Aan de hand van het level zullen de enemies aangemaakt worden
        self.level = level;
        
        // Testen voor een enemy aan te maken
        [self createEnemy];
        
        
        //per level zijn een 2tal verschillende enemies.
        
        //+physicsbody instellen
        self.power = .1;
        
    }
    
    return self;
}

// In deze functie maakt hij een random nummer aan
// Daarna zal hij adhv het level de nummer doorgeven
// En in de andere functie zal hij dan aan de hand van het random nummer de enemy spawnen

-(void)createEnemy{
    
    // We maken een array aan waar we de vijanden gaan insteken
    // Array maken waar alle vijanden inzitten
    NSMutableArray *enemies = [[NSMutableArray alloc] init];
    
   // Vijanden aanmaken
    // LEVEL 1
    NSString * haai = @"haai";
    NSString * skeletvis = @"skeletvis";
    
    // LEVEL 2
    NSString * vliegtuig = @"vliegtuig";
    NSString * zeemeeuw = @"zeemeeuw";
    
    // LEVEL 3
    NSString * satteliet = @"satteliet";
    NSString * meteoriet = @"meteoriet";
    NSString * ufo = @"ufo";
    
    // Eerst een switch schrijven die checkt in welk level je zit. 1 = 1e zone, 2 = 2e zone, 3 = 3e zone
    switch (self.level){
            
        case 1 :
            
            // Vijanden toevoegen in de array
            enemies = [[NSMutableArray alloc] initWithObjects:haai, skeletvis, nil];
            
            [self generateEnemies:enemies];
            
            break;
            
        case 2:
            
            enemies = [[NSMutableArray alloc] initWithObjects:vliegtuig, zeemeeuw, nil];
            
            [self generateEnemies:enemies];
            break;
            
        case 3:
            
            enemies = [[NSMutableArray alloc] initWithObjects:satteliet, meteoriet, ufo, nil];
            
            [self generateEnemies:enemies];
            break;
    
    }
}

// Hier worden de Enemies gemaakt
-(void)generateEnemies:(NSMutableArray *)enemies{
    
    // Genereren we een random nummer
    int minNummer = 0;
    int maxNummer = [enemies count];
    int range = maxNummer - minNummer;
    int randomNummer = arc4random_uniform(range) + minNummer;
    
    // En dan gaan we kijken welk item staat op de random nummer in de array
    NSString * vijand = [enemies objectAtIndex:randomNummer];
    
    NSLog(@"vijand %@", vijand);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"png" inDirectory:@"Enemies"];
    
    SKSpriteNode *test = [SKSpriteNode spriteNodeWithImageNamed:path];
    
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:test.size.width/2];
    self.physicsBody.dynamic = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = monsterCategory;
    self.physicsBody.contactTestBitMask = playerCategory;
    self.physicsBody.collisionBitMask = 0;
    
    [self addChild:test];
}

@end
