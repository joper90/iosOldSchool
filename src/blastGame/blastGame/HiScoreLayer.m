//
//  HiScoreLayer.m
//  blastGame
//
//  Created by Joe Humphries on 19/04/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "HiScoreLayer.h"


@implementation HiScoreLayer


-(id) init
{
    CCLOG(@"hiScore Layer...with RC: %d",[self retainCount]);
	if( (self=[super init])) 
    {
        CCLabelTTF *hiScore = [CCLabelTTF labelWithString:@"hi-scores" fontName:@"efmi" fontSize:48];
        
        // position the label on the center of the screen
        CGPoint centerPos= [[Utils instance]center];
		hiScore.position =  centerPos;   

        [self addChild:hiScore];
        
        self.isTouchEnabled = YES;
        
    }
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCTransitionFade* ccFade = [CCTransitionFade transitionWithDuration:0.5f scene:[TitleScene scene]];
    [[CCDirector sharedDirector]pushScene:ccFade];
}

@end
