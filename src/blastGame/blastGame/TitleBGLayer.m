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
    CCLOG(@"TitleMenu BG Layer...");
	if( (self=[super init])) 
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            isHD = YES;
        }else {
            isHD = NO;
        }
              
        
        //Load the mob array.
        mobList = [[NSMutableArray alloc]init];
        [self loadUpMobs];
        
        CCSprite* bgImage = [CCSprite spriteWithFile:[Properties instance].BLASTED_MENU_BG_FILE];
        CCSprite* earth = [CCSprite spriteWithFile:[Properties instance].BASE_SPRITE_FILE];
        CCSprite* titleHeader = [CCSprite spriteWithFile:[Properties instance].BLASTED_TITLE_FILE];
        
        bgImage.position = [[Utils instance]center];
        CCLOG(@"Xpos: %f , Ypos: %f", bgImage.position.x, bgImage.position.y);
        
        earth.scale = 0.8f;
        earth.position = ccp(10,0);
        
        titleHeader.position = ccp(280,650); // set to ipad etc.
        titleHeader.rotation = -2.5f;
        
        CCRotateBy* rot = [CCRotateBy actionWithDuration:300 angle:360];
        CCRepeatForever* rep = [CCRepeatForever actionWithAction:rot];
        [earth runAction:rep];
        
        CCRotateBy* rot1 = [CCRotateBy actionWithDuration:4 angle:5];
        CCRotateBy* rot2 = [CCRotateBy actionWithDuration:4 angle:-5];
        CCSequence* seq = [CCSequence actions:rot1,rot2, nil];
        CCRepeatForever* rep2 = [CCRepeatForever actionWithAction:seq];
        [titleHeader runAction:rep2];
        
        CCScaleBy* scale1 = [CCScaleBy actionWithDuration:4 scale:1.1f];
        CCScaleBy* scale2 = [CCScaleBy actionWithDuration:4 scale:0.9f];
        CCSequence* seq2 = [CCSequence actions:scale1,scale2, nil];
        CCRepeatForever* rep3 = [CCRepeatForever actionWithAction:seq2];
        [titleHeader runAction:rep3];
        
        
        partSystemTitleGalaxy1 = [BGparticleEffects getTitleGalaxy:GALAXYONE];
        partSystemTitleGalaxy2 = [BGparticleEffects getTitleGalaxy:GALAXYTWO];
        partSystemTitleStars = [BGparticleEffects getTitleGalaxy:STARFIELD];
        
        [self addChild:partSystemTitleStars];
        [self addChild:partSystemTitleGalaxy1];
        [self addChild:partSystemTitleGalaxy2];
        
        [self addChild:bgImage z:-1];
        [self addChild:earth z:10];
        [self addChild:titleHeader z:11];
        
        //Create a scheduler for random mob pops.
        [self schedule:@selector(fireMob:) interval:3.3f];
        
    }
	return self;
}

-(void)fireMob:(ccTime)delta
{
    CCLOG(@"Firing now..");
    //Choose a random mob..
    int choice = arc4random()%16;
    CCSprite* flyMeToTheMoon = [mobList objectAtIndex:choice];
    CGPoint movePoint;
    if(isHD)
    {
        flyMeToTheMoon.position = ccp(980,750);
        int yPos = arc4random()%768;
        movePoint = ccp(20,yPos);
    }else {
        flyMeToTheMoon.position = ccp(480,320);
        movePoint = ccp(10,10);
    }
    
    flyMeToTheMoon.opacity = 1.0f;
    flyMeToTheMoon.scale = 0.1f;
    
    id fadeIn = [CCFadeTo actionWithDuration:2 opacity:255.0f];
    id moveTo = [CCMoveTo actionWithDuration:3 position:movePoint];
    id scaleTo = [CCScaleTo actionWithDuration:3 scale:2.0f];
    id allActions = [CCSpawn actions:fadeIn, moveTo, scaleTo, nil];
    id cleanupAction = [CCCallFuncND actionWithTarget:self selector:@selector(cleanupSprite:) data:(__bridge void *)(flyMeToTheMoon)];
    id seq = [CCSequence actions:allActions, cleanupAction, nil];
    
    [self addChild:flyMeToTheMoon z:5];
    [flyMeToTheMoon runAction:seq];
    
}

-(void)cleanupSprite:(CCSprite *)spriteToRemove
{
    [self removeChild:spriteToRemove cleanup:YES];
}

