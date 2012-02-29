//
//  FlashScene.m
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "FlashScene.h"

@implementation FlashScene


+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
	
	FlashFGLayer* flashLayer = [FlashFGLayer node];
    [scene addChild:flashLayer z:0 tag:T_FLASH_FG_LAYER];
	return scene;
}        

@end
