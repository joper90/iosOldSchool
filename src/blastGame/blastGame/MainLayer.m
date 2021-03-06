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
    CCLOG(@"MainLayer...with ");
	if( (self=[super init])) 
    {
        
        //Testing injections
        [[BlastedEngine instance]injectGamePlayLayer:self];
        CCLOG(@"-->injected...with ");
        //CCLOG(@"-->removed...with ");
     
        currentTouchesTags = [[NSMutableArray alloc]init];
              
        CCLOG(@"----->currenTouchedAllocted...with ");
        //Lets load level One up
        [[BlastedEngine instance]loadLevel:[BlastedEngine instance].level withLayer:self];  //load the level
        CCLOG(@"----->loadLevelCompleted...with ");
        maxWave = [[BlastedEngine instance]getWaveCountByCurrentLevel]; //set the waves on this level.
        CCLOG(@"----->GotWaveCount...with ");
        
        CCLOG(@"----->Starting music");
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:[[BlastedEngine instance]getBackGroundMusic]];
        //Call the levelCoutDown
        [self levelCountDown];
        
    }
	return self;
}

-(void)levelCountDown
{
    CCLOG(@"levelCountDown...with ");
    countDownLabel = [CCLabelTTF labelWithString:@"3" fontName:@"ZXSpectrum" fontSize:[Properties instance].FONT_SIZE_COUNTDOWN];
    [self addChild:countDownLabel z:Z_COUNTDOWN_TEXT_TAG tag:COUNTDOWN_TEXT_TAG];
    
    //Load in the globe and spin in.
    NSString* planetSprite = [Properties instance].BASE_SPRITE_FILE ;
    CCLOG(@"Planet Sprite : %@", planetSprite);
    globeSprite = [CCSprite spriteWithFile:planetSprite];
    globeSprite.scale = 4.0f;
    globeSprite.position = ccp(-170, [Utils instance].screenHeight/2);
    
    [self addChild:globeSprite z:Z_PLANET_TAG tag:PLANET_TAG];
    
    //Globe actions
    CCScaleTo* zoom = [CCScaleTo actionWithDuration:3 scale:0.4f];
    CCAction* rot  = [CCRotateBy actionWithDuration:3 angle:360.0f];
    CCSpawn* actions = [CCSpawn actions:zoom, rot, nil];
    CCScaleTo* zoomOut = [CCScaleTo actionWithDuration:0.5f scale:0.5f];
    CCSequence* seq = [CCSequence actions:actions, zoomOut, nil];
    
    [globeSprite runAction:seq];
    
    //Create levelName to display
    levelNameLabel = [CCLabelTTF labelWithString:[[BlastedEngine instance]getCurrentLevelName] fontName:@"ZXSpectrum" fontSize:[Properties instance].FONT_LEVEL_NAME_SIZE];
    levelNameLabel.position = [[Utils instance]center];
    
    [self addChild:levelNameLabel];
    
    //Start it off the screen to the left.
    [self levelCountDownTimeout:[NSNumber numberWithInt:3]];

}

-(void)levelCountDownTimeout:(id)sender
{
    CCLOG(@"levelCountDownTimeout...with ");
    NSNumber* ttt = sender;
    int x = [ttt integerValue];
    
    
    if (x > 0)
    {
        [countDownLabel setString:[NSString stringWithFormat:@"%d",x]];
        countDownLabel.position = ccp(-10, [Utils instance].screenHeight/4);
        CGPoint endPos = ccp([Utils instance].screenWidth + 40, [Utils instance].screenHeight/4);
        CCMoveTo* move = [CCMoveTo actionWithDuration:1.5f position:endPos];
        CCCallFuncO* moveDone = [CCCallFuncO actionWithTarget:self selector:@selector(levelCountDownTimeout:) object:[NSNumber numberWithInt:--x]];
        CCSequence* seq = [CCSequence actions:move, moveDone, nil];
        [countDownLabel runAction:seq];
     
    }else
    {
        //remove the level name as count down complete
        [self removeChild:levelNameLabel cleanup:YES];
        
        //Init the display now
        [self initGun];
        [self startAndMoveMobWave:0];
    
        //Now register the schedure for when the time (betweenRowTime has elapsed);
        [self schedule:@selector(scheduleNewWave:) interval:[[BlastedEngine instance]getCurrentTimeBetweenWaves]];
        
        //Now register the scheduler for the pump.
        [self schedule:@selector(schedulePumpEffect:) interval:[[BlastedEngine instance]getPumpSpace]];
    }
}

