//
//  MainFGLayer.m
//  blastGame
//
//  Created by AppleUser on 19/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "MainFGLayer.h"

@implementation MainFGLayer

-(id) init
{
    CCLOG(@"MainLayer FG Layer...");
	if( (self=[super init])) 
    {
        //enable touches
        self.isTouchEnabled = NO;
        
        //Score:
        scoreString = [NSString stringWithFormat:@"Score: %d",[BlastedEngine instance].currentScore];
        scoreLabel = [CCLabelTTF labelWithString:scoreString fontName:@"zxspectr.ttf" fontSize:FONT_SIZE];
        scoreLabel.position = ccp(100, [Utils instance].screenHeight - 20);
        
         
        percentCompleteString = [NSString stringWithFormat:@"done: %d",[BlastedEngine instance].levelPercentComplete];
        percentCompleteLabel = [CCLabelTTF labelWithString:percentCompleteString fontName:@"zxspectr.ttf" fontSize:FONT_SIZE];
        percentCompleteLabel.position = ccp(400, [Utils instance].screenHeight - 20);
        
        multiplierString = [NSString stringWithFormat:@"x%d",[BlastedEngine instance].currentMultiplier];
        multiplierLabel = [CCLabelTTF labelWithString:multiplierString fontName:@"zxspectr.ttf" fontSize:(FONT_SIZE * 1.2f)];
        multiplierLabel.position = ccp([Utils instance].screenWidth - 50, 30);
        
        [self addChild:scoreLabel];
        [self addChild:percentCompleteLabel];
        [self addChild:multiplierLabel];

    }
	return self;
}

-(void)callBackPokeUpdate
{
    scoreString = [NSString stringWithFormat:@"Score: %d",[BlastedEngine instance].currentScore];
    percentCompleteString = [NSString stringWithFormat:@"done: %d",[BlastedEngine instance].levelPercentComplete];
    multiplierString = [NSString stringWithFormat:@"x%d",[BlastedEngine instance].currentMultiplier];
}

-(void)callBackMultiplierUpdated
{
    
}

-(void)onExit
{
    [[BlastedEngine instance]releaseScoreLayer];
}

@end
