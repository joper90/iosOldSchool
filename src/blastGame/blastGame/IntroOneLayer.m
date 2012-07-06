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
        CCSprite* bgImages = [CCSprite spriteWithFile:@"background.png"];
        bgImages.position = midPoint;
        bgImages.opacity = 0;
        
        CCLabelTTF *skipText = [CCLabelTTF labelWithString:@"Touch to skip" fontName:@"efmi" fontSize:25];
        skipText.position = ccp(midPoint.x,20);
        [self addChild:skipText z:10];
        
        id snowParticle = [CCParticleSystemQuad particleWithFile:@"snowfall.plist"];
        [self addChild:snowParticle z:5];
        
        [self addChild:bgImages z:0];
        
        CCFadeIn *fade = [CCFadeIn actionWithDuration:5.0f];
        [bgImages runAction:fade];
        
        
    }
	return self;
}
@end
