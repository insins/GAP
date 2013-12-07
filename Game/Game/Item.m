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
        
        SKSpriteNode *obj;
        
        if ([type isEqual:@"p"]) {
            obj = [self createPowerup];
            self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:obj.size.width/2];
            self.physicsBody.categoryBitMask = powerupCategory;
        }else if([type isEqual:@"c"]){
            obj = [self createCollectorItem];
            self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obj.size];
            self.physicsBody.categoryBitMask = itemCategory;
        }
        
        self.physicsBody.dynamic = YES;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.contactTestBitMask = playerCategory;
        self.physicsBody.collisionBitMask = 0;
        
        [self addChild:obj];
    }
    
    return self;
}

-(SKSpriteNode*)createPowerup{
    
    //generate path (random)
    NSString *path = [[NSBundle mainBundle] pathForResource:@"turtle" ofType:@"png" inDirectory:@"powerups"];
    SKSpriteNode *powerup = [SKSpriteNode spriteNodeWithImageNamed:path];
    
    return powerup;
}

-(SKSpriteNode*)createCollectorItem{
    
    //generate path (adhv level)
    NSString *path = [[NSBundle mainBundle] pathForResource:@"item1" ofType:@"png" inDirectory:@"items"];
    SKSpriteNode *item = [SKSpriteNode spriteNodeWithImageNamed:path];
    
    return item;
}

@end
