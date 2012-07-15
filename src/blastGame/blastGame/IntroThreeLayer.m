
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
    CCLOG(@"IntroOne Layer...with RC: %d",[self retainCount]);
	if( (self=[super init])) 
    {
        
        self.isTouchEnabled = YES;
        CGPoint midPoint = [[Utils instance]center];
        //Load the bgImages
        
        
        CCSprite* bgImages = [CCSprite spriteWithFile:@"background_part3HD.png"];
        bgImages.position = midPoint;
    
        
        CCSprite* console = [CCSprite spriteWithFile:@"consoleHD.png"];
        console.position = ccp(midPoint.x, 150);
        
        CCSprite* man = [CCSprite spriteWithFile:@"manHD.png"];
        man.position = ccp(midPoint.x, [[Utils instance]convertYtoiPad:100]);
        
        CCLabelTTF *skipText = [CCLabelTTF labelWithString:@"Touch to skip" fontName:@"efmi" fontSize:25];
        skipText.position = ccp(midPoint.x,20);
        [self addChild:skipText z:10];
        
        CCParticleSystemQuad *starBurst = [CCParticleSystemQuad particleWithFile:@"displayPart_HD.plist"];
        starBurst.position = ccp(midPoint.x, [[Utils instance]convertYtoiPad:40]);
        [self addChild:starBurst z:15];
        
        [self addChild:bgImages z:0];
        [self addChild:console z:10];
        [self addChild:man z:5];
        
        //Create the text.
        introText = [CCLabelTTF labelWithString:INTRO_THREE_TEXT fontName:@"efmi" fontSize:48];
        introText.position = ccp(midPoint.x, [[Utils instance]convertYtoiPad:40]);
        introText.opacity = 0;
        introText.scale =0;
        
               
    }
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCTransitionFade* ccFade = [CCTransitionFade transitionWithDuration:0.5f scene:[IntroFour scene]];
    [[CCDirector sharedDirector]pushScene:ccFade];
}

@end
