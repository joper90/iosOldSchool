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
        
        [[BlastedEngine instance]loadLevel:1];
        
    }
	return self;
}

-(void)startAndMoveMobLine:(int) mobLinetoStart
{
    
}


//MobHit (the planet) - game over? or life lost..
-(void)mobFinished:(id)sender
{
    NSNumber* ttt = sender;
    int x = [ttt integerValue];
    CCLOG(@"mobMoveCompleted (in mainLayer): called with tag : %d", x);
}


-(void)update:(ccTime) delta
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
        CCLOG(@"Sprite located");
        CCSprite* mobSprite = [mobTouched getSprite];
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
