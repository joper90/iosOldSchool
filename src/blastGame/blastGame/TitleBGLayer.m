//
//  TitleBGLayer.m
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "TitleBGLayer.h"

@implementation TitleBGLayer

-(id) init
{
    CCLOG(@"TitleMenu BG Layer...with RC: %d",[self retainCount]);
	if( (self=[super init])) 
    {
        CCSprite* bgImage = [CCSprite spriteWithFile:@"blastedMenu.png"];
        CCLabelTTF *gameName = [CCLabelTTF labelWithString:@"Blasted Game" fontName:@"efmi" fontSize:48];
        
        // position the label on the center of the screen
        CGPoint centerPos= [[Utils instance]center];
        bgImage.position = centerPos;
		gameName.position =  centerPos;   
        
        [self addChild:bgImage z:Z_BG_MENU_TAG];
        [self addChild:bgImage z:Z_BG_MENU_GAMENAME];
    }
	return self;
}

@end