-(void)initGun
{
    CCLOG(@"InitGun...with ");
    NSString* sprite = [Properties instance].LOCKON_SPRITE_FILE;
    CCLOG(@"lockon : %@",sprite);
    lockOnSprite = [CCSprite spriteWithFile:sprite];
    
    //Load up the particle systems into the bullet array.
    bullets = [[NSMutableArray alloc]initWithCapacity:4];
    for (int x = 0; x < 4; x++)
    {
        CCLOG(@"Rocket = %@",[Properties instance].ROCKET);
        [bullets addObject:[CCParticleSystemQuad particleWithFile:[Properties instance].ROCKET]];
    }
    
    bangArray = [[NSMutableArray alloc]initWithCapacity:4];
    for (int x = 0; x < 4; x++)
    {
        [bangArray addObject:[CCParticleSystemQuad particleWithFile:[Properties instance].EXPLODE]];
    }
    
    sprite = [Properties instance].GUN_SPRITE_FILE;
    gunSprite = [CCSprite spriteWithFile:sprite];
    gunSprite.position = ccp(GUN_X_POSITION, [Utils instance].center.y);
    
    
    [self addChild:gunSprite z:Z_GUN_TAG tag:GUN_TAG];
    
    //enable touches
    self.touchEnabled = YES;
}

-(void)startAndMoveMobWave:(int) mobWavetoStart
{
    CCLOG(@"StartAndMoveWave...with ");
    int currentRowSize = [[BlastedEngine instance]getRowCountSizeByRowNumber:currentWave];
    int currentMobDisplayCount = [BlastedEngine instance].currentMobDisplayedCount;
    
    CCLOG(@"StartAndMove grabbing %d to %d", currentMobDisplayCount, currentMobDisplayCount + currentRowSize);
    NSArray* lineMobs = [[BlastedEngine instance]getMobsForRenderRangeFrom:currentMobDisplayCount
                                                                        to:currentMobDisplayCount + currentRowSize]; //5 lines 0 - 4
    CCLOG(@"StartAndMove recived : %d", [lineMobs count]);   
    
    [[BlastedEngine instance]increaseMobDisplayCount:currentRowSize];
    currentWave++; //0 wave has now run.

    //MobElements 
    
    for (MobElement* m in lineMobs)
    {
        if (m.isEmptySpace == NO) // Not a request placement.
        {
            
            //Ok we have a mob.. so place and run?
            CCSprite* mob = [m getSprite];
            CCAction* action = [m getSequence];

            [self addChild:mob];
            
            [mob runAction:action];
            m.isAlive = YES;
        }
    }
}


