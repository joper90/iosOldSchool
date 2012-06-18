//
//  BlastedEngine.m
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo. All rights reserved.
//

#import "BlastedEngine.h"


@implementation BlastedEngine

@synthesize iosDeviceProperties, isHdMode,
            currentScore, mobsArray, level, levelList, currentMobDisplayedCount, 
            currentPlayingLevel, currentMultiplier, 
            currentMultiplierCountDownSpeed ,levelPercentComplete, hiScores, rowPositionData,
            redMobSprites, yellowMobSprites, blueMobSprites, greenMobSprites, whiteMobSprites, pinkMobSprites;

static BlastedEngine* blastedEngine = nil;

+(BlastedEngine*) instance
{
    if (blastedEngine == nil)
    {
        CCLOG(@"Engine instance started....");
        //Alive for the duration of the game
        blastedEngine = [[BlastedEngine alloc]init];
        CCLOG(@"Engine instance complete....");
    }
    return blastedEngine;
}

-(id)init
{
    CCLOG(@"Engine init method");
    self = [super self];
    if (self != nil)
    {
        
        //What are we running on phone/ipad
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            CCLOG(@"RUNNING ON iPAD");
            self.isHdMode = YES;
        }else
        {
            CCLOG(@"RUNNING ON iPHONE");
            self.isHdMode = NO;
        }
        //Load the properties files up now
        [Properties instance];
        
        //Now allocate all teh arrays
        self.iosDeviceProperties = [[NSMutableDictionary alloc]init];
        
        self.mobsArray = [[NSMutableArray alloc]init];
        self.redMobSprites = [[NSMutableDictionary alloc]init];
        self.yellowMobSprites = [[NSMutableDictionary alloc]init];
        self.greenMobSprites = [[NSMutableDictionary alloc]init];
        self.blueMobSprites = [[NSMutableDictionary alloc]init];
        self.whiteMobSprites = [[NSMutableDictionary alloc]init];
        self.pinkMobSprites = [[NSMutableDictionary alloc]init];
        
        self.levelList = [[NSMutableDictionary alloc]init];
        self.rowPositionData = [[RowPositions alloc]init];
        
        //Check hiScore persistence or save a new file
        persistHiScoreElement = [[PersistElements alloc]initHiScores];
        
        currentScore  = 0;
        currentMultiplier = 1;
        levelPercentComplete = 0;
        level = 1;
    }
    return self;
}

//GamePlayLayer Injection
-(void)injectGamePlayLayer:(MainLayer *)gamePlayLayer
{
    CCLOG(@"---> INJECTING GamePlay Layer  ..with RC: %d",[gamePlayLayer retainCount]);
    injectedGamePlayLayer = gamePlayLayer;
    CCLOG(@"---> INJECTED                  ..with RC: %d",[gamePlayLayer retainCount]);
}

-(void)releaseGamePlayLayer
{
    injectedScoreLayer = nil;
}

//SCore layer injection
-(void)injectScoreLayer:(MainFGLayer *)scorePlayLayer
{
    CCLOG(@"---> INJECTING Score Layer  ..with RC: %d",[scorePlayLayer retainCount]);
    injectedScoreLayer = scorePlayLayer;
    CCLOG(@"---> INJECTED                  ..with RC: %d",[scorePlayLayer retainCount]);

}

-(void)releaseScoreLayer
{
    injectedScoreLayer = nil;
}

-(void)callBackMobMoveComplete:(id)sender
{
    [injectedGamePlayLayer mobMoveCompleted:sender];
}


//
// Hi score Utils
//
-(BOOL)submitHiScore:(int)lastScore
{
    return [persistHiScoreElement pushScoreAndSave:lastScore];
}

-(NSMutableArray*)getHiScoreArray
{
    return [persistHiScoreElement getHiScores];
}

//
// Level utils.
//

-(void)increaseLevelCount
{
    level++;
}

-(void)resetLevelCount
{
    level = 1;
}

-(int)getWaveCountByCurrentLevel
{
    return currentPlayingLevel.waveCount;
}

-(float)getCurrentTimeBetweenWaves
{
    return currentPlayingLevel.lineTime;
}

-(float) getCurrentSpeed
{
    return currentPlayingLevel.baseSpeed;
}

-(NSString *)getCurrentLevelName
{
    return currentPlayingLevel.levelName;
}


-(void)setDeadMob:(int)mobTag
{
    [currentPlayingLevel setDeadMob:mobTag];
}

-(BOOL)isLevelCompleted
{
    return [currentPlayingLevel isAllMobsDead];
}

