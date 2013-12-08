//
//  World.m
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "World.h"

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

//method om random een item/enemie/power toe te voegen

-(void)updateObjects{
    /*kansen*/
    
    // 1-2 = items / 3-8 = enemies
    // 1/20 items = powerup
    
    //random getal die bepaald of er een item/enemie wordt toegevoegd aan stage
    int itmNmy = round(arc4random_uniform(8)) + 1;
    
    //bepalen of je bad luck/good luck/neutraal
    self.luck = (self.luck <= 2) ? round(arc4random_uniform(16)) + 3 : ((self.luck >= 13) ? round(arc4random_uniform(12)) + 1 : round(arc4random_uniform(16)) + 1);
    
    //x en y pos instellen van element die aan stage moet worden toegevoegd
    int xPos = arc4random_uniform(self.frame.size.width - 60) + 30;
    xPos = (xPos > self.frame.size.width - 20) ? self.frame.size.width - 20 : ((xPos < 20) ? 20 : xPos);
    int yPos = self.frame.size.height - self.position.y;
    
    if (itmNmy < 3 && self.counter < 3) {
        
        self.counter++;
        [self createItemX:xPos Y:yPos];
        
    }else{
        self.counter = 0;
        
        //add enemy
        
        SKNode *nmy = [self nodeWithType:@"e" xPos:xPos yPos:yPos];
        
        //action toevoegen aan enemy node
        SKAction *action = [self actionForXPos:nmy.position.x yPos:nmy.position.y];
        [nmy runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:nmy];
        
        //x pos instellen van 2e element die mogelijk aan stage moet worden toegevoegd
        int xPos2 = self.frame.size.width - nmy.position.x;
        
        if (nmy.position.x > self.frame.size.width / 4 && nmy.position.x < self.frame.size.width / 2) {
            xPos2 = nmy.position.x + self.frame.size.width / 3;
        }else if(nmy.position.x < (self.frame.size.width * 3) / 4  && nmy.position.x > self.frame.size.width / 2){
            xPos2 = nmy.position.x - self.frame.size.width / 3;
        }
        
        xPos2 = (xPos2 > self.frame.size.width - 20) ? self.frame.size.width - 20 : ((xPos2 < 20) ? 20 : xPos2);
        
        //bij bad luck: 2 enemies ineens
        //bij good luck: er komt ook een item bij
        
        if (self.luck <= 2) {
            //bad luck: item aan stage toevoegen
            //y pos instellen van 2e element die mogelijk aan stage moet worden toegevoegd
            int yPos2 = self.frame.size.height - self.position.y + (arc4random_uniform(5) + 10) * 10;
            
            SKNode *nmy2 = [self nodeWithType:@"e" xPos:xPos2 yPos:yPos2];
            
            //action toevoegen aan enemy node
            action = [self actionForXPos:nmy2.position.x yPos:nmy2.position.y];
            [nmy2 runAction:[SKAction repeatActionForever:action]];
            
            [self addChild:nmy2];
            
        }else if(self.luck >= 13){
            //good luck: enemie aan stage toevoegen
            //y pos instellen van 2e element die mogelijk aan stage moet worden toegevoegd
            int yPos2 = self.frame.size.height - self.position.y + (arc4random_uniform(10) + 5) * 10;
            
            //item aanmaken en toevoegen aan stage
            [self createItemX:xPos2 Y:yPos2];
        }
    }
    
}

-(SKAction*) actionForXPos:(int)xPos yPos:(int)yPos{
    //laten bewegen adhv meegegeven x en y pos.
    
    SKAction *moveLeft = [SKAction moveTo:CGPointMake(xPos - 60, yPos) duration:arc4random_uniform(2) + 1];
    SKAction *moveRight = [SKAction moveTo:CGPointMake(xPos + 60, yPos) duration:arc4random_uniform(2) + 1];
    SKAction *move = [SKAction sequence:@[moveLeft,moveRight]];
    
    return move;
}

-(SKNode*) nodeWithType:(NSString*)type xPos:(int)xPos yPos:(int)yPos{
    
    //Node aanmaken op meegegeven x en y pos.
    
    SKNode *obj;
    
    if([type isEqualToString:@"e"]){
        obj = [[Enemy alloc] initWithLevel:self.level];
    }else{
        obj = [[Item alloc] initWithType:type level:self.level];
    }
    
    obj.position = CGPointMake(xPos, yPos);
    
    return obj;
}

-(void) createItemX:(int)xPos Y:(int)yPos{
    //random getal die bepaald of er een collect item/power wordt toegevoegd aan stage
    int pwrItm = round(arc4random_uniform(20)) + 1;
    
    if(pwrItm == 1){
        //add powerup
        
        SKNode *pwr = [self nodeWithType:@"p" xPos:xPos yPos:yPos];
        [self addChild:pwr];
    }else{
        //add item
        
        SKNode *itm = [self nodeWithType:@"c" xPos:xPos yPos:yPos];
        [self addChild:itm];
    }
}

-(int)level{
    return _level;
}

-(void)setLevel:(int)level{
    _level = level;
}

@end
