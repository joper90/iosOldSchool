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
        
        currentTouchesTags = [[NSMutableArray alloc]init];
        
        //Lets load level One up
        
        [[BlastedEngine instance]loadLevel:1 withLayer:self];  //load the level
        maxWave = [[BlastedEngine instance]getWaveCountByCurrentLevel]; //set the waves on this level.
        
        //Init the display now
        [self initGun];
        [self startAndMoveMobWave:0];
        
        //Now register the schedure for when the time (betweenRowTime has elapsed);
        [self schedule:@selector(scheduleNewWave:) interval:[[BlastedEngine instance]getCurrentTimeBetweenWaves]];
        
        
    }
	return self;
}

-(void)initGun
{
    lockOnSprite = [CCSprite spriteWithFile:@"lockon.png"];
    [lockOnSprite retain];
    
    //Load up the particle systems into the bullet array.
    bullets = [[NSMutableArray alloc]initWithCapacity:4];
    for (int x = 0; x < 4; x++)
    {
        [bullets addObject:[CCParticleSystemQuad particleWithFile:@"bullet_with_death.plist"]];
    }
    
    bangArray = [[NSMutableArray alloc]initWithCapacity:4];
    for (int x = 0; x < 4; x++)
    {
        [bangArray addObject:[CCParticleSystemQuad particleWithFile:@"exp1.plist"]];
    }
    
    gunSprite = [CCSprite spriteWithFile:@"gun.png"];
    gunSprite.position = ccp(GUN_X_POSITION, [Utils instance].center.y);
    gunSprite.tag = GUN_TAG;
    
    [self addChild:gunSprite z:10];
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
        //Now start poll to check for end of the level
        //Create checking for level complete scheduler
        [self schedule:@selector(levelFinished:) interval:2];
    }
    else
    {
        [self startAndMoveMobWave:currentWave];
    }
}

-(void)levelFinished:(ccTime)delta
{
    BOOL completed = [[BlastedEngine instance]isLevelCompleted];
    if (completed)
    {
        CCLOG(@"--->LEVEL COMPLETED<---");
        //unschedule this test.
        [self unschedule:_cmd];
        
    }
    else
    {
        CCLOG(@"--->NOT COMPLETED<----");
    }
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
            //Are any mobs selected?
            if (currentTouchesTags.count > 0)
            {
                CCLOG(@"Swipe to the right.. (lazer)");
                [self laserAction];
            }else
            {
                CCLOG(@"No mobs to fire at??");
            }
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
   // CCLOG(@"Touch Moved");
}

-(void)checkSpriteTouchedAction
{
    
    if (mobTouched != nil)
    {

        if (currentTouchesTags.count < MAX_TOUCH_SELECTED)
        {
            CCSprite* mobSprite = [mobTouched getSprite];
            mobSprite.color = ccc3(200,0,0);
            
            CCSprite* newLockOn = [CCSprite spriteWithTexture:[lockOnSprite texture]];
            CGSize mobPoint = mobSprite.contentSize;
            CGPoint newLockPosition = ccp(mobPoint.width / 2.0f , mobPoint.height /2.0f );
            newLockOn.position = newLockPosition;
            
            
            //Should be moved out really.
            CCRotateBy* rotAction = [CCRotateBy actionWithDuration:1.0f angle:360.0f];
            CCRepeatForever* repeatAction = [CCRepeatForever actionWithAction:rotAction];
            
            [newLockOn runAction:repeatAction];
    
            [mobSprite addChild:newLockOn z:200];
            
            [currentTouchesTags addObject:[NSNumber numberWithInt:mobSprite.tag]];
            CCLOG(@"-SPRITE TOUCHED: %d - Touch count : %d", mobSprite.tag, currentTouchesTags.count);

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

-(void) mobMoveCompleted:(id)sender //Called from flightPath when its reached the planet /base
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
        mobSprite.color = ccc3(255,255,255);
        [mobSprite removeAllChildrenWithCleanup:YES];
    }
    
    //Now remove all elements
    [currentTouchesTags removeAllObjects];
}



-(void)laserAction
{
    CCLOG(@"Laser called");
    for (int x =0; x < currentTouchesTags.count; x++)
    {
        int tag = [[currentTouchesTags objectAtIndex:x]integerValue];
        //get sprite location to fire.
        CCSprite* spFound = (CCSprite*)[self getChildByTag:tag];
        
        //remove the lock on
        [spFound removeAllChildrenWithCleanup:YES];
        CGPoint spriteLocation = spFound.position;
        
        
        //Maybe add some predictiveness here
        float baseSpeed = [[BlastedEngine instance]getCurrentSpeed];
        spriteLocation = ccp(spriteLocation.x - (baseSpeed * 5), spriteLocation.y);
        
        CCParticleSystem* part = [bullets objectAtIndex:x];
        [part resetSystem];
        part.position = ccp(GUN_X_POSITION +5, [Utils instance].center.y);
        
        BangAction* bangData = [[BangAction alloc]init];
        bangData.tag = spFound.tag;
        bangData.position = spriteLocation;
        bangData.bulletElement = x;
        
        CCMoveTo* moveAction = [CCMoveTo actionWithDuration:1.0f position:spriteLocation];        
        CCCallFuncO* bulletHit = [CCCallFuncO actionWithTarget:self selector:@selector(bangAction:) object:bangData];
        CCSequence* seq = [CCSequence actions:moveAction, bulletHit, nil];
        
        if (part.parent == nil) [self addChild:part];
        
        [part runAction:seq];
        
    }
    
    //Now remove all elements - can start selecting after firing.. 
    [currentTouchesTags removeAllObjects];
}
                           
-(void)bangAction:(id)object
{
    
    BangAction* bang = (BangAction*) object;
    CCLOG(@"BangAction called : for tag %d", bang.tag);
    
    CCParticleSystem* bangParticle = [bangArray objectAtIndex:bang.bulletElement];
    bangParticle.position = bang.position;
    [bangParticle resetSystem];
    if (bangParticle.parent == nil) [self addChild:bangParticle];
    
    
    //Remove the actual Sprite (Mob) from the layer.
    [self removeChildByTag:bang.tag cleanup:NO]; 
    [[BlastedEngine instance]setDeadMob:bang.tag];
    
    [bang release];
}

-(void) dealloc
{
    [lockOnSprite release];
    [currentTouchesTags release];
    [bullets release];
    [bangArray release];
    currentTouchesTags = nil;
    [super dealloc];
}

@end
