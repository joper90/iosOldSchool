//
//  MainLayer.m
//  blastGame
//
//  Created by AppleUser on 29/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "MainLayer.h"

@implementation MainLayer

-(id) init
{
    CCLOG(@"MainLayer...");
	if( (self=[super init])) 
    {
        //enable touches
        self.isTouchEnabled = YES;
        gameLive = NO;
        
        //Lets load level One up
        
        [[BlastedEngine instance]loadLevel:1];  //load the level
        maxWave = [[BlastedEngine instance]getWaveCountByCurrentLevel]; //set the waves on this level.
        
        [self startAndMoveMobWave:0];
        
        //Now register the schedure for when the time (betweenRowTime has elapsed);
        [self schedule:@selector(scheduleNewWave:) interval:[[BlastedEngine instance]getCurrentTimeBetweenWaves]];
    }
	return self;
}

-(void)startAndMoveMobWave:(int) mobWavetoStart
{
    
    int mobElementCount = mobWavetoStart * 5;
    
    CCLOG(@"StartAndMove grabbing %d to %d", mobElementCount, mobElementCount + 5);
    NSArray* lineMobs = [[BlastedEngine instance]getMobsForRenderRangeFrom:mobElementCount to:mobElementCount +5]; //5 lines 0 - 4
    CCLOG(@"StartAndMove recived : %d", [lineMobs count]);   
    
    currentWave++; //0 wave has now run.
    //MobElements
    for (MobElement* m in lineMobs)
    {
        if (m.isEmptySpace == NO) // Not a request placement.
        {
            //Ok we have a mob.. so place and run?
            CCSprite* mob = m.sprite;
            CCAction* action = m.actionSequenceToRun;
            
            [self addChild:mob];
            [mob runAction:action];
        }
        
    }
}


//MobHit (the planet) - game over? or life lost..
-(void)mobFinished:(id)sender
{
    NSNumber* ttt = sender;
    int x = [ttt integerValue];
    CCLOG(@"mobMoveCompleted (in mainLayer): called with tag : %d", x);
}

-(void)scheduleNewWave:(ccTime)delta
{
    CCLOG(@"NEW WAVE CALLED... %d/%d", currentWave,maxWave);

    if (currentWave > maxWave)
    {
        CCLOG(@"All waves complete ---> canceling selector");
        [self unschedule:_cmd];
    }
    else
    {
        [self startAndMoveMobWave:currentWave];
    }
}

-(void)levelFinished
{
    
}

//TOUCH Handlers
-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //Reset the touch.
    touchMoved = NO;    
    
    //May need to check to see if touched here, as it may be too late later, as it will have moved.
    initialTouch = [[Utils instance]locationFromTouchSinglePoint:touch];
    mobTouched = [[BlastedEngine instance]whichMobTouched:initialTouch];
    
    

    return YES;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    //May need to check of drag lenght, incase of use input error.
    endTouch = [[Utils instance]locationFromTouchSinglePoint:touch];
    
    float distance = [[Utils instance]distanceBetweenPoints:initialTouch endPoint:endTouch];
    CCLOG(@"Gap %f", distance);
    
    //No if distance between allowed amount then treat as a single touch.
    if (distance <= DRAG_CLICK_LENIENCY ) touchMoved = NO;
    
    
    if (touchMoved == NO) // check for sprite Touch
    {
        [self checkSpriteTouchedAction];
    }
    else //Swipe command? Laser fired.
    {
        [self laserAction];
    }
    
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    touchMoved = YES;
    CCLOG(@"Touch Moved");
}

-(void)checkSpriteTouchedAction
{
    
    if (mobTouched != nil)
    {

        CCSprite* mobSprite = [mobTouched getSprite];
        CCLOG(@"Sprite located : %d", mobSprite.tag);
        [mobSprite stopAllActions];   
    }
    else
    {
        CCLOG(@"Empty space touched....");
    }
    
    
}

-(void)laserAction
{
    CCLOG(@"Laser called");
}

@end
