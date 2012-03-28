//
//  LevelCompleteScene.m
//  blastGame
//
//  Created by AppleUser on 28/03/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "LevelCompleteScene.h"


@implementation LevelCompleteScene
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    
	CCLayer* levelCompleteLayer = [LevelCompleteLayer node];
    [scene addChild:levelCompleteLayer];
    
    
	// return the scene
	return scene;
}
@end