-(void)scheduleNewWave:(ccTime)delta
{
    CCLOG(@"scheduleNewWave...with ");
    CCLOG(@"NEW WAVE CALLED... %d/%d", currentWave,maxWave);

    if (currentWave == maxWave)
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

-(void)schedulePumpEffect:(ccTime)delta
{
    CCLOG(@"====>PUMP<======");
    [[BlastedEngine instance]pumpVisableMobs];
}

-(void)levelFinished:(ccTime)delta
{
    CCLOG(@"levelFinished...with ");
    BOOL completed = [[BlastedEngine instance]isLevelCompleted];
    if (completed)
    {
        CCLOG(@"--->LEVEL COMPLETED<---");
        //unschedule this test.
        [self unschedule:@selector(scheduleNewWave:)];
        [self unschedule:_cmd];
        CCTransitionFade* ccFade = [CCTransitionFade transitionWithDuration:0.5f scene:[LevelCompleteScene scene]];
        [[CCDirector sharedDirector]pushScene:ccFade];
        
    }
    else
    {
        CCLOG(@"--->NOT COMPLETED<----");
    }
}

//TOUCH Handlers
-(void) registerWithTouchDispatcher
{
    CCLOG(@"RegisterWithTouchDispacther...with ");
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"ccTouchBegan...with ");
    //Reset the touch.
    touchMoved = NO;    
    
    //May need to check to see if touched here, as it may be too late later, as it will have moved.
    initialTouch = [[Utils instance]locationFromTouchSinglePoint:touch];
    
    //Logic to check if a mob has been touched.
    mobTouched = [[BlastedEngine instance]whichMobTouched:initialTouch];
    return YES;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"ccTouchEnded...with ");
    //May need to check of drag lenght, incase of use input error.
    endTouch = [[Utils instance]locationFromTouchSinglePoint:touch];
    
    float distance = [[Utils instance]distanceBetweenPoints:initialTouch endPoint:endTouch];
    CCLOG(@"Gap %f", distance);
    
    //No if distance between allowed amount then treat as a single touch.
    if (distance <= [Properties instance].DRAG_SELECT_FREEDOM ) touchMoved = NO;
    
    //Check if quit?
    if (endTouch.y < 50)
    {
        float swipeExit = [Properties instance].QUIT_DRAG_SIZE;
        if (distance > swipeExit)
        {
            CCLOG(@"===> QUIT SELECTED %f and %f", distance, swipeExit);
            //Quit looks to have been selected... 
            [[CCDirector sharedDirector]replaceScene:[GameOverScene scene]];
        }
    }
    
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
    CCLOG(@"CheckSpriteTouchedAction...with ");
    
    if (mobTouched != nil)
    {
        if (currentTouchesTags.count < MAX_TOUCH_SELECTED)
        {
            CCSprite* mobSprite = [mobTouched getSprite];
            
            if ([mobSprite getChildByTag:12345] == nil)
            {
                mobSprite.color = ccc3(200,0,0);
            
                CCSprite* newLockOn = [CCSprite spriteWithTexture:[lockOnSprite texture]];
                CGSize mobPoint = mobSprite.contentSize;
                CGPoint newLockPosition = ccp(mobPoint.width / 2.0f , mobPoint.height /2.0f );
                newLockOn.position = newLockPosition;
            
            
                //Should be moved out really.
                CCRotateBy* rotAction = [CCRotateBy actionWithDuration:1.0f angle:360.0f];
                CCRepeatForever* repeatAction = [CCRepeatForever actionWithAction:rotAction];
            
                [newLockOn runAction:repeatAction];
    
                [mobSprite addChild:newLockOn z:200 tag:12345];
            
                [currentTouchesTags addObject:[NSNumber numberWithInt:mobSprite.tag]];
                CCLOG(@"-SPRITE TOUCHED: %d - Touch count : %d", mobSprite.tag, currentTouchesTags.count);
            }else {
                CCLOG(@"-SPRITE ALREADY TOUCHED: %d",mobSprite.tag);
            }

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
    CCLOG(@"MoveCompleted...with ");
    NSNumber* ttt = sender;
    int x = [ttt integerValue];
    CCLOG(@"mobMoveCompleted (MainLayer): called with tag : %d", x);
    // Now go Bang...
    CCParticleSystem* mobBang = [CCParticleSystemQuad particleWithFile:@"exp2.plist"];
    CGPoint location = [self getChildByTag:x].position;
    mobBang.position = location;
    
    [self addChild:mobBang z:Z_PLANT_HIT_TAG tag:PLANET_HIT_TAG];
    [self removeChildByTag:x cleanup:YES];
    
    //Stop new waves comming in
    [self unschedule:@selector(scheduleNewWave:)];
    //Disable touches
    self.touchEnabled = NO;
    //Remove touches
    [currentTouchesTags removeAllObjects];
    
    //Now wait (schedule) to remove the mobs.
    [self schedule:@selector(mobMoveCompletedRemoveAllMobs:) interval:0.5f];
}

-(void)mobMoveCompletedRemoveAllMobs:(ccTime) delta
{
    CCLOG(@"MoveCompletedRemvoeAllMobs...with ");
    self.touchEnabled = NO;
    [self unschedule:_cmd];
    //Remove all sprites
    NSMutableArray* spritesList = [[BlastedEngine instance]getMobListArray];
    for (int x = 0; x < [spritesList count]; x++)
    {
        BOOL b = [[spritesList objectAtIndex:x] boolValue];
        if (b == NO)
        {
            [self removeChildByTag:x cleanup:YES];
        }
    }
    
    
    //GAME OVER..
    [[CCDirector sharedDirector]replaceScene:[GameOverScene scene]];

}

-(void)clearAction
{
    CCLOG(@"ClearAction...with ");
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
    CCLOG(@"LaserAction...with ");
    CCLOG(@"Laser called : with touched count %d", currentTouchesTags.count);
        
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
        spriteLocation = ccp(spriteLocation.x - (baseSpeed * MOB_PREDICTIVENESS), spriteLocation.y);
        
        CCParticleSystem* part = [bullets objectAtIndex:x];
        [part resetSystem];
        part.position = ccp(GUN_X_POSITION + GUN_FIRE_OFFSET, [Utils instance].center.y);
        
        BangAction* bangData = [[BangAction alloc]init];
        bangData.tag = spFound.tag;
        bangData.position = spriteLocation;
        bangData.bulletElement = x;
        
        CCMoveTo* moveAction = [CCMoveTo actionWithDuration:GUN_FIRE_TIME position:spriteLocation];        
        CCCallFuncO* bulletHit = [CCCallFuncO actionWithTarget:self selector:@selector(bangAction:) object:bangData];
        CCSequence* seq = [CCSequence actions:moveAction, bulletHit, nil];
        
        if (part.parent == nil) [self addChild:part];
        
        [part runAction:seq];
        
    }

    //Now calcute the score
    [self calculateScore];
    
    //Now remove all elements - can start selecting after firing.. 
    [currentTouchesTags removeAllObjects];
}
                           