-(NSMutableArray*) getMobListArray
{
    return [currentPlayingLevel getCurrentMobAliveStatus];
}

-(int)getBackGroundParticle
{
    return currentPlayingLevel.bgParticle;
}

-(NSString*) getBackGroundMusic
{
    return currentPlayingLevel.music;
}

-(float)getDropDelay
{
    return currentPlayingLevel.dropDelay;
}

-(float)getPumpSpace
{
    return currentPlayingLevel.pumpSpace;
}

//Call to parse and load the levels, return BOOL 
-(BOOL)loadAndParseLevels
{
    [[LevelJsonParser instance]loadAndParseLevelFile];
    return YES;
}

//Create the start positions
-(void)setStartPositions
{
           
}

-(CGPoint) getStartPositionByRowCount:(int) rowCount andPosition:(int)position;
{
    return [rowPositionData getRowPositionByRowCount:rowCount andPositionRequired:position];
}

-(int) getRowCountSizeByRowNumber:(int)rowNumber
{
    NSMutableArray* rowData =  currentPlayingLevel.rowSizeCountArray;
    return [[rowData objectAtIndex:rowNumber]intValue];
}

//Load a level from the LevelsLoader populated array
-(BOOL)loadLevel:(int)levelToLoad withLayer:(CCLayer *)layer
{
    BOOL allValid = YES;
        
    //Hopefully arrays keep the order, and need some more rubust defensive codign in here.
    currentPlayingLevel = [levelList objectForKey:[NSNumber numberWithInt:levelToLoad]];
    currentMobDisplayedCount = 0; //reset the current displayed (so far) mobs
 
    //Now create all the mobs in an array.
    [mobsArray removeAllObjects];
 
    CCLOG(@"Processing rows into Sprite elements...");
    
    NSMutableArray* rowData = currentPlayingLevel.rowData;
    NSMutableArray* patternData = currentPlayingLevel.patternData;
    NSMutableArray* rowCountData = currentPlayingLevel.rowSizeCountArray;
    int waveCount = currentPlayingLevel.waveCount;
    int currentSpriteTag = 0;
    
    for (int x = 0; x < waveCount; x++)
    {
        NSString* singleRow = [rowData objectAtIndex:x];
        NSString* singlePattern = [patternData objectAtIndex:x];
        int currentRowCount = [[rowCountData objectAtIndex:x]intValue];
        
        CCLOG(@"Working on ROW : %i/%i -- %@ | %@  | rows: %d, -- TAG: %d", x+1, waveCount, singleRow, singlePattern, currentRowCount, currentSpriteTag);
        
        for (int y = 0; y < currentRowCount; y++)
        {
            int singleRowNum = [[NSNumber numberWithUnsignedChar:[singleRow characterAtIndex:y]]intValue] - 48;// as its a char need to revert to a real num 
            int singleCharPattern = [[NSNumber numberWithUnsignedChar:[singlePattern characterAtIndex:y]]intValue] -48;// down the ascII table.. 
            
            MobElement* mobCreated = [[MobElement alloc]init];
            
            if (singleRowNum == 0)
            {
                mobCreated.isEmptySpace = YES;
            }
            else
            {
                mobCreated.isEmptySpace = NO; // a real object
                NSString* mobType = [self convertNumberToSpriteType:singleRowNum];
                CCSprite* copyOfSprite = [actualMobSprites objectForKey:mobType];
                CCSprite* sprite = [[CCSprite alloc]initWithTexture:copyOfSprite.texture];
                
                sprite.anchorPoint = ccp(0.5f, 0.5f);
                sprite.tag = currentSpriteTag;
                
                //Need more protective coding here..
                
                //Insert the start posistion 
                CGPoint mobStartLocation = [self getStartPositionByRowCount:currentRowCount andPosition:y];
                sprite.position = mobStartLocation;
                mobCreated.initPos = mobStartLocation;
                
                [mobCreated addSprite:sprite]; //Add the sprite here...
                mobCreated.mobType = [self insertMobEnumFromSpriteNumber:singleRowNum];
                
                //Get the required pattern
                CCSequence* aSeq = [self getPatternFromInt:singleCharPattern movementModifer:0.0f withTag:currentSpriteTag currentPos:mobStartLocation withLayer:layer];
                
                mobCreated.actionSequenceToRun = [aSeq copy];                                                            
                currentSpriteTag++;
            }
            
           
            //Put into the main array.
            [mobsArray addObject:mobCreated];
        }
        
        CCLOG(@"All elements added to the mobsArray, in order.. total added %d", currentSpriteTag);

    }
    CCLOG(@"TOTAL MobARRAY : %d",[mobsArray count]);
    [currentPlayingLevel resetMobAliveStatus:(currentSpriteTag)]; // reset the mobs with the correct count.
    return allValid;
}

