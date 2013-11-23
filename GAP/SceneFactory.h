//
//  SceneFactory.h
//  GAP
//
//  Created by Ruben Van Wassenhove on 23/11/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"

@interface SceneFactory : NSObject

+ (id) createSceneWithBaseLayer:(CCLayer*)layer;

@end
