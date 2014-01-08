//
//  GameOverLayer.m
//  blastGame
//
//  Created by AppleUser on 21/03/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "GameOverLayer.h"


@implementation GameOverLayer

-(id) init
{
    CCLOG(@"GameOver Layer...with ");
	if( (self=[super init])) 
    {
        self.touchEnabled = YES;
        
        CCLabelTTF *gameOver = [CCLabelTTF labelWithString:@"GameOver" fontName:@"efmi.ttf" fontSize:48];
        
        // position the label on the center of the screen
        CGPoint centerPos= [[Utils instance]center];
		gameOver.position =  centerPos;   
        
        NSString* gameScoreString = [NSString stringWithFormat:@"Score : %d",[[BlastedEngine instance]currentScore]];
        
        CCLabelTTF *currentScoreLabel = [CCLabelTTF labelWithString:gameScoreString fontName:@"efmi.ttf" fontSize:30];
        centerPos = ccp(centerPos.x,centerPos.y- 50);
        
        currentScoreLabel.position = centerPos;
        
        [self addChild:gameOver];
        [self addChild:currentScoreLabel];
    }
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCTransitionFade* ccFade = [CCTransitionFade transitionWithDuration:0.5f scene:[HiScoreScene scene]];
    [[CCDirector sharedDirector]pushScene:ccFade];
}

@end
