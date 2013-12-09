//
//  World.m
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "World.h"

// -------------------------------------
// World class
// -------------------------------------

//World is de node die over tijd steeds naar onder beweegt
//hier worden de items en enemies op toegevoegd

@implementation World

@synthesize frame = _frame;
@synthesize level = _level;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super init]) {
        self.frame = frame;
    }
    return self;
}

// -------------------------------------
// method om random een item/enemie/power
// toe te voegen
// -------------------------------------

// wordt opgeroepen in GameScene class

-(void)updateObjects{
    
    //bepalen of je bad luck/good luck/neutraal
    self.luck = (self.luck <= 2) ? round(arc4random_uniform(16)) + 3 : ((self.luck >= 13) ? round(arc4random_uniform(12)) + 1 : round(arc4random_uniform(16)) + 1);
    
    //x en y pos instellen van element die aan stage moet worden toegevoegd
    int xPos = arc4random_uniform(self.frame.size.width - 60) + 30;
    xPos = (xPos > self.frame.size.width - 20) ? self.frame.size.width - 20 : ((xPos < 20) ? 20 : xPos);
    int yPos = self.frame.size.height - self.position.y;
    
    if (self.luck <= 2) {
        //good luck: item aan stage toevoegen
        
        //item aanmaken en toevoegen aan stage
        SKNode *pwr = [self nodeWithType:@"p" xPos:xPos yPos:yPos];
        [self addChild:pwr];
        
    }else if(self.luck >= 9){
        //bad luck: enemie aan stage toevoegen
        
        //add enemy
        
        SKNode *nmy = [self nodeWithType:@"e" xPos:xPos yPos:yPos];
        
        //action toevoegen aan enemy node
        SKAction *action = [self actionForXPos:nmy.position.x yPos:nmy.position.y];
        [nmy runAction:[SKAction repeatActionForever:action]];
        [self addChild:nmy];
    }else{
        //add enemy
        
        SKNode *nmy = [self nodeWithType:@"e" xPos:xPos yPos:yPos];
        
        //action toevoegen aan enemy node
        SKAction *action = [self actionForXPos:nmy.position.x yPos:nmy.position.y];
        [nmy runAction:[SKAction repeatActionForever:action]];
        [self addChild:nmy];
    }
}

// -------------------------------------
// Action creeeren voor enemie
// -------------------------------------

-(SKAction*) actionForXPos:(int)xPos yPos:(int)yPos{
    //laten bewegen adhv meegegeven x en y pos.
    
    SKAction *moveLeft = [SKAction moveTo:CGPointMake(xPos - 60, yPos) duration:arc4random_uniform(2) + 1];
    SKAction *moveRight = [SKAction moveTo:CGPointMake(xPos + 60, yPos) duration:arc4random_uniform(2) + 1];
    SKAction *move = [SKAction sequence:@[moveLeft,moveRight]];
    
    return move;
}

// -------------------------------------
// Node genereren
// -------------------------------------

//3 tyes:
//# enemie (e)
//# powerup (p)

-(SKNode*) nodeWithType:(NSString*)type xPos:(int)xPos yPos:(int)yPos{
    
    //Node aanmaken op meegegeven x en y pos.
    
    SKNode *obj;
    
    if([type isEqualToString:@"e"]){
        obj = [[Enemy alloc] initWithLevel:self.level];
    }else{
        obj = [[Item alloc] init];
    }
    
    obj.position = CGPointMake(xPos, yPos);
    
    return obj;
}

// -------------------------------------
// current Level
// -------------------------------------

//(nodig om te weten welke soort enemies en items er mogen gegenereerd worden)

-(int)level{
    return _level;
}

-(void)setLevel:(int)level{
    _level = level;
}

@end