-(void)bangAction:(id)object
{
    CCLOG(@"bangAction...with ");
    BangAction* bang = (BangAction*) object;
    CCLOG(@"BangAction called : for tag %d", bang.tag);
    
    CCParticleSystem* bangParticle = [bangArray objectAtIndex:bang.bulletElement];
    bangParticle.position = bang.position;
    [bangParticle resetSystem];
    if (bangParticle.parent == nil) [self addChild:bangParticle];
    
    
    //Remove the actual Sprite (Mob) from the layer.
    [self removeChildByTag:bang.tag cleanup:NO]; 
    [[BlastedEngine instance]setDeadMob:bang.tag];
    
    

}

//Scores

-(void) calculateScore
{
    CCLOG(@"Calculate score...");
    // Work out the score per 1, 2 ,3 or 4 hit.
    // Each mob gets a score based on it posistion too. which barrier it was in.
    //4 need to be the same to multply
    
    int thisScore = 0;
    int sameCount =0;
    MOB_COLOUR previous;
    
    
    //Get colour and current band of each mob
    for (int x =0; x < currentTouchesTags.count; x++)
    {
        int tag = [[currentTouchesTags objectAtIndex:x]integerValue];
        MobElement* mob = [[BlastedEngine instance]getMobBySpriteTag:tag];
        
        MOB_COLOUR mobType = mob.mobType;
        if (sameCount == 0)
        {
            sameCount++;
            previous = mobType;
        }
        else
        {
            if (mobType == previous)
            {
                sameCount++;
            }
        }
        
        //Now workout where the mob lies
        float xPostion = [mob getSprite].position.x;
        
        if (xPostion <= [Properties instance].LINE_ONE) //Closest to the planet
        {
            thisScore += LINE_ONE_SCORE;
        }
        else if (xPostion <= [Properties instance].LINE_TWO)
        {
            thisScore += LINE_TWO_SCORE;
        }
        else if (xPostion <= [Properties instance].LINE_THREE)
        {
            thisScore += LINE_THREE_SCORE;
        }else 
        {
            thisScore += LINE_ENDZONE_SCORE;
        }
        
        CCLOG(@"==> Total Score for mob tag %d sum %d",tag, thisScore);
        
    }
    
    //All scores for all mobs Added up.
    int currentMultiplier = [[BlastedEngine instance]getMultipiler];
    CCLOG(@"==> Adding score %d with mutli = %d :: total %d", thisScore, currentMultiplier, thisScore * currentMultiplier);
    
    //Add the new score to the main total
    [[BlastedEngine instance]addToScore:thisScore * currentMultiplier];
    
    //If 4 the same increase modifier
    if (sameCount == 4) 
    {
        [[BlastedEngine instance]incMultiplier];
        CCLOG(@"Score multiplier increased");
    }
    
    CCLOG(@"Same colour mobs %d", sameCount);

}

-(void) updateScore:(int)amount
{
    [[BlastedEngine instance]addToScore:amount];
    MainFGLayer* fg = (MainFGLayer*)[[self parent]getChildByTag:T_MAIN_FG_SCORE_LAYER];
    [fg callBackPokeUpdate];
    
}

-(void) updateModiferIncrease
{
    [[BlastedEngine instance]incMultiplier];
    MainFGLayer* fg = (MainFGLayer*)[[self parent]getChildByTag:T_MAIN_FG_SCORE_LAYER];
    [fg callBackPokeUpdate];
}

-(void) updateModiferDecrease
{
    [[BlastedEngine instance]decMultiplier];
    MainFGLayer* fg = (MainFGLayer*)[[self parent]getChildByTag:T_MAIN_FG_SCORE_LAYER];
    [fg callBackPokeUpdate];
}

-(void)onExit
{
    [[BlastedEngine instance]releaseGamePlayLayer];
    currentTouchesTags = nil;
    CCLOG(@"Main Layer --->OnExit() Called with ");
    [[[CCDirector sharedDirector] touchDispatcher]removeDelegate:self];
    [super onExit];
}

-(void) dealloc
{
	CCLOG(@"Main Layer --->dealloc() Called with ");
}

@end