//Sprite functionality

//
-(id) getPatternFromInt:(int) patternNumber movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos withLayer:(CCLayer *)layer
{
    switch (patternNumber){
        case 0: return nil;
        case 1: return [[FlightPaths instance]getSequence:STRAIGHT movementModifer:movementModifier withTag:tag currentPos:currentPos];
        case 2: return [[FlightPaths instance]getSequence:FAST_IN_OUT movementModifer:movementModifier withTag:tag currentPos:currentPos];
        case 3: return [[FlightPaths instance]getSequence:SLOW_IN_OUT movementModifer:movementModifier withTag:tag currentPos:currentPos];
        case 4: return [[FlightPaths instance]getSequence:BEZIER_ONE movementModifer:movementModifier withTag:tag currentPos:currentPos];
        case 5: return [[FlightPaths instance]getSequence:ZOOM movementModifer:movementModifier withTag:tag currentPos:currentPos];
        default:
            return nil;
    }
}


-(NSString*) convertNumberToSpriteType:(int) spriteNumber
{
    //This is just horrid, but will work for the time..
    switch (spriteNumber) {
        case 1:return @"RED";
        case 2:return @"YELLOW";
        case 3:return @"BLUE";
        case 4:return @"GREEN";
        case 5:return @"PINK";
        case 6:return @"PURPLE";
        case 7:return @"WHITE";
        default:
            return @"EMPTY";
    }
}

-(MOB_COLOUR) insertMobEnumFromSpriteNumber:(int) spriteNumber
{    
   
    //This is just horrid, but will work for the time..
    switch (spriteNumber) {
        case 1:return RED;
        case 2:return YELLOW;
        case 3:return BLUE;
        case 4:return GREEN;
        case 5:return PINK;
        case 6:return PURPLE;
        case 7:return WHITE;
        default:
            return RED; //crap to clean
    }
}

