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
        
        currentTouchesTags = [[NSMutableArray alloc]init];
        
        //Lets load level One up
        
        [[BlastedEngine instance]loadLevel:1 withLayer:self];  //load the level
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
    [self removeChildByTag:x cleanup:YES];
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
    else //Swipe command? Clear or Lazer fired.
    {
        if (initialTouch.x < endTouch.x) // swipe to the right
        {
            CCLOG(@"Swipe to the right.. (lazer)");
            [self laserAction];
        }else
        {
            CCLOG(@"Swipe to the left.. (Clear)");
            //clear selection
            [self clearAction];
        }
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

        if (currentTouchesTags.count < MAX_TOUCH_SELECTED)
        {
            CCSprite* mobSprite = [mobTouched getSprite];
            [currentTouchesTags addObject:[NSNumber numberWithInt:mobSprite.tag]];
            CCLOG(@"-SPRITE TOUCHED: %d - Touch count : %d", mobSprite.tag, currentTouchesTags.count);
            [mobSprite pauseSchedulerAndActions];
        }else
        {
            CCLOG(@"Max Touch already hit..");
        }

    }
    else
    {
        CCLOG(@"Empty space touched....");
    }
    
    
}

-(void) mobMoveCompleted:(id)sender
{
    NSNumber* ttt = sender;
    int x = [ttt integerValue];
    CCLOG(@"mobMoveCompleted (MainLayer): called with tag : %d", x);
    [self removeChildByTag:x cleanup:YES];

}

-(void)clearAction
{
    CCLOG(@"Clear Actions called - Clearing Objects : %d", [currentTouchesTags count]);
    for (int x =0; x < currentTouchesTags.count; x++)
    {
        int tag = [[currentTouchesTags objectAtIndex:x]integerValue];
        CCSprite* mobSprite = (CCSprite*) [self getChildByTag:tag];
        [mobSprite resumeSchedulerAndActions];
    }
    
    //Now remove all elements
    [currentTouchesTags removeAllObjects];
}

-(void)laserAction
{
    //currentTouchCount = 0;
    CCLOG(@"Laser called");
}

-(void) dealloc
{
    [currentTouchesTags release];
    currentTouchesTags = nil;
    [super dealloc];
}

@end
