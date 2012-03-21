//
//  MainLayer.h
//  blastGame
//
//  Created by AppleUser on 29/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "cocos2d.h"
#import "BlastedEngine.h"
#import "MobElement.h"
#import "FlightPaths.h"
#import "BangAction.h"
#import "GameOverScene.h"

@interface MainLayer : CCLayer
{
    int tagCount;
    BOOL touchMoved;
    
    BOOL gameLive; // Is the game Live, or jsut on countdown etc.
    
    int currentWave;
    int maxWave;
    float timeBetweenWaves;
    
    CCLabelTTF* countDownLabel;
    CCSprite* gunSprite;
    CCSprite* lockOnSprite;
    CCSprite* globeSprite;
    
    NSMutableArray* currentTouchesTags;
    NSMutableArray* bullets; //0-3 bullets
    NSMutableArray* bangArray; //0-3 bangs
    
    CGPoint initialTouch;
    CGPoint endTouch;
    MobElement* mobTouched;
}

-(void)startAndMoveMobWave:(int) mobWavetoStart;
-(void)checkSpriteTouchedAction;
-(void)laserAction;
-(void)bangAction:(id) object;
-(void)clearAction;

-(void)scheduleNewWave:(ccTime)delta;
-(void)levelFinished:(ccTime)delta; //Check id level is completed.

-(void) mobMoveCompleted:(id)sender;
-(void) mobMoveCompletedRemoveAllMobs:(ccTime) delta;

-(void) updateScore:(int)amount;
-(void) updateModiferIncrease;
-(void) updateModiferDecrease;

-(void) initGun;
-(void) levelCountDown;
-(void) levelCountDownTimeout:(id)sender;

@end
