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
    
    
    // LEVEL 2
    NSString * vliegtuig = @"vliegtuig";
    NSString * meeuw = @"meeuw";
    
    // LEVEL 3
    NSString * satteliet = @"satelliet";
    NSString * meteoriet = @"meteoriet";
    NSString * ufo = @"ufo";
    
    // Eerst een switch schrijven die checkt in welk level je zit. 1 = 1e zone, 2 = 2e zone, 3 = 3e zone
    switch (self.level){
            
        case 1 :
            
            // Vijanden toevoegen in de array
            enemies = [[NSMutableArray alloc] initWithObjects:haai, nil];
            
            [self generateEnemies:enemies];
            
            break;
            
        case 2:
            
            enemies = [[NSMutableArray alloc] initWithObjects:vliegtuig, meeuw, nil];
            
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
    int range = (int)[enemies count];
    int randomNummer = arc4random_uniform(range);
    
    // En dan gaan we kijken welk item staat op de random nummer in de array
    self.vijand = [enemies objectAtIndex:randomNummer];
    
    //NSLog(@"vijand %@", vijand);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.vijand ofType:@"png" inDirectory:@"Enemies"];
    
    self.obj = [SKSpriteNode spriteNodeWithImageNamed:path];
    
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.obj.size.width/2];
    self.physicsBody.dynamic = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = enemieCategory;
    self.physicsBody.contactTestBitMask = playerCategory;
    self.physicsBody.collisionBitMask = 0;
    
    [self addChild:self.obj];
    
    //default power
    self.power = self.level/10;
    
    
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

/*-(SKAction*) actionForXPos:(int)xPos yPos:(int)yPos{
 //laten bewegen adhv meegegeven x en y pos.
 
 SKAction *moveLeft = [SKAction moveTo:CGPointMake(xPos - (arc4random_uniform(self.frame.size.width / 8 - 20) + 10), yPos) duration:arc4random_uniform(2) + 1];
 SKAction *moveRight = [SKAction moveTo:CGPointMake(xPos + (arc4random_uniform(self.frame.size.width / 8 - 20) + 10), yPos) duration:arc4random_uniform(2) + 1];
 SKAction *move = [SKAction sequence:@[moveLeft,moveRight]];
 
 return move;
 }*/

@end
