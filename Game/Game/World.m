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
    int luck = round(arc4random_uniform(4));
    
    if (itmNmy < 3) {
    
        int pwrItm = round(arc4random_uniform(20)) + 1;
        
        if(pwrItm == 1){
            //add powerup
            
            SKNode *pwr = [[Item alloc] initWithType:@"p"];
            pwr.position = CGPointMake(arc4random_uniform(self.frame.size.width - 60) + 30, self.frame.size.height-self.position.y);
            [self addChild:pwr];
        }else{
            //add item

            SKNode *itm = [[Item alloc] initWithType:@"c"];
            itm.position = CGPointMake(arc4random_uniform(self.frame.size.width - 60) + 30, self.frame.size.height-self.position.y);
            [self addChild:itm];
        }
        
        if (luck == 1) {
            //bad luck
            
        }else if(luck == 4){
            //good luck
        }
        
    }else{
        //add enemy
        SKNode *nmy = [[Enemy alloc] init];
        nmy.position = CGPointMake(arc4random_uniform(self.frame.size.width - 60) +30, self.frame.size.height-self.position.y);
        
        SKAction *moveLeft = [SKAction moveTo:CGPointMake(nmy.position.x - 60, nmy.position.y) duration:1];
        SKAction *moveRight = [SKAction moveTo:CGPointMake(nmy.position.x + 60, nmy.position.y) duration:1];
        SKAction *move = [SKAction sequence:@[moveLeft,moveRight]];
        
        [nmy runAction:[SKAction repeatActionForever:move]];
        
        [self addChild:nmy];
    }
    
}

@end
