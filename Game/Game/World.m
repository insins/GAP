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
        self.timer = nil;
    }
    return self;
}

// -------------------------------------
// methods om item/enemie/power
// toe te voegen
// -------------------------------------

// wordt opgeroepen in GameScene class

-(void)updateObjects{
    
    //bepalen of je bad luck/good luck/neutraal
    self.luck = (self.luck <= 2) ? round(arc4random_uniform(16)) + 3 : ((self.luck >= 13) ? round(arc4random_uniform(12)) + 1 : round(arc4random_uniform(16)) + 1);
    
    //x en y pos instellen van element die aan stage moet worden toegevoegd
    //enemie staat ofwel links ofwel rechts
    
    int lr = (arc4random() % 2 ? 1 : -1);
    
    int xPos = (lr * self.frame.size.width) / 4 + self.frame.size.width / 2;
    int yPos = self.frame.size.height - self.position.y + 30;
    
    int xPos2 = (-lr * self.frame.size.width) / 4 + self.frame.size.width / 2;
    int yPos2 = (arc4random() % 2 ? 1 : -1) * arc4random_uniform(20) + 10 + yPos + 30;
    
    if (self.luck <= 2) {
        //good luck: power aan stage toevoegen
        
        //item aanmaken en toevoegen aan stage
        SKNode *pwr = [self nodeWithType:@"p" xPos:xPos2 yPos:yPos2];
        [self addChild:pwr];
        
    }
        //add enemy
        
        self.nmy = [self nodeWithType:@"e" xPos:xPos yPos:yPos];
        
        //action toevoegen aan enemy node
        /*
         SKAction *action = [self actionForXPos:nmy.position.x yPos:nmy.position.y];
        [nmy runAction:[SKAction repeatActionForever:action]];
         */
    
        //animatie moet in de Enemie klasse worden uitgevoerd
    
        [self addChild:self.nmy];
    
        if (self.timer == nil && self.level == 3) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval: 3.5 target: self selector: @selector(addProjectile:) userInfo: nil repeats: YES];
        }
    
}

-(void)pauzeer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)resume{
    if (self.timer == nil && self.level == 3) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval: 3.5 target: self selector: @selector(addProjectile:) userInfo: nil repeats: YES];
    }
}

-(void)addProjectile:(NSTimer *)timer{
    Enemy * nmy = (Enemy*)self.nmy;
    [nmy addProjectile:self.frame];
}

-(void)updateBubbles{
    SKNode *bubble = [[Bell alloc] initWithLevel:self.level];
    
    int lr = (arc4random() % 2 ? 1 : -1);

    int xPos = (lr * self.frame.size.width) / 4 + self.frame.size.width / 2;
    int yPos = self.frame.size.height - self.position.y + 30;
    
    bubble.position = CGPointMake(xPos, yPos);
    
    [self addChild:bubble];
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
        obj = [[Power alloc] init];
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
