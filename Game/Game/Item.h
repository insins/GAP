//
//  Item.h
//  Game
//
//  Created by Ruben Van Wassenhove on 01/12/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Item : SKNode

@property (nonatomic) NSString *power;
@property (nonatomic) int level;

-(id)initWithType:(NSString*)type level:(int)level;

@end
