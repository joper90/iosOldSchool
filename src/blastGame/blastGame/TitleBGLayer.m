//
//  TitleBGLayer.m
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "TitleBGLayer.h"

@implementation TitleBGLayer

@synthesize barPercentTime,partSystemTitleGalaxy2,partSystemTitleGalaxy1,partSystemTitleStars;

-(id) init
{
    CCLOG(@"TitleMenu BG Layer...with RC: %d",[self retainCount]);
	if( (self=[super init])) 
    {
        /*
        self.isTouchEnabled = YES;
        
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
        
        NSString* menuImage = [Properties instance].BLASTED_MENU_FILE;
        CCSprite* bgImage = [CCSprite spriteWithFile:menuImage];
        
        partSystemTitleGalaxy1 = [BGparticleEffects getTitleGalaxy:GALAXYONE];
        partSystemTitleGalaxy2 = [BGparticleEffects getTitleGalaxy:GALAXYTWO];
        partSystemTitleStars = [BGparticleEffects getTitleGalaxy:STARFIELD];
    
        [self addChild:partSystemTitleStars];
        [self addChild:partSystemTitleGalaxy1];
        [self addChild:partSystemTitleGalaxy2];
        
        [self addChild:bgImage z:-1];
        
        
    }
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [[Utils instance]locationFromTouchMultiPoint:touches];
    if (CGRectContainsPoint(startGameRect, touchLocation))
    {
        CCLOG(@"StartGameRect");
        //Reset the score and the multuplier and the level
        
        [[BlastedEngine instance]resetLevelCount];
        [[BlastedEngine instance]resetScore];
        [[BlastedEngine instance]resetMultiplier];
        CCTransitionFade* ccFade = [CCTransitionFade transitionWithDuration:2 scene:[MainScene scene]];
        [[CCDirector sharedDirector]pushScene:ccFade];
        
    }
    else if (CGRectContainsPoint(hiScoreRect, touchLocation))
    {
        CCLOG(@"Hiscore Rect");
    }
    
}


// Bar utils

-(void)setBatTimeToMax
{
    self.barPercentTime = 100.0f;
}

-(void)setBarTimeToZero
{
    self.barPercentTime = 0.0f;
}

-(BOOL)isBarTimeZero
{
    if (self.barPercentTime == 0.0f)
    {
        return YES;
    }
    return NO;
}

-(BOOL)decreaseBarTimeByFactor:(float)factor
{
    CCLOG(@"==*** Current Bar time : %f", self.barPercentTime);
    self.barPercentTime -= factor; //take away the factored amount
    CCLOG(@"==*** Updated Bar time : %f", self.barPercentTime);
    if (self.barPercentTime <= 0.0f)
    {
        CCLOG(@"==** BAR TRIPPED ZERO");
        self.barPercentTime = 0.0f;
        return YES;
    }
    return NO;
}

@end
