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
        CCSprite* bgImage = [CCSprite spriteWithFile:[Properties instance].BLASTED_MENU_FILE];
        CCSprite* earth = [CCSprite spriteWithFile:[Properties instance].BASE_SPRITE_FILE];
        CCSprite* titleHeader = [CCSprite spriteWithFile:[Properties instance].BLASTED_TITLE_FILE];
        
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
        [self addChild:titleHeader];
        
        
        
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
@end
