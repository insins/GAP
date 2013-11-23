//
//  SceneFactory.m
//  GAP
//
//  Created by Ruben Van Wassenhove on 23/11/13.
//  Copyright (c) 2013 Devine. All rights reserved.
//

#import "SceneFactory.h"

@implementation SceneFactory

+ (id) createSceneWithBaseLayer:(CCLayer*)layer
{
	CCScene *scene = [CCScene node];
	[scene addChild: layer];
	return scene;
}

@end
