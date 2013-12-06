//
//  World.m
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "World.h"

@implementation World

@synthesize frame = _frame;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super init]) {
        self.frame = frame;
    }
    return self;
}

-(void)updateObjects{
    /*kansen*/
    
    // 1-2 = items / 3-8 = enemies
    // 1/20 items = powerup
    
    int itmNmy = round(arc4random_uniform(8)) + 1;
    int luck = round(arc4random_uniform(16)) + 1;
    
    int pos = arc4random_uniform(self.frame.size.width - 60) + 30;
    pos = (pos > self.frame.size.width - 20) ? self.frame.size.width - 20 : ((pos < 20) ? 20 : pos);
    
    if (itmNmy < 3) {
        
        [self createItem:pos];
        
    }else{
        //add enemy
        
        SKNode *nmy = [self nodeWithType:@"e" xPos:pos];
        
        SKAction *action = [self actionForXPos:nmy.position.x yPos:nmy.position.y];
        
        [nmy runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:nmy];
        
        int pos2 = 0;
        
        if (nmy.position.x < self.frame.size.width / 2) {
            pos2 = nmy.position.x + self.frame.size.width / arc4random_uniform(4) + 2;
        }else{
            pos2 = nmy.position.x - self.frame.size.width / arc4random_uniform(4) + 2;
        }
        
        pos2 = (pos2 > self.frame.size.width - 20) ? self.frame.size.width - 20 : ((pos2 < 20) ? 20 : pos2);
        
        if (luck <= 2) {
            //bad luck
            
            SKNode *nmy2 = [self nodeWithType:@"e" xPos:pos2];
            
            action = [self actionForXPos:nmy2.position.x yPos:nmy2.position.y];
            
            [nmy2 runAction:[SKAction repeatActionForever:action]];
            
            [self addChild:nmy2];
            
        }else if(luck >= 13){
            //good luck
            
            if (nmy.position.x < self.frame.size.width / 2) {
                [self createItem:pos2];
            }else{
                [self createItem:pos2];
            }
        }
    }
    
}

-(SKAction*) actionForXPos:(int)xPos yPos:(int)yPos{
    SKAction *moveLeft = [SKAction moveTo:CGPointMake(xPos - 60, yPos) duration:arc4random_uniform(2) + 1];
    SKAction *moveRight = [SKAction moveTo:CGPointMake(xPos + 60, yPos) duration:arc4random_uniform(2) + 1];
    SKAction *move = [SKAction sequence:@[moveLeft,moveRight]];
    
    return move;
}

-(SKNode*) nodeWithType:(NSString*)type xPos:(int)xPos{
    
    SKNode *obj;
    
    if([type isEqualToString:@"e"]){
        obj = [[Enemy alloc] init];
    }else{
        obj = [[Item alloc] initWithType:type];
    }
    
    obj.position = CGPointMake(xPos, self.frame.size.height - self.position.y + (arc4random_uniform(5)) * 15);
    return obj;
}

-(void) createItem:(int)xPos{
    int pwrItm = round(arc4random_uniform(20)) + 1;
    
    if(pwrItm == 1){
        //add powerup
        
        SKNode *pwr = [self nodeWithType:@"p" xPos:xPos];
        [self addChild:pwr];
    }else{
        //add item
        
        SKNode *itm = [self nodeWithType:@"c" xPos:xPos];
        [self addChild:itm];
    }
}

@end
