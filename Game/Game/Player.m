
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

-(id) init{
    
    if (self = [super init]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"fish" ofType:@"png" inDirectory:@"player"];
        
        self.fish = [SKSpriteNode spriteNodeWithImageNamed:path];
        
        path = [[NSBundle mainBundle] pathForResource:@"bell" ofType:@"png" inDirectory:@"player"];
        
        self.bell = [SKSpriteNode spriteNodeWithImageNamed:path];
        
        //size instellen en scalen naar juiste waarde
        [self scaleBell:1];
        
        // Wanneer je het op true zet (bvb hij komt op een tijdstip dat hij de bel groter kan maken en een leven bijmaken)

        [self addChild:self.bell];
        [self addChild:self.fish];
    
    }
    return self;
}

// -------------------------------------
// Functie voor de bel te laten scalen
// -------------------------------------

-(void)scaleBell:(float)size{
    
    //bell scalen adhv aantal lives
    self.size = size;
    SKAction *scale = [SKAction scaleTo:.22 + self.size * .28 duration:.3];
    
    [self.bell runAction:scale completion:^(){
        [self resetPhysicsBody];
        
        //als bell te klein is = game over
        if (self.size <= 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"gameover" object:self];
        }
    }];
    
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
