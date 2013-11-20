//
//  MyCocos2DClass.m
//  GAP
//
//  Created by Ruben Van Wassenhove on 20/11/13.
//  Copyright 2013 Devine. All rights reserved.
//

#import "StartLayer.h"

@implementation StartLayer

+(id)scene{
    CCScene *scene = [CCScene node];
    StartLayer *layer = [StartLayer node];
    [scene addChild:layer];
    return scene;
}

-(id)init{
    if((self=[super init])){
        
    }
    
    return self;
}

@end
