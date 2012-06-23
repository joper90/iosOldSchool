//
//  TitleFGlayer.m
//  blastGame
//
//  Created by AppleUser on 23/06/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "TitleFGlayer.h"


@implementation TitleFGlayer



-(id) init
{
    CCLOG(@"TitleMenu BG Layer...with RC: %d",[self retainCount]);
	if( (self=[super init])) 
    {
        self.isTouchEnabled = YES;
     
        
        CCSprite* menuSprite = [CCSprite spriteWithFile:[Properties instance].BLASTED_MENU_FILE];
       // menuSprite
        
        
        /*
        NSString* menuImage = [Properties instance].BLASTED_MENU_FILE;
        CCSprite* bgImage = [CCSprite spriteWithFile:menuImage];
        CCLabelTTF *gameName = [CCLabelTTF labelWithString:@"Blasted Game" fontName:@"zxspectr" fontSize:32];
        CCLabelTTF *startButton = [CCLabelTTF labelWithString:@"Start new game" fontName:@"zxspectr" fontSize:20];
        CCLabelTTF *hiScore = [CCLabelTTF labelWithString:@"hiscore / help" fontName:@"zxspectr" fontSize:15];
        
        // position the label on the center of the screen
        CGPoint centerPos= [[Utils instance]center];
        
        bgImage.position = centerPos;
		gameName.position =  ccp(centerPos.x, centerPos.y + 120);
        startButton.position = ccp(centerPos.x - 40, centerPos.y + 20);
        hiScore.position = ccp(centerPos.x - 100, centerPos.y - 70);
        
        //startGameRect = CGRectMake(20,140,390,80);
        startGameRect = [[Utils instance]convertToIPadMakeRect:20 y1:140 width:390 height:80];
        //hiScoreRect = CGRectMake(20, 50, 230, 70);
        hiScoreRect = [[Utils instance]convertToIPadMakeRect:20 y1:50 width:230 height:70];
        
        [self addChild:hiScore z:Z_BG_MENU_HISCORE_HELP];
        [self addChild:startButton z:Z_BG_MENU_STARTBUTTON];
        [self addChild:bgImage z:-1];
        [self addChild:gameName z:Z_BG_MENU_GAMENAME];
         */
    }
    return self;
}

@end
