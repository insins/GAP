//
//  Enemy.m
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

-(id)initWithLevel:(int)level side:(int)s width:(int)w pos:(CGPoint)p{
    if (self = [super init]) {
        // ---------------------
        // RANDOM ENEMIES PER LEVEL
        // ---------------------
        
        // Aan de hand van het level zullen de enemies aangemaakt worden
        self.level = level;
        self.side = s;
        self.width = w;
        self.position = p;
        
        NSLog(@"position %f", p.x);
        
        // Testen voor een enemy aan te maken
        [self createEnemy];
        
        
        //per level zijn een 2tal verschillende enemies.
        
        //+physicsbody instellen
        
        //default power
        
        self.power = (float)self.level/10;
        
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
    SKPhysicsBody * haaiF = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(88, 36)];
    NSString * skeletvis = @"skeletvis";
    SKPhysicsBody * skeletvisF = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(42, 15)];
    
    // LEVEL 2
    NSString * vliegtuig = @"vliegtuig";
    SKPhysicsBody * vliegtuigF = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(73, 32)];
    NSString * meeuw = @"meeuw";
    SKPhysicsBody * meeuwF = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(54, 23)];
    
    // LEVEL 3
    NSString * satteliet = @"satelliet";
    SKPhysicsBody * sattelietF = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(58, 33)];
    NSString * meteoriet = @"meteoriet";
    SKPhysicsBody * meteorietF = [SKPhysicsBody bodyWithCircleOfRadius:16];
    NSString * ufo = @"ufo";
    SKPhysicsBody * ufoF = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(62, 37)];
    
    // Eerst een switch schrijven die checkt in welk level je zit. 1 = 1e zone, 2 = 2e zone, 3 = 3e zone
    switch (self.level){
            
        case 1 :
            
            // Vijanden toevoegen in de array
            enemies = [[NSMutableArray alloc] initWithObjects:@[haai, haaiF], @[skeletvis, skeletvisF], nil];
            
            [self generateEnemies:enemies];
            
            break;
            
        case 2:
            
            enemies = [[NSMutableArray alloc] initWithObjects:@[vliegtuig, vliegtuigF], @[meeuw, meeuwF], nil];
            
            [self generateEnemies:enemies];
            break;
            
        case 3:
            
            enemies = [[NSMutableArray alloc] initWithObjects:@[satteliet, sattelietF], @[meteoriet, meteorietF], @[ufo, ufoF], nil];
            
            [self generateEnemies:enemies];
            break;
    
    }
}

// Hier worden de Enemies gemaakt
-(void)generateEnemies:(NSMutableArray *)enemies{
    
    // Genereren we een random nummer
    int range = (int)[enemies count];
    int randomNummer = arc4random_uniform(range);
    
    // En dan gaan we kijken welk item staat op de random nummer in de array
    NSArray* vijandInfo = [enemies objectAtIndex:randomNummer];
    
    self.vijand = [vijandInfo objectAtIndex:0];
    
    //NSLog(@"vijand %@", vijand);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.vijand ofType:@"png" inDirectory:@"Enemies"];
    
    self.obj = [SKSpriteNode spriteNodeWithImageNamed:path];
    
    self.physicsBody = [vijandInfo objectAtIndex:1];
    self.physicsBody.dynamic = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = enemieCategory;
    self.physicsBody.contactTestBitMask = playerCategory;
    self.physicsBody.collisionBitMask = 0;
    
    [self addChild:self.obj];
    
    [self runAction:[self actionForType:self.vijand]];
    
}

-(void)shock{
    [self.obj removeFromParent];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@S", self.vijand] ofType:@"png" inDirectory:@"Enemies"];
    
    self.obj = [SKSpriteNode spriteNodeWithImageNamed:path];
    [self addChild:self.obj];
    self.physicsBody = nil;
}

-(void)addProjectile:(CGRect)frame{
    
    if ([self.vijand isEqualToString:@"ufo"]) {
        
        NSLog(@"add projectile");
        //alleen in dit geval projectiel toevoegen
        
        Projectile * pr = [[Projectile alloc] init];
        
        [self addChild:pr];
        
        CGPoint location = CGPointMake(arc4random_uniform(frame.size.width*2)-self.position.x, -600);
        SKAction *actionMove = [SKAction moveTo:location duration:2];
        SKAction *actionMoveDone = [SKAction removeFromParent];
        
        [pr runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    }
}

// -------------------------------------
// Action creeeren voor enemie
// -------------------------------------

-(SKAction*) actionForType:(NSString*)type{
 //laten bewegen adhv meegegeven x en y pos.
 
    int xPos = 0;
    int yPos = 0;
    int dur = 0;
    
    if (self.side == -1) {
        xPos = self.width + 100;
    }else{
        xPos = -100;
    }
    
    yPos = self.position.y;
    
    dur = arc4random_uniform(4) + 2;
    
    SKAction *wait = [SKAction waitForDuration:2];
    SKAction *move = [SKAction moveTo:CGPointMake(xPos, yPos) duration:dur];
 
    return [SKAction sequence:@[wait, move]];
 }

@end
