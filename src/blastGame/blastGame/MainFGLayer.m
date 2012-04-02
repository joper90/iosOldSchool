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
        
        //Inject into Blasted Engine
        
        [[BlastedEngine instance]injectScoreLayer:self];
        
        //enable touches
        self.isTouchEnabled = NO;
        
        //Score:
        scoreString = [NSString stringWithFormat:@"Score: %d",[BlastedEngine instance].currentScore];
        scoreLabel = [CCLabelTTF labelWithString:scoreString fontName:@"zxspectr.ttf" fontSize:FONT_SIZE];
        scoreLabel.position = ccp(100, [Utils instance].screenHeight - 20);
        
         
        //percentCompleteString = [NSString stringWithFormat:@"done: %d",[BlastedEngine instance].levelPercentComplete];
        //percentCompleteLabel = [CCLabelTTF labelWithString:percentCompleteString fontName:@"zxspectr.ttf" fontSize:FONT_SIZE];
        //percentCompleteLabel.position = ccp(400, [Utils instance].screenHeight - 20);
        
        multiplierString = [NSString stringWithFormat:@"x%d",[BlastedEngine instance].currentMultiplier];
        multiplierLabel = [CCLabelTTF labelWithString:multiplierString fontName:@"zxspectr.ttf" fontSize:(FONT_SIZE * 1.2f)];
        multiplierLabel.position = ccp(MULTIPLIER_END_X, 30);
        
        [self addChild:scoreLabel];
        //[self addChild:percentCompleteLabel];
        [self addChild:multiplierLabel];

    }
	return self;
}

-(void)callBackPokeUpdate
{
    scoreString = [NSString stringWithFormat:@"Score: %d",[BlastedEngine instance].currentScore];
    scoreLabel.string = scoreString;
    //float per = [BlastedEngine instance].levelPercentComplete; 
    //percentCompleteString = [NSString stringWithFormat:@"done: %f",per];
    //[percentCompleteLabel setString:percentCompleteString];
}

-(void)callBackMultiplierUpdated
{
    CCLOG(@"CallbackMultiplerUpdated call.. reset the moving multi if > 1");
    //get the new multiplier
    
    multiplierString = [NSString stringWithFormat:@"x%d",[BlastedEngine instance].currentMultiplier];
    [multiplierLabel setString:multiplierString];
    
    if ([BlastedEngine instance].currentMultiplier > 1)
    {
        [multiplierLabel stopAllActions];
    
        multiplierLabel.position = ccp([Utils instance].screenWidth,30);
    
        CCMoveTo* moveAcross = [CCMoveTo actionWithDuration:[BlastedEngine instance].currentMultiplierCountDownSpeed position:ccp(MULTIPLIER_END_X,30)];
        CCCallFuncN* finshedMove = [CCCallFuncN actionWithTarget:self selector:@selector(multiplierTimesOut:)];
        CCSequence* seq = [CCSequence actions:moveAcross, finshedMove, nil];
        
        [multiplierLabel runAction:seq];

    }
}
-(void)multiplierTimesOut:(id)sender
{
    //Hit the end.. So increment the speed (of the timeout) and then dec the multiplierTimeout.
    [[BlastedEngine instance]decMultiplier];    
}


-(void)onExit
{
    CCLOG(@"Releasing score layer..");
    [[BlastedEngine instance]releaseScoreLayer];
}

@end