-(void)loadUpMobs
{
    //Another yuk function. .
    //What are we running on phone/ipad
    if (isHD)
    {
        //Running on an iPad
        CCSprite* red_1 = [CCSprite spriteWithFile:@"1_redHD.png"];
        CCSprite* red_2 = [CCSprite spriteWithFile:@"2_redHD.png"];
        CCSprite* red_3 = [CCSprite spriteWithFile:@"3_redHD.png"];
        CCSprite* red_4 = [CCSprite spriteWithFile:@"4_greenHD.png"];
        CCSprite* red_5 = [CCSprite spriteWithFile:@"5_greenHD.png"];
        CCSprite* red_6 = [CCSprite spriteWithFile:@"6_blueHD.png"];
        CCSprite* red_7 = [CCSprite spriteWithFile:@"7_blueHD.png"];
        CCSprite* red_8 = [CCSprite spriteWithFile:@"8_purpleHD.png"];
        CCSprite* red_9 = [CCSprite spriteWithFile:@"9_purpleHD.png"];
        CCSprite* red_10 = [CCSprite spriteWithFile:@"10_yellowHD.png"];
        CCSprite* red_11 = [CCSprite spriteWithFile:@"11_yellowHD.png"];
        CCSprite* red_12 = [CCSprite spriteWithFile:@"12_pinkHD.png"];
        CCSprite* red_13 = [CCSprite spriteWithFile:@"13_pinkHD.png"];
        CCSprite* red_14 = [CCSprite spriteWithFile:@"14_whiteHD.png"];
        CCSprite* red_15 = [CCSprite spriteWithFile:@"15_whiteHD.png"];
        CCSprite* red_16 = [CCSprite spriteWithFile:@"16_redHD.png"];
        
        [mobList addObject:red_1];
        [mobList addObject:red_2];
        [mobList addObject:red_3];
        [mobList addObject:red_4];
        [mobList addObject:red_5];
        [mobList addObject:red_6];
        [mobList addObject:red_7];
        [mobList addObject:red_8];
        [mobList addObject:red_9];
        [mobList addObject:red_10];
        [mobList addObject:red_11];
        [mobList addObject:red_12];
        [mobList addObject:red_13];
        [mobList addObject:red_14];
        [mobList addObject:red_15];
        [mobList addObject:red_16];
    }
    else {
        //Running on a iPhone
        CCSprite* red_1 = [CCSprite spriteWithFile:@"1_red.png"];
        CCSprite* red_2 = [CCSprite spriteWithFile:@"2_red.png"];
        CCSprite* red_3 = [CCSprite spriteWithFile:@"3_red.png"];
        CCSprite* red_4 = [CCSprite spriteWithFile:@"4_green.png"];
        CCSprite* red_5 = [CCSprite spriteWithFile:@"5_green.png"];
        CCSprite* red_6 = [CCSprite spriteWithFile:@"6_blue.png"];
        CCSprite* red_7 = [CCSprite spriteWithFile:@"7_blue.png"];
        CCSprite* red_8 = [CCSprite spriteWithFile:@"8_purple.png"];
        CCSprite* red_9 = [CCSprite spriteWithFile:@"9_purple.png"];
        CCSprite* red_10 = [CCSprite spriteWithFile:@"10_yellow.png"];
        CCSprite* red_11 = [CCSprite spriteWithFile:@"11_yellow.png"];
        CCSprite* red_12 = [CCSprite spriteWithFile:@"12_pink.png"];
        CCSprite* red_13 = [CCSprite spriteWithFile:@"13_pink.png"];
        CCSprite* red_14 = [CCSprite spriteWithFile:@"14_white.png"];
        CCSprite* red_15 = [CCSprite spriteWithFile:@"15_white.png"];
        CCSprite* red_16 = [CCSprite spriteWithFile:@"16_red.png"];
        
        [mobList addObject:red_1];
        [mobList addObject:red_2];
        [mobList addObject:red_3];
        [mobList addObject:red_4];
        [mobList addObject:red_5];
        [mobList addObject:red_6];
        [mobList addObject:red_7];
        [mobList addObject:red_8];
        [mobList addObject:red_9];
        [mobList addObject:red_10];
        [mobList addObject:red_11];
        [mobList addObject:red_12];
        [mobList addObject:red_13];
        [mobList addObject:red_14];
        [mobList addObject:red_15];
        [mobList addObject:red_16];
    }
    
}

-(void)onExit
{
    [super onExit];
}



@end