-(void)loadSprites
{
    //hardcoded for the moment.. need to change to a more dynamic solution
    CCSprite* redMob = [CCSprite spriteWithFile:[Properties instance].RED_SPRITE_FILE];
    CCSprite* yellowMob = [CCSprite spriteWithFile:[Properties instance].YELLOW_SPRITE_FILE];
    CCSprite* blueMob = [CCSprite spriteWithFile:[Properties instance].BLUE_SPRITE_FILE];
    CCSprite* greenMob = [CCSprite spriteWithFile:[Properties instance].GREEN_SPRITE_FILE];
    CCSprite* pinkMob = [CCSprite spriteWithFile:[Properties instance].PINK_SPRITE_FILE];
    CCSprite* purpleMob = [CCSprite spriteWithFile:[Properties instance].PURPLE_SPRITE_FILE];
    CCSprite* whiteMob = [CCSprite spriteWithFile:[Properties instance].WHITE_SPRITE_FILE];
    
    [actualMobSprites setObject:redMob forKey:@"RED"];
    [actualMobSprites setObject:yellowMob forKey:@"YELLOW"];
    [actualMobSprites setObject:blueMob forKey:@"BLUE"];
    [actualMobSprites setObject:greenMob forKey:@"GREEN"];
    [actualMobSprites setObject:pinkMob forKey:@"PINK"];
    [actualMobSprites setObject:purpleMob forKey:@"PURPLE"];
    [actualMobSprites setObject:whiteMob forKey:@"WHITE"];
    
    //New code for loading all the new Spites in
    NSString* appender;
    NSString* header;
    NSString* loadingString;
    if (self.isHdMode == YES)
    {
        CCSprite* red_1 = [CCSprite spriteWithFile:@"1_redHD.png"];
        CCSprite* red_2 = [CCSprite spriteWithFile:@"2_redHD.png"];
        CCSprite* red_3 = [CCSprite spriteWithFile:@"3_redHD.png"];
        CCSprite* red_4 = [CCSprite spriteWithFile:@"4_redHD.png"];
        CCSprite* red_5 = [CCSprite spriteWithFile:@"5_redHD.png"];
        CCSprite* red_6 = [CCSprite spriteWithFile:@"6_redHD.png"];
        CCSprite* red_7 = [CCSprite spriteWithFile:@"7_redHD.png"];
        CCSprite* red_8 = [CCSprite spriteWithFile:@"8_redHD.png"];
        CCSprite* red_9 = [CCSprite spriteWithFile:@"9_redHD.png"];
        CCSprite* red_10 = [CCSprite spriteWithFile:@"10_redHD.png"];
        CCSprite* red_11 = [CCSprite spriteWithFile:@"11_redHD.png"];
        CCSprite* red_12 = [CCSprite spriteWithFile:@"12_redHD.png"];
        CCSprite* red_13 = [CCSprite spriteWithFile:@"13_redHD.png"];
        CCSprite* red_14 = [CCSprite spriteWithFile:@"14_redHD.png"];
        CCSprite* red_15 = [CCSprite spriteWithFile:@"15_redHD.png"];
        CCSprite* red_16 = [CCSprite spriteWithFile:@"16_redHD.png"];

        CCSprite* green_1 = [CCSprite spriteWithFile:@"1_greenHD.png"];
        CCSprite* green_2 = [CCSprite spriteWithFile:@"2_greenHD.png"];
        CCSprite* green_3 = [CCSprite spriteWithFile:@"3_greenHD.png"];
        CCSprite* green_4 = [CCSprite spriteWithFile:@"4_greenHD.png"];
        CCSprite* green_5 = [CCSprite spriteWithFile:@"5_greenHD.png"];
        CCSprite* green_6 = [CCSprite spriteWithFile:@"6_greenHD.png"];
        CCSprite* green_7 = [CCSprite spriteWithFile:@"7_greenHD.png"];
        CCSprite* green_8 = [CCSprite spriteWithFile:@"8_greenHD.png"];
        CCSprite* green_9 = [CCSprite spriteWithFile:@"9_greenHD.png"];
        CCSprite* green_10 = [CCSprite spriteWithFile:@"10_greenHD.png"];
        CCSprite* green_11 = [CCSprite spriteWithFile:@"11_greenHD.png"];
        CCSprite* green_12 = [CCSprite spriteWithFile:@"12_greenHD.png"];
        CCSprite* green_13 = [CCSprite spriteWithFile:@"13_greenHD.png"];
        CCSprite* green_14 = [CCSprite spriteWithFile:@"14_greenHD.png"];
        CCSprite* green_15 = [CCSprite spriteWithFile:@"15_greenHD.png"];
        CCSprite* green_16 = [CCSprite spriteWithFile:@"16_greenHD.png"];
        
        CCSprite* green_1 = [CCSprite spriteWithFile:@"1_greenHD.png"];
        CCSprite* green_2 = [CCSprite spriteWithFile:@"2_greenHD.png"];
        CCSprite* green_3 = [CCSprite spriteWithFile:@"3_greenHD.png"];
        CCSprite* green_4 = [CCSprite spriteWithFile:@"4_greenHD.png"];
        CCSprite* green_5 = [CCSprite spriteWithFile:@"5_greenHD.png"];
        CCSprite* green_6 = [CCSprite spriteWithFile:@"6_greenHD.png"];
        CCSprite* green_7 = [CCSprite spriteWithFile:@"7_greenHD.png"];
        CCSprite* green_8 = [CCSprite spriteWithFile:@"8_greenHD.png"];
        CCSprite* green_9 = [CCSprite spriteWithFile:@"9_greenHD.png"];
        CCSprite* green_10 = [CCSprite spriteWithFile:@"10_greenHD.png"];
        CCSprite* green_11 = [CCSprite spriteWithFile:@"11_greenHD.png"];
        CCSprite* green_12 = [CCSprite spriteWithFile:@"12_greenHD.png"];
        CCSprite* green_13 = [CCSprite spriteWithFile:@"13_greenHD.png"];
        CCSprite* green_14 = [CCSprite spriteWithFile:@"14_greenHD.png"];
        CCSprite* green_15 = [CCSprite spriteWithFile:@"15_greenHD.png"];
        CCSprite* green_16 = [CCSprite spriteWithFile:@"16_greenHD.png"];
        
        
    }else {
        appender = @".png";
    }
    
}

-(MobElement*)getMobBySpriteTag:(int)tag
{
    MobElement* mob = nil;
    for (MobElement* m in mobsArray)
    {
        if (m.spriteTag == tag)
        {
            mob = m;
            return mob;
        }
    }
    return mob;
}

-(CGPoint)getInitPosBySpriteTag:(int)tag
{
    MobElement* mob = nil;
    mob = [self getMobBySpriteTag:tag];
    if (mob != nil)
    {
        return mob.initPos;
    }
    CGPoint deadPoint;
    return deadPoint;
}

