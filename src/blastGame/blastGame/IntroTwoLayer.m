//
//  IntroTwoLayer.m
//  blastGame
//
//  Created by Joe Humphries on 24/06/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "IntroTwoLayer.h"


@implementation IntroTwoLayer

-(id) init
{
    CCLOG(@"IntroTwo Layer...with ");
	if( (self=[super init])) 
    {
        self.touchEnabled = YES;
        CGPoint midPoint = [[Utils instance]center];
        //Load the bgImages

        
        CCSprite* bgImages = [CCSprite spriteWithFile:@"background_part2HD.png"];
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
        
        CCParticleSystemQuad *starBurst = [CCParticleSystemQuad particleWithFile:@"starburst.plist"];
        starBurst.position = ccp(midPoint.x, [[Utils instance]convertYtoiPad:40]);
        [self addChild:starBurst z:5];
        
        [self addChild:bgImages z:0];
        [self addChild:bgMoon z:1];
        [self addChild:village z:6];
        
        CCFadeIn *fadebg = [CCFadeIn actionWithDuration:5.0f];
        CCFadeIn *fadeMoon = [CCFadeIn actionWithDuration:5.0f];
        
        CCRotateBy *rot = [CCRotateBy actionWithDuration:5 angle:360];
        CCRepeatForever *rep = [CCRepeatForever actionWithAction:rot];
        
        [bgImages runAction:fadebg];
        [bgMoon runAction:fadeMoon];
        [bgMoon runAction:rep];
        
        //Create the text.
        introText = [CCLabelTTF labelWithString:INTRO_TWO_TEXT fontName:@"efmi" fontSize:48];
        introText.position = ccp(midPoint.x, [[Utils instance]convertYtoiPad:40]);
        introText.opacity = 0;
        introText.scale =0;
        
        CCFadeIn *fadeText = [CCFadeIn actionWithDuration:2.0f];
        CCScaleTo *scale = [CCScaleTo actionWithDuration:2.0f scale:1.0f];
        CCSpawn *actions = [CCSpawn actions:fadeText, scale, nil];
        
        [self addChild:introText z:10];
        [introText runAction:actions];
        
        CCSprite* man = [CCSprite spriteWithFile:@"manHD.png"];
        man.position = ccp(midPoint.x, [[Utils instance]convertYtoiPad:100]);
        man.scale = 0.0f;
        CCScaleTo *zoom = [CCScaleTo actionWithDuration:5 scale:1.0f];
        CCMoveTo *moveUp = [CCMoveTo actionWithDuration:5 position:ccp(midPoint.x, [[Utils instance]convertYtoiPad:150])];
        id actions2 = [CCSpawn actions:zoom, moveUp, nil];
        [self addChild:man z:10];
        [man runAction:actions2];

    }
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCTransitionFade* ccFade = [CCTransitionFade transitionWithDuration:0.5f scene:[IntroThree scene]];
    [[CCDirector sharedDirector]pushScene:ccFade];
}

@end
