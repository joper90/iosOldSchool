//
//  TitleScene.m
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "TitleScene.h"

@implementation TitleScene


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];

    CCLayer* titleScreenLayerBG = [TitleBGLayer node];
    CCLayer* titleScreenLayerFG = [TitleFGlayer node];
    
    [scene addChild:titleScreenLayerBG];
    [scene addChild:titleScreenLayerFG];
	
	// return the scene
	return scene;
}


@end