-(MobElement*)whichMobTouched:(CGPoint)touchPoint
{
    MobElement* mob = nil;
    for (MobElement* m in mobsArray)
    {
        CCSprite* mSprite = [m getSprite];
        if (CGRectContainsPoint(mSprite.boundingBox, touchPoint))
        {
            CCLOG(@"Found a mob %d", m.spriteTag);
            //Found a touched sprite.. so return the mob.
            return m;
        }
    }
    
    return mob;
}

-(void)pumpVisableMobs
{
    for (MobElement* m in mobsArray)
    {
        if (m.isAlive)
        {
            if (!m.isPumping)
            {
                CCSprite* s = [m getSprite];
                {
                    CCScaleTo* scale1 = [CCScaleTo actionWithDuration:0.3f scale:1.3f];
                    CCScaleTo* scale2 = [CCScaleTo actionWithDuration:0.1f scale:1.0f];
                    CCDelayTime* delay = [CCDelayTime actionWithDuration:0.5f];
                    CCSequence* seq = [CCSequence actions:scale1,scale2, delay, nil];
                    CCRepeatForever* rep = [CCRepeatForever actionWithAction:seq];
                
                    [s runAction:rep];
                }
                m.isPumping = YES;
            }
        }
    }
}

-(NSArray*)getMobsForRenderRangeFrom:(int) startRange to:(int)endRange;
{
    NSMutableArray* mArray = [[NSMutableArray alloc]init];
    int maxSize = [mobsArray count];
    
    if (endRange > maxSize) return nil;
    
    for (int cPos = startRange; cPos < endRange; cPos ++)
    {
        [mArray addObject:[mobsArray objectAtIndex:cPos]];
    }
    NSArray* retArray = [[NSArray alloc]initWithArray:mArray];
    [mArray release];
    return [retArray autorelease];
}

//Level Loading and setting
-(void)addLevelToLevelList:(LevelElementData *)levelDataElement
{
    //need to retain?
    //switched to a dict now for quick level lookup when loadign a new level.
    NSNumber* levelId = [NSNumber numberWithInt:levelDataElement.levelId]; 
    [levelList setObject:levelDataElement forKey:levelId];
    CCLOG(@"LevelList Count : %d", [levelList count]);
}


//Score stuff
-(void)incMultiplier
{
    currentMultiplier = currentMultiplier * 2;
    currentMultiplierCountDownSpeed = currentMultiplierCountDownSpeed + MULTIPLIER_INC_SPEED;
    [self pokeMultiplier];
}

-(void)decMultiplier
{
    if (currentMultiplier !=1)
    {
        currentMultiplier = currentMultiplier / 2;
        currentMultiplierCountDownSpeed = currentMultiplierCountDownSpeed - MULTIPLIER_INC_SPEED;
        [self pokeMultiplier];
    }
}

-(void)resetMultiplier
{
    currentMultiplier = 1;
    currentMultiplierCountDownSpeed = MULTIPLIER_BASE_SPEED;
    [self pokeMultiplier];
}

-(int)getMultipiler
{
    return currentMultiplier;
}

-(void)addToScore:(int) addAmount
{
    currentScore = currentScore + (addAmount * currentMultiplier);
    [self pokeScoreLayer];
}

-(int)getCurrentScore
{
    return currentScore;
}

-(void)resetScore
{
    currentScore = 0;
}

-(void)pokeScoreLayer
{
    if (injectedScoreLayer != nil)
    {
        [injectedScoreLayer callBackPokeUpdate];
    }
}

-(void)pokeMultiplier
{
    if (injectedScoreLayer != nil)
    {
        [injectedScoreLayer callBackMultiplierUpdated];
    }
}

-(void)pokePercentageComplete:(float)newPercentage;
{
    self.levelPercentComplete = newPercentage;
    [self pokeScoreLayer];
}

-(void)increaseMobDisplayCount:(int)incAmount
{
    currentMobDisplayedCount = currentMobDisplayedCount + incAmount;
}

-(void)dealloc
{
    [rowPositionData release];
    [mobsArray release];
    [redMobSprites release];
    [yellowMobSprites release];
    [blueMobSprites release];
    [greenMobSprites release];
    [whiteMobSprites release];
    [pinkMobSprites release];
    [levelList release];
    [iosDeviceProperties release];
    [persistHiScoreElement release];
    [super dealloc];
}

@end
