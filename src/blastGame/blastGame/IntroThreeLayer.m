
//
//  IntroThreeLayer.m
//  blastGame
//
//  Created by Joe Humphries on 24/06/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "IntroThreeLayer.h"


@implementation IntroThreeLayer

-(id) init
{
    CCLOG(@"IntroOne Layer...with ");
	if( (self=[super init])) 
    {
        
        self.touchEnabled = YES;
        CGPoint midPoint = [[Utils instance]center];
        //Load the bgImages
        
        
        CCSprite* bgImages = [CCSprite spriteWithFile:@"background_part3HD.png"];
        bgImages.position = midPoint;
        bgImages.opacity = 0;
    
        
        CCSprite* console = [CCSprite spriteWithFile:@"consoleHD.png"];
        console.position = ccp(midPoint.x, 150);
        console.opacity = 0;
        
        CCSprite* man = [CCSprite spriteWithFile:@"manHD.png"];
        man.position = ccp(midPoint.x, [[Utils instance]convertYtoiPad:100]);
        
        
        CCLabelTTF *skipText = [CCLabelTTF labelWithString:@"Touch to skip" fontName:@"efmi" fontSize:25];
        skipText.position = ccp(midPoint.x,20);
        [self addChild:skipText z:10];
        
        CCParticleSystemQuad *starBurst = [CCParticleSystemQuad particleWithFile:@"displayPart_HD.plist"];
        starBurst.position = ccp(midPoint.x, [[Utils instance]convertYtoiPad:40]);
        [self addChild:starBurst z:15];
        
        [self addChild:bgImages z:0];
        [self addChild:console z:9];
        [self addChild:man z:5];
        
        //Create the text.
        introText = [CCLabelTTF labelWithString:INTRO_THREE_TEXT fontName:@"efmi" fontSize:48];
        introText.position = ccp(midPoint.x, [[Utils instance]convertYtoiPad:40]);
        introText.opacity = 0;
        introText.scale =0;
        
        CCFadeIn *fadeText = [CCFadeIn actionWithDuration:2.0f];
        CCScaleTo *scale = [CCScaleTo actionWithDuration:2.0f scale:1.0f];
        CCSpawn *actions = [CCSpawn actions:fadeText, scale, nil];
        
        [self addChild:introText z:10];
        [introText runAction:actions];
        
        CCFadeIn *fadebg = [CCFadeIn actionWithDuration:5.0f];
        CCFadeIn *fadeConsole = [CCFadeIn actionWithDuration:5.0f];
        
        [bgImages runAction:fadebg];
        [console runAction:fadeConsole];
        
        
        
               
    }
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCTransitionFade* ccFade = [CCTransitionFade transitionWithDuration:0.5f scene:[IntroFour scene]];
    [[CCDirector sharedDirector]pushScene:ccFade];
}

@end
