//
//  MainScene.m
//  blastGame
//
//  Created by Joeh on 28/02/2012.
//  Copyright (c) 2012 funkmonkey.com All rights reserved.
//

#import "MainScene.h"

@implementation MainScene


+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
	
	MainLayer* mainLayer = [MainLayer node];
    [scene addChild:mainLayer z:0 tag:T_MAIN_LAYER];
	return scene;
}        

@end
