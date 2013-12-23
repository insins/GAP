
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
@synthesize level = _level;

-(id) init{
    
    if (self = [super init]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"lv1fish" ofType:@"png" inDirectory:@"player"];
        
        self.fish = [SKSpriteNode spriteNodeWithImageNamed:path];
        
        path = [[NSBundle mainBundle] pathForResource:@"lv1bell" ofType:@"png" inDirectory:@"player"];
        
        self.bell = [SKSpriteNode spriteNodeWithImageNamed:path];
        [self.bell setScale:.1];
        self.size = -1;
        [self resetPhysicsBody];
        
        //size instellen en scalen naar juiste waarde
        
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
    //NSLog(@"scale");
    
    SKAction *scale;
    
    if (size == -1) {
        scale = [SKAction scaleTo:.1 duration:.3];
    }else{
        scale = [SKAction scaleTo:.22 + self.size * .28 duration:.3];
    }
    
    [self.bell runAction:scale completion:^(){
        //NSLog(@"gescaled");
        
        [self resetPhysicsBody];
        
        //als bell te klein is = game over
        if (self.size <= 0 && self.size != -1) {
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
    //NSLog(@"%@", type);
}

-(void)resetPhysicsBody{
    //physicsbody instellen adh grootte van bel
    
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.bell.size.width/2];
    self.physicsBody.dynamic = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = playerCategory;
    self.physicsBody.contactTestBitMask = dangerousCategory;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.usesPreciseCollisionDetection = YES;
}

-(int)level{
    return _level;
}

-(void)setLevel:(int)level{
    
    _level = level;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"lv%ifish",level] ofType:@"png" inDirectory:@"player"];
    
    self.fish = [SKSpriteNode spriteNodeWithImageNamed:path];
    
    path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"lv%ibell",level] ofType:@"png" inDirectory:@"player"];
    
    self.bell = [SKSpriteNode spriteNodeWithImageNamed:path];
    
    [self removeAllChildren];

    [self.bell setScale:.22 + self.size * .28];
    [self resetPhysicsBody];
    
    [self addChild:self.bell];
    [self addChild:self.fish];
    
}

@end
