//
//  Item.m
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "Item.h"

@implementation Item

-(id)initWithType:(NSString*)type{
    if (self = [super init]) {
        
        /*Types:
            "p" = powerup
            "c" = collector item
        */
        
        if ([type isEqual:@"p"]) {
            [self addChild:[self createPowerup]];
        }else if([type isEqual:@"c"]){
            [self addChild:[self createCollectorItem]];
        }
        
    }
    
    return self;
}

-(SKNode*)createPowerup{
    
    //generate path (random)
    NSString *path = [[NSBundle mainBundle] pathForResource:@"turtle" ofType:@"png" inDirectory:@"powerups"];
    
    SKNode *powerup = [SKSpriteNode spriteNodeWithImageNamed:path];
    
    return powerup;
}

-(SKNode*)createCollectorItem{
    
    //generate path (adhv level)
    NSString *path = [[NSBundle mainBundle] pathForResource:@"item1" ofType:@"png" inDirectory:@"items"];
    
    SKNode *item = [SKSpriteNode spriteNodeWithImageNamed:path];
    
    return item;
}

@end
