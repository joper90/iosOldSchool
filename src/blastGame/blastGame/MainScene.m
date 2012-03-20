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
    

	
    MainFGLayer* mainFGLayer = [MainFGLayer node];
    [scene addChild:mainFGLayer z:1 tag:T_MAIN_FG_SCORE_LAYER];
    
	MainLayer* mainLayer = [MainLayer node];
    [scene addChild:mainLayer z:0 tag:T_MAIN_LAYER];
    
    MainBGLayer* mainBGLayer = [MainBGLayer node];
    [scene addChild:mainBGLayer z:-1 tag:T_MAIN_BG_LAYER];
    
    //Any start game stuff here
    
    return scene;
}        

@end
