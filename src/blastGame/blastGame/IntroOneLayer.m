//
//  IntroOneLayer.m
//  blastGame
//
//  Created by Joe Humphries on 24/06/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "IntroOneLayer.h"


@implementation IntroOneLayer


-(id) init
{
    CCLOG(@"IntroOne Layer...with RC: %d",[self retainCount]);
	if( (self=[super init])) 
    {
        
        self.isTouchEnabled = YES;
        CGPoint midPoint = [[Utils instance]center];
        //Load the bgImages
        CCSprite* bgImages = [CCSprite spriteWithFile:@"background_part1HD.png"];
        bgImages.position = midPoint;
        bgImages.opacity = 0;
        
        CCSprite* bgMoon = [CCSprite spriteWithFile:@"moonHD.png"];
        bgMoon.position = [[Utils instance]convertToiPadPointX:60 andY:250];
        bgMoon.opacity = 0;
        
        CCSprite* village = [CCSprite spriteWithFile:@"background_housesHD.png"];
        village.position = ccp(midPoint.x, 150);
        
        CCLabelTTF *skipText = [CCLabelTTF labelWithString:@"Touch to skip" fontName:@"efmi" fontSize:25];
        skipText.position = ccp(midPoint.x,20);
        [self addChild:skipText z:10];
        
        id snowParticle = [CCParticleSystemQuad particleWithFile:@"snowfall.plist"];
        [self addChild:snowParticle z:5];
        
        [self addChild:bgImages z:0];
        [self addChild:bgMoon z:1];
        [self addChild:village z:2];
        
        CCFadeIn *fadebg = [CCFadeIn actionWithDuration:5.0f];
        CCFadeIn *fadeMoon = [CCFadeIn actionWithDuration:5.0f];
        
        CCRotateBy *rot = [CCRotateBy actionWithDuration:5 angle:360];
        CCRepeatForever *rep = [CCRepeatForever actionWithAction:rot];
        
        [bgImages runAction:fadebg];
        [bgMoon runAction:fadeMoon];
        [bgMoon runAction:rep];
        
        //Create the text.
        introText = [CCLabelTTF labelWithString:INTRO_ONE_TEXT fontName:@"efmi" fontSize:48];
        introText.position = ccp(midPoint.x, [[Utils instance]convertYtoiPad:40]);
        introText.opacity = 0;
        introText.scale =0;
        
        CCFadeIn *fadeText = [CCFadeIn actionWithDuration:2.0f];
        CCScaleTo *scale = [CCScaleTo actionWithDuration:2.0f scale:1.0f];
        CCSpawn *actions = [CCSpawn actions:fadeText, scale, nil];
        
        [self addChild:introText z:10];
        [introText runAction:actions];
       
        
    }
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //CCTransitionFade* ccFade = [CCTransitionFade transitionWithDuration:0.5f scene:[TitleScene scene]];
    //[[CCDirector sharedDirector]pushScene:ccFade];
}
@end
