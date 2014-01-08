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
    CCLOG(@"TitleMenu BG Layer...with ");
	if( (self=[super init])) 
    {
        self.touchEnabled = YES;
     
        
        CCSprite* menuSprite = [CCSprite spriteWithFile:[Properties instance].BLASTED_MENU_BUTTONS];
        menuSprite.position = [Properties instance].BLASTED_MENU_LOCATION;
        
        soundEnabledSprite = [CCSprite spriteWithFile:[Properties instance].BLASTED_MENU_SOUND_ON];
        soundDisabledSprite = [CCSprite spriteWithFile:[Properties instance].BLASTED_MENU_SOUND_OFF];
        soundEnabledSprite.visible = YES;
        soundDisabledSprite.visible = NO;
        soundEnabledSprite.position =[Properties instance].BLASTED_MENU_SOUND_LOCATION;
        soundDisabledSprite.position =[Properties instance].BLASTED_MENU_SOUND_LOCATION;
        
        //Start game rect
        //Needs to change to iphone orginal coords
        startGameRect = CGRectMake(565, 276, 429, 114);
        hiScoreRect   = CGRectMake(565, 146, 429, 114);
        howToPlayRect = CGRectMake(565, 16, 429, 114);
        soundSet = CGRectMake(425, 14, 110, 110);
        
        
        [self addChild:menuSprite];
        [self addChild:soundEnabledSprite];
        [self addChild:soundDisabledSprite];

    }
    return self;
}



-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [[Utils instance]locationFromTouchMultiPoint:touches];
    
    CCLOG(@"Location = %f, %f",touchLocation.x,touchLocation.y);
    
    if (CGRectContainsPoint(startGameRect, touchLocation))
    {
        CCLOG(@"StartGameRect");
        //Reset the score and the multuplier and the level
        
        [[BlastedEngine instance]resetLevelCount];
        [[BlastedEngine instance]resetScore];
        [[BlastedEngine instance]resetMultiplier];
        //CCTransitionFade* ccFade = [CCTransitionFade transitionWithDuration:2 scene:[MainScene scene]];
        CCTransitionFade* ccFade = [CCTransitionFade transitionWithDuration:2 scene:[IntroOne scene]];
        [[CCDirector sharedDirector]pushScene:ccFade];
        
    }
    else if (CGRectContainsPoint(hiScoreRect, touchLocation))
    {
        CCLOG(@"Hiscore Rect");
    }
    else if (CGRectContainsPoint(howToPlayRect, touchLocation))
    {
        CCLOG(@"How to play Rect");
    }
    else if (CGRectContainsPoint(soundSet,touchLocation))
    {
          if (soundEnabledSprite.visible == YES)
          {
              soundDisabledSprite.visible = YES;
              soundEnabledSprite.visible = NO;
              [BlastedEngine instance].sound = NO;
              CCLOG(@"Sound disabled");
          }else {
              soundDisabledSprite.visible = NO;
              soundEnabledSprite.visible = YES;
              [BlastedEngine instance].sound = YES;
              CCLOG(@"Sound enabled");
          }
    }
     
    
}

@end
