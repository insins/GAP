//
//  Item.m
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "Item.h"

@implementation Item

-(id)init{
    if (self = [super init]) {
        
        //obj aanmaken en physicsbody instellen
        SKSpriteNode *obj;
        
        obj = [self createPowerup];
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:obj.size.width/2];
        self.physicsBody.categoryBitMask = itemCategory;
        
        self.physicsBody.dynamic = YES;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.contactTestBitMask = playerCategory;
        self.physicsBody.collisionBitMask = 0;
        
        [self addChild:obj];
    }
    
    return self;
}

-(SKSpriteNode*)createPowerup{
    
    
    NSMutableArray *powerups = [[NSMutableArray alloc] init];
    
    // Powerups aanmaken
    NSString * blow = @"blow";
    NSString * jelly = @"jelly";
    NSString * turtle = @"turtle";
    NSString * whale = @"whale";
    
    powerups = [[NSMutableArray alloc] initWithObjects:blow, jelly, turtle, whale, nil];
    
    int minNummer = 0;
    int maxNummer = [powerups count];
    int range = maxNummer - minNummer;
    int randomNummer = arc4random_uniform(range) + minNummer;
    
    self.power = [powerups objectAtIndex:randomNummer];
    
    //generate path (random)
    NSString *path = [[NSBundle mainBundle] pathForResource:self.power ofType:@"png" inDirectory:@"powerups"];
    SKSpriteNode *powerup = [SKSpriteNode spriteNodeWithImageNamed:path];
    
    return powerup;
}

@end
