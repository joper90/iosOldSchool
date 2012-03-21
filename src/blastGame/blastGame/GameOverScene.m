//
//  GameOverScene.m
//  blastGame
//
//  Created by AppleUser on 21/03/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "GameOverScene.h"


@implementation GameOverScene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    
	CCLayer* gameOverLayer = [GameOverLayer node];
    [scene addChild:gameOverLayer];
    
    
	// return the scene
	return scene;
}
@end
