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
     
        
        CCSprite* menuSprite = [CCSprite spriteWithFile:[Properties instance].BLASTED_MENU_BUTTONS];
        menuSprite.position = [Properties instance].BLASTED_MENU_LOCATION;
        
        //Start game rect
        //Needs to change to iphone orginal coords
        startGameRect = CGRectMake(565, 276, 429, 114);
        hiScoreRect   = CGRectMake(565, 146, 429, 114);
        howToPlayRect = CGRectMake(565, 16, 429, 114);
        
        
        [self addChild:menuSprite];
        

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
        CCTransitionFade* ccFade = [CCTransitionFade transitionWithDuration:2 scene:[MainScene scene]];
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
     
    
}

@end
