//
//  BlastedEngine.m
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo. All rights reserved.
//

#import "BlastedEngine.h"


@implementation BlastedEngine

@synthesize iosDeviceProperties, isHdMode, sound,
            currentScore, mobsArray, level, levelList, currentMobDisplayedCount, 
            currentPlayingLevel, currentMultiplier, 
            currentMultiplierCountDownSpeed ,levelPercentComplete, hiScores, rowPositionData,
            redMobSprites, yellowMobSprites, blueMobSprites, greenMobSprites, whiteMobSprites, pinkMobSprites, purpleMobSprites;

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
        //Default to set sound enabled
        self.sound = YES;
        
        
        //Load the properties files up now
        [Properties instance];
        
        //Now allocate all teh arrays
        self.iosDeviceProperties = [[NSMutableDictionary alloc]init];
        
        self.mobsArray = [[NSMutableArray alloc]init];
        self.redMobSprites = [[NSMutableArray alloc]init];
        self.yellowMobSprites = [[NSMutableArray alloc]init];
        self.greenMobSprites = [[NSMutableArray alloc]init];
        self.blueMobSprites = [[NSMutableArray alloc]init];
        self.whiteMobSprites = [[NSMutableArray alloc]init];
        self.pinkMobSprites = [[NSMutableArray alloc]init];
        self.purpleMobSprites = [[NSMutableArray alloc]init];
        
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
    injectedGamePlayLayer = gamePlayLayer;
}

-(void)releaseGamePlayLayer
{
    injectedScoreLayer = nil;
}

//SCore layer injection
-(void)injectScoreLayer:(MainFGLayer *)scorePlayLayer
{
    injectedScoreLayer = scorePlayLayer;

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
                
                CCSprite* copyOfSprite = [self getValidRandomSpriteFromSpriteNumber:singleRowNum];
                
                CCSprite* sprite = [[CCSprite alloc]initWithTexture:copyOfSprite.texture];
                
                sprite.anchorPoint = ccp(0.5f, 0.5f);
                sprite.tag = currentSpriteTag;
                
                //Insert the start posistion 
                CGPoint mobStartLocation = [self getStartPositionByRowCount:currentRowCount andPosition:y];
                sprite.position = mobStartLocation;
                mobCreated.initPos = mobStartLocation;
                
                [mobCreated addSprite:sprite]; //Add the sprite here...
                mobCreated.mobType = [self insertMobEnumFromSpriteNumber:singleRowNum];
                
                //Get the required pattern
                CCSequence* aSeq = [[CCSequence alloc]init];
                aSeq = [self getPatternFromInt:singleCharPattern movementModifer:0.0f withTag:currentSpriteTag currentPos:mobStartLocation withLayer:layer];
                
                mobCreated.actionSequenceToRun = aSeq;
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


-(CCSprite*)getValidRandomSpriteFromSpriteNumber:(int)spriteNumber
{
    //First choose a random number from 1 - 16 
    NSInteger delta = arc4random() %15 + 1;
    CCLOG(@"Random Number is %d",delta);
    
    //Now based on the type, get the relevent sprite.
    MOB_COLOUR mobColour = [self insertMobEnumFromSpriteNumber:spriteNumber];
    
    switch (mobColour) {
        case RED:
            return [redMobSprites objectAtIndex:delta];
        case YELLOW:
            return [redMobSprites objectAtIndex:delta];
        case BLUE:
            return [redMobSprites objectAtIndex:delta];
        case GREEN:
            return [redMobSprites objectAtIndex:delta];
        case WHITE:
            return [redMobSprites objectAtIndex:delta];
        case PINK:
            return [redMobSprites objectAtIndex:delta];
        case PURPLE:
            return [purpleMobSprites objectAtIndex:delta];
        default:
            break;
    }
    return NULL;
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
                CCSprite* s = [m getSprite];
                {
                    CCScaleTo* scale1 = [CCScaleTo actionWithDuration:0.3f scale:1.3f];
                    CCScaleTo* scale2 = [CCScaleTo actionWithDuration:0.1f scale:1.0f];
                    CCSequence* seq = [CCSequence actions:scale1,scale2, nil];
                
                    [s runAction:seq];
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
    return retArray;
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



//Crap sprite loading..

-(void)loadSprites
{
    
    //New code for loading all the new Spites in
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
        
        CCSprite* yellow_1 = [CCSprite spriteWithFile:@"1_yellowHD.png"];
        CCSprite* yellow_2 = [CCSprite spriteWithFile:@"2_yellowHD.png"];
        CCSprite* yellow_3 = [CCSprite spriteWithFile:@"3_yellowHD.png"];
        CCSprite* yellow_4 = [CCSprite spriteWithFile:@"4_yellowHD.png"];
        CCSprite* yellow_5 = [CCSprite spriteWithFile:@"5_yellowHD.png"];
        CCSprite* yellow_6 = [CCSprite spriteWithFile:@"6_yellowHD.png"];
        CCSprite* yellow_7 = [CCSprite spriteWithFile:@"7_yellowHD.png"];
        CCSprite* yellow_8 = [CCSprite spriteWithFile:@"8_yellowHD.png"];
        CCSprite* yellow_9 = [CCSprite spriteWithFile:@"9_yellowHD.png"];
        CCSprite* yellow_10 = [CCSprite spriteWithFile:@"10_yellowHD.png"];
        CCSprite* yellow_11 = [CCSprite spriteWithFile:@"11_yellowHD.png"];
        CCSprite* yellow_12 = [CCSprite spriteWithFile:@"12_yellowHD.png"];
        CCSprite* yellow_13 = [CCSprite spriteWithFile:@"13_yellowHD.png"];
        CCSprite* yellow_14 = [CCSprite spriteWithFile:@"14_yellowHD.png"];
        CCSprite* yellow_15 = [CCSprite spriteWithFile:@"15_yellowHD.png"];
        CCSprite* yellow_16 = [CCSprite spriteWithFile:@"16_yellowHD.png"];
        
        CCSprite* blue_1 = [CCSprite spriteWithFile:@"1_blueHD.png"];
        CCSprite* blue_2 = [CCSprite spriteWithFile:@"2_blueHD.png"];
        CCSprite* blue_3 = [CCSprite spriteWithFile:@"3_blueHD.png"];
        CCSprite* blue_4 = [CCSprite spriteWithFile:@"4_blueHD.png"];
        CCSprite* blue_5 = [CCSprite spriteWithFile:@"5_blueHD.png"];
        CCSprite* blue_6 = [CCSprite spriteWithFile:@"6_blueHD.png"];
        CCSprite* blue_7 = [CCSprite spriteWithFile:@"7_blueHD.png"];
        CCSprite* blue_8 = [CCSprite spriteWithFile:@"8_blueHD.png"];
        CCSprite* blue_9 = [CCSprite spriteWithFile:@"9_blueHD.png"];
        CCSprite* blue_10 = [CCSprite spriteWithFile:@"10_blueHD.png"];
        CCSprite* blue_11 = [CCSprite spriteWithFile:@"11_blueHD.png"];
        CCSprite* blue_12 = [CCSprite spriteWithFile:@"12_blueHD.png"];
        CCSprite* blue_13 = [CCSprite spriteWithFile:@"13_blueHD.png"];
        CCSprite* blue_14 = [CCSprite spriteWithFile:@"14_blueHD.png"];
        CCSprite* blue_15 = [CCSprite spriteWithFile:@"15_blueHD.png"];
        CCSprite* blue_16 = [CCSprite spriteWithFile:@"16_blueHD.png"];
        
        CCSprite* white_1 = [CCSprite spriteWithFile:@"1_whiteHD.png"];
        CCSprite* white_2 = [CCSprite spriteWithFile:@"2_whiteHD.png"];
        CCSprite* white_3 = [CCSprite spriteWithFile:@"3_whiteHD.png"];
        CCSprite* white_4 = [CCSprite spriteWithFile:@"4_whiteHD.png"];
        CCSprite* white_5 = [CCSprite spriteWithFile:@"5_whiteHD.png"];
        CCSprite* white_6 = [CCSprite spriteWithFile:@"6_whiteHD.png"];
        CCSprite* white_7 = [CCSprite spriteWithFile:@"7_whiteHD.png"];
        CCSprite* white_8 = [CCSprite spriteWithFile:@"8_whiteHD.png"];
        CCSprite* white_9 = [CCSprite spriteWithFile:@"9_whiteHD.png"];
        CCSprite* white_10 = [CCSprite spriteWithFile:@"10_whiteHD.png"];
        CCSprite* white_11 = [CCSprite spriteWithFile:@"11_whiteHD.png"];
        CCSprite* white_12 = [CCSprite spriteWithFile:@"12_whiteHD.png"];
        CCSprite* white_13 = [CCSprite spriteWithFile:@"13_whiteHD.png"];
        CCSprite* white_14 = [CCSprite spriteWithFile:@"14_whiteHD.png"];
        CCSprite* white_15 = [CCSprite spriteWithFile:@"15_whiteHD.png"];
        CCSprite* white_16 = [CCSprite spriteWithFile:@"16_whiteHD.png"];
        
        CCSprite* pink_1 = [CCSprite spriteWithFile:@"1_pinkHD.png"];
        CCSprite* pink_2 = [CCSprite spriteWithFile:@"2_pinkHD.png"];
        CCSprite* pink_3 = [CCSprite spriteWithFile:@"3_pinkHD.png"];
        CCSprite* pink_4 = [CCSprite spriteWithFile:@"4_pinkHD.png"];
        CCSprite* pink_5 = [CCSprite spriteWithFile:@"5_pinkHD.png"];
        CCSprite* pink_6 = [CCSprite spriteWithFile:@"6_pinkHD.png"];
        CCSprite* pink_7 = [CCSprite spriteWithFile:@"7_pinkHD.png"];
        CCSprite* pink_8 = [CCSprite spriteWithFile:@"8_pinkHD.png"];
        CCSprite* pink_9 = [CCSprite spriteWithFile:@"9_pinkHD.png"];
        CCSprite* pink_10 = [CCSprite spriteWithFile:@"10_pinkHD.png"];
        CCSprite* pink_11 = [CCSprite spriteWithFile:@"11_pinkHD.png"];
        CCSprite* pink_12 = [CCSprite spriteWithFile:@"12_pinkHD.png"];
        CCSprite* pink_13 = [CCSprite spriteWithFile:@"13_pinkHD.png"];
        CCSprite* pink_14 = [CCSprite spriteWithFile:@"14_pinkHD.png"];
        CCSprite* pink_15 = [CCSprite spriteWithFile:@"15_pinkHD.png"];
        CCSprite* pink_16 = [CCSprite spriteWithFile:@"16_pinkHD.png"];
        
        CCSprite* purple_1 = [CCSprite spriteWithFile:@"1_purpleHD.png"];
        CCSprite* purple_2 = [CCSprite spriteWithFile:@"2_purpleHD.png"];
        CCSprite* purple_3 = [CCSprite spriteWithFile:@"3_purpleHD.png"];
        CCSprite* purple_4 = [CCSprite spriteWithFile:@"4_purpleHD.png"];
        CCSprite* purple_5 = [CCSprite spriteWithFile:@"5_purpleHD.png"];
        CCSprite* purple_6 = [CCSprite spriteWithFile:@"6_purpleHD.png"];
        CCSprite* purple_7 = [CCSprite spriteWithFile:@"7_purpleHD.png"];
        CCSprite* purple_8 = [CCSprite spriteWithFile:@"8_purpleHD.png"];
        CCSprite* purple_9 = [CCSprite spriteWithFile:@"9_purpleHD.png"];
        CCSprite* purple_10 = [CCSprite spriteWithFile:@"10_purpleHD.png"];
        CCSprite* purple_11 = [CCSprite spriteWithFile:@"11_purpleHD.png"];
        CCSprite* purple_12 = [CCSprite spriteWithFile:@"12_purpleHD.png"];
        CCSprite* purple_13 = [CCSprite spriteWithFile:@"13_purpleHD.png"];
        CCSprite* purple_14 = [CCSprite spriteWithFile:@"14_purpleHD.png"];
        CCSprite* purple_15 = [CCSprite spriteWithFile:@"15_purpleHD.png"];
        CCSprite* purple_16 = [CCSprite spriteWithFile:@"16_purpleHD.png"];
        
        
        [redMobSprites addObject:red_1];
        [redMobSprites addObject:red_2];
        [redMobSprites addObject:red_3];
        [redMobSprites addObject:red_4];
        [redMobSprites addObject:red_5];
        [redMobSprites addObject:red_6];
        [redMobSprites addObject:red_7];
        [redMobSprites addObject:red_8];
        [redMobSprites addObject:red_9];
        [redMobSprites addObject:red_10];
        [redMobSprites addObject:red_11];
        [redMobSprites addObject:red_12];
        [redMobSprites addObject:red_13];
        [redMobSprites addObject:red_14];
        [redMobSprites addObject:red_15];
        [redMobSprites addObject:red_16];
        
        [greenMobSprites addObject:green_1];
        [greenMobSprites addObject:green_2];
        [greenMobSprites addObject:green_3];
        [greenMobSprites addObject:green_4];
        [greenMobSprites addObject:green_5];
        [greenMobSprites addObject:green_6];
        [greenMobSprites addObject:green_7];
        [greenMobSprites addObject:green_8];
        [greenMobSprites addObject:green_9];
        [greenMobSprites addObject:green_10];
        [greenMobSprites addObject:green_11];
        [greenMobSprites addObject:green_12];
        [greenMobSprites addObject:green_13];
        [greenMobSprites addObject:green_14];
        [greenMobSprites addObject:green_15];
        [greenMobSprites addObject:green_16];
        
        [yellowMobSprites addObject:yellow_1];
        [yellowMobSprites addObject:yellow_2];
        [yellowMobSprites addObject:yellow_3];
        [yellowMobSprites addObject:yellow_4];
        [yellowMobSprites addObject:yellow_5];
        [yellowMobSprites addObject:yellow_6];
        [yellowMobSprites addObject:yellow_7];
        [yellowMobSprites addObject:yellow_8];
        [yellowMobSprites addObject:yellow_9];
        [yellowMobSprites addObject:yellow_10];
        [yellowMobSprites addObject:yellow_11];
        [yellowMobSprites addObject:yellow_12];
        [yellowMobSprites addObject:yellow_13];
        [yellowMobSprites addObject:yellow_14];
        [yellowMobSprites addObject:yellow_15];
        [yellowMobSprites addObject:yellow_16];
        
        [blueMobSprites addObject:blue_1];
        [blueMobSprites addObject:blue_2];
        [blueMobSprites addObject:blue_3];
        [blueMobSprites addObject:blue_4];
        [blueMobSprites addObject:blue_5];
        [blueMobSprites addObject:blue_6];
        [blueMobSprites addObject:blue_7];
        [blueMobSprites addObject:blue_8];
        [blueMobSprites addObject:blue_9];
        [blueMobSprites addObject:blue_10];
        [blueMobSprites addObject:blue_11];
        [blueMobSprites addObject:blue_12];
        [blueMobSprites addObject:blue_13];
        [blueMobSprites addObject:blue_14];
        [blueMobSprites addObject:blue_15];
        [blueMobSprites addObject:blue_16];
        
        [whiteMobSprites addObject:white_1];
        [whiteMobSprites addObject:white_2];
        [whiteMobSprites addObject:white_3];
        [whiteMobSprites addObject:white_4];
        [whiteMobSprites addObject:white_5];
        [whiteMobSprites addObject:white_6];
        [whiteMobSprites addObject:white_7];
        [whiteMobSprites addObject:white_8];
        [whiteMobSprites addObject:white_9];
        [whiteMobSprites addObject:white_10];
        [whiteMobSprites addObject:white_11];
        [whiteMobSprites addObject:white_12];
        [whiteMobSprites addObject:white_13];
        [whiteMobSprites addObject:white_14];
        [whiteMobSprites addObject:white_15];
        [whiteMobSprites addObject:white_16];
        
        [pinkMobSprites addObject:pink_1];
        [pinkMobSprites addObject:pink_2];
        [pinkMobSprites addObject:pink_3];
        [pinkMobSprites addObject:pink_4];
        [pinkMobSprites addObject:pink_5];
        [pinkMobSprites addObject:pink_6];
        [pinkMobSprites addObject:pink_7];
        [pinkMobSprites addObject:pink_8];
        [pinkMobSprites addObject:pink_9];
        [pinkMobSprites addObject:pink_10];
        [pinkMobSprites addObject:pink_11];
        [pinkMobSprites addObject:pink_12];
        [pinkMobSprites addObject:pink_13];
        [pinkMobSprites addObject:pink_14];
        [pinkMobSprites addObject:pink_15];
        [pinkMobSprites addObject:pink_16];
        
        [purpleMobSprites addObject:purple_1];
        [purpleMobSprites addObject:purple_2];
        [purpleMobSprites addObject:purple_3];
        [purpleMobSprites addObject:purple_4];
        [purpleMobSprites addObject:purple_5];
        [purpleMobSprites addObject:purple_6];
        [purpleMobSprites addObject:purple_7];
        [purpleMobSprites addObject:purple_8];
        [purpleMobSprites addObject:purple_9];
        [purpleMobSprites addObject:purple_10];
        [purpleMobSprites addObject:purple_11];
        [purpleMobSprites addObject:purple_12];
        [purpleMobSprites addObject:purple_13];
        [purpleMobSprites addObject:purple_14];
        [purpleMobSprites addObject:purple_15];
        [purpleMobSprites addObject:purple_16];
        
    }else {
        CCSprite* red_1 = [CCSprite spriteWithFile:@"1_red.png"];
        CCSprite* red_2 = [CCSprite spriteWithFile:@"2_red.png"];
        CCSprite* red_3 = [CCSprite spriteWithFile:@"3_red.png"];
        CCSprite* red_4 = [CCSprite spriteWithFile:@"4_red.png"];
        CCSprite* red_5 = [CCSprite spriteWithFile:@"5_red.png"];
        CCSprite* red_6 = [CCSprite spriteWithFile:@"6_red.png"];
        CCSprite* red_7 = [CCSprite spriteWithFile:@"7_red.png"];
        CCSprite* red_8 = [CCSprite spriteWithFile:@"8_red.png"];
        CCSprite* red_9 = [CCSprite spriteWithFile:@"9_red.png"];
        CCSprite* red_10 = [CCSprite spriteWithFile:@"10_red.png"];
        CCSprite* red_11 = [CCSprite spriteWithFile:@"11_red.png"];
        CCSprite* red_12 = [CCSprite spriteWithFile:@"12_red.png"];
        CCSprite* red_13 = [CCSprite spriteWithFile:@"13_red.png"];
        CCSprite* red_14 = [CCSprite spriteWithFile:@"14_red.png"];
        CCSprite* red_15 = [CCSprite spriteWithFile:@"15_red.png"];
        CCSprite* red_16 = [CCSprite spriteWithFile:@"16_red.png"];
        
        CCSprite* green_1 = [CCSprite spriteWithFile:@"1_green.png"];
        CCSprite* green_2 = [CCSprite spriteWithFile:@"2_green.png"];
        CCSprite* green_3 = [CCSprite spriteWithFile:@"3_green.png"];
        CCSprite* green_4 = [CCSprite spriteWithFile:@"4_green.png"];
        CCSprite* green_5 = [CCSprite spriteWithFile:@"5_green.png"];
        CCSprite* green_6 = [CCSprite spriteWithFile:@"6_green.png"];
        CCSprite* green_7 = [CCSprite spriteWithFile:@"7_green.png"];
        CCSprite* green_8 = [CCSprite spriteWithFile:@"8_green.png"];
        CCSprite* green_9 = [CCSprite spriteWithFile:@"9_green.png"];
        CCSprite* green_10 = [CCSprite spriteWithFile:@"10_green.png"];
        CCSprite* green_11 = [CCSprite spriteWithFile:@"11_green.png"];
        CCSprite* green_12 = [CCSprite spriteWithFile:@"12_green.png"];
        CCSprite* green_13 = [CCSprite spriteWithFile:@"13_green.png"];
        CCSprite* green_14 = [CCSprite spriteWithFile:@"14_green.png"];
        CCSprite* green_15 = [CCSprite spriteWithFile:@"15_green.png"];
        CCSprite* green_16 = [CCSprite spriteWithFile:@"16_green.png"];
        
        CCSprite* yellow_1 = [CCSprite spriteWithFile:@"1_yellow.png"];
        CCSprite* yellow_2 = [CCSprite spriteWithFile:@"2_yellow.png"];
        CCSprite* yellow_3 = [CCSprite spriteWithFile:@"3_yellow.png"];
        CCSprite* yellow_4 = [CCSprite spriteWithFile:@"4_yellow.png"];
        CCSprite* yellow_5 = [CCSprite spriteWithFile:@"5_yellow.png"];
        CCSprite* yellow_6 = [CCSprite spriteWithFile:@"6_yellow.png"];
        CCSprite* yellow_7 = [CCSprite spriteWithFile:@"7_yellow.png"];
        CCSprite* yellow_8 = [CCSprite spriteWithFile:@"8_yellow.png"];
        CCSprite* yellow_9 = [CCSprite spriteWithFile:@"9_yellow.png"];
        CCSprite* yellow_10 = [CCSprite spriteWithFile:@"10_yellow.png"];
        CCSprite* yellow_11 = [CCSprite spriteWithFile:@"11_yellow.png"];
        CCSprite* yellow_12 = [CCSprite spriteWithFile:@"12_yellow.png"];
        CCSprite* yellow_13 = [CCSprite spriteWithFile:@"13_yellow.png"];
        CCSprite* yellow_14 = [CCSprite spriteWithFile:@"14_yellow.png"];
        CCSprite* yellow_15 = [CCSprite spriteWithFile:@"15_yellow.png"];
        CCSprite* yellow_16 = [CCSprite spriteWithFile:@"16_yellow.png"];
        
        CCSprite* blue_1 = [CCSprite spriteWithFile:@"1_blue.png"];
        CCSprite* blue_2 = [CCSprite spriteWithFile:@"2_blue.png"];
        CCSprite* blue_3 = [CCSprite spriteWithFile:@"3_blue.png"];
        CCSprite* blue_4 = [CCSprite spriteWithFile:@"4_blue.png"];
        CCSprite* blue_5 = [CCSprite spriteWithFile:@"5_blue.png"];
        CCSprite* blue_6 = [CCSprite spriteWithFile:@"6_blue.png"];
        CCSprite* blue_7 = [CCSprite spriteWithFile:@"7_blue.png"];
        CCSprite* blue_8 = [CCSprite spriteWithFile:@"8_blue.png"];
        CCSprite* blue_9 = [CCSprite spriteWithFile:@"9_blue.png"];
        CCSprite* blue_10 = [CCSprite spriteWithFile:@"10_blue.png"];
        CCSprite* blue_11 = [CCSprite spriteWithFile:@"11_blue.png"];
        CCSprite* blue_12 = [CCSprite spriteWithFile:@"12_blue.png"];
        CCSprite* blue_13 = [CCSprite spriteWithFile:@"13_blue.png"];
        CCSprite* blue_14 = [CCSprite spriteWithFile:@"14_blue.png"];
        CCSprite* blue_15 = [CCSprite spriteWithFile:@"15_blue.png"];
        CCSprite* blue_16 = [CCSprite spriteWithFile:@"16_blue.png"];
        
        CCSprite* white_1 = [CCSprite spriteWithFile:@"1_white.png"];
        CCSprite* white_2 = [CCSprite spriteWithFile:@"2_white.png"];
        CCSprite* white_3 = [CCSprite spriteWithFile:@"3_white.png"];
        CCSprite* white_4 = [CCSprite spriteWithFile:@"4_white.png"];
        CCSprite* white_5 = [CCSprite spriteWithFile:@"5_white.png"];
        CCSprite* white_6 = [CCSprite spriteWithFile:@"6_white.png"];
        CCSprite* white_7 = [CCSprite spriteWithFile:@"7_white.png"];
        CCSprite* white_8 = [CCSprite spriteWithFile:@"8_white.png"];
        CCSprite* white_9 = [CCSprite spriteWithFile:@"9_white.png"];
        CCSprite* white_10 = [CCSprite spriteWithFile:@"10_white.png"];
        CCSprite* white_11 = [CCSprite spriteWithFile:@"11_white.png"];
        CCSprite* white_12 = [CCSprite spriteWithFile:@"12_white.png"];
        CCSprite* white_13 = [CCSprite spriteWithFile:@"13_white.png"];
        CCSprite* white_14 = [CCSprite spriteWithFile:@"14_white.png"];
        CCSprite* white_15 = [CCSprite spriteWithFile:@"15_white.png"];
        CCSprite* white_16 = [CCSprite spriteWithFile:@"16_white.png"];
        
        CCSprite* pink_1 = [CCSprite spriteWithFile:@"1_pink.png"];
        CCSprite* pink_2 = [CCSprite spriteWithFile:@"2_pink.png"];
        CCSprite* pink_3 = [CCSprite spriteWithFile:@"3_pink.png"];
        CCSprite* pink_4 = [CCSprite spriteWithFile:@"4_pink.png"];
        CCSprite* pink_5 = [CCSprite spriteWithFile:@"5_pink.png"];
        CCSprite* pink_6 = [CCSprite spriteWithFile:@"6_pink.png"];
        CCSprite* pink_7 = [CCSprite spriteWithFile:@"7_pink.png"];
        CCSprite* pink_8 = [CCSprite spriteWithFile:@"8_pink.png"];
        CCSprite* pink_9 = [CCSprite spriteWithFile:@"9_pink.png"];
        CCSprite* pink_10 = [CCSprite spriteWithFile:@"10_pink.png"];
        CCSprite* pink_11 = [CCSprite spriteWithFile:@"11_pink.png"];
        CCSprite* pink_12 = [CCSprite spriteWithFile:@"12_pink.png"];
        CCSprite* pink_13 = [CCSprite spriteWithFile:@"13_pink.png"];
        CCSprite* pink_14 = [CCSprite spriteWithFile:@"14_pink.png"];
        CCSprite* pink_15 = [CCSprite spriteWithFile:@"15_pink.png"];
        CCSprite* pink_16 = [CCSprite spriteWithFile:@"16_pink.png"];
        
        CCSprite* purple_1 = [CCSprite spriteWithFile:@"1_purple.png"];
        CCSprite* purple_2 = [CCSprite spriteWithFile:@"2_purple.png"];
        CCSprite* purple_3 = [CCSprite spriteWithFile:@"3_purple.png"];
        CCSprite* purple_4 = [CCSprite spriteWithFile:@"4_purple.png"];
        CCSprite* purple_5 = [CCSprite spriteWithFile:@"5_purple.png"];
        CCSprite* purple_6 = [CCSprite spriteWithFile:@"6_purple.png"];
        CCSprite* purple_7 = [CCSprite spriteWithFile:@"7_purple.png"];
        CCSprite* purple_8 = [CCSprite spriteWithFile:@"8_purple.png"];
        CCSprite* purple_9 = [CCSprite spriteWithFile:@"9_purple.png"];
        CCSprite* purple_10 = [CCSprite spriteWithFile:@"10_purple.png"];
        CCSprite* purple_11 = [CCSprite spriteWithFile:@"11_purple.png"];
        CCSprite* purple_12 = [CCSprite spriteWithFile:@"12_purple.png"];
        CCSprite* purple_13 = [CCSprite spriteWithFile:@"13_purple.png"];
        CCSprite* purple_14 = [CCSprite spriteWithFile:@"14_purple.png"];
        CCSprite* purple_15 = [CCSprite spriteWithFile:@"15_purple.png"];
        CCSprite* purple_16 = [CCSprite spriteWithFile:@"16_purple.png"];
        
        [redMobSprites addObject:red_1];
        [redMobSprites addObject:red_2];
        [redMobSprites addObject:red_3];
        [redMobSprites addObject:red_4];
        [redMobSprites addObject:red_5];
        [redMobSprites addObject:red_6];
        [redMobSprites addObject:red_7];
        [redMobSprites addObject:red_8];
        [redMobSprites addObject:red_9];
        [redMobSprites addObject:red_10];
        [redMobSprites addObject:red_11];
        [redMobSprites addObject:red_12];
        [redMobSprites addObject:red_13];
        [redMobSprites addObject:red_14];
        [redMobSprites addObject:red_15];
        [redMobSprites addObject:red_16];
        
        [greenMobSprites addObject:green_1];
        [greenMobSprites addObject:green_2];
        [greenMobSprites addObject:green_3];
        [greenMobSprites addObject:green_4];
        [greenMobSprites addObject:green_5];
        [greenMobSprites addObject:green_6];
        [greenMobSprites addObject:green_7];
        [greenMobSprites addObject:green_8];
        [greenMobSprites addObject:green_9];
        [greenMobSprites addObject:green_10];
        [greenMobSprites addObject:green_11];
        [greenMobSprites addObject:green_12];
        [greenMobSprites addObject:green_13];
        [greenMobSprites addObject:green_14];
        [greenMobSprites addObject:green_15];
        [greenMobSprites addObject:green_16];
        
        [yellowMobSprites addObject:yellow_1];
        [yellowMobSprites addObject:yellow_2];
        [yellowMobSprites addObject:yellow_3];
        [yellowMobSprites addObject:yellow_4];
        [yellowMobSprites addObject:yellow_5];
        [yellowMobSprites addObject:yellow_6];
        [yellowMobSprites addObject:yellow_7];
        [yellowMobSprites addObject:yellow_8];
        [yellowMobSprites addObject:yellow_9];
        [yellowMobSprites addObject:yellow_10];
        [yellowMobSprites addObject:yellow_11];
        [yellowMobSprites addObject:yellow_12];
        [yellowMobSprites addObject:yellow_13];
        [yellowMobSprites addObject:yellow_14];
        [yellowMobSprites addObject:yellow_15];
        [yellowMobSprites addObject:yellow_16];
        
        [blueMobSprites addObject:blue_1];
        [blueMobSprites addObject:blue_2];
        [blueMobSprites addObject:blue_3];
        [blueMobSprites addObject:blue_4];
        [blueMobSprites addObject:blue_5];
        [blueMobSprites addObject:blue_6];
        [blueMobSprites addObject:blue_7];
        [blueMobSprites addObject:blue_8];
        [blueMobSprites addObject:blue_9];
        [blueMobSprites addObject:blue_10];
        [blueMobSprites addObject:blue_11];
        [blueMobSprites addObject:blue_12];
        [blueMobSprites addObject:blue_13];
        [blueMobSprites addObject:blue_14];
        [blueMobSprites addObject:blue_15];
        [blueMobSprites addObject:blue_16];
        
        [whiteMobSprites addObject:white_1];
        [whiteMobSprites addObject:white_2];
        [whiteMobSprites addObject:white_3];
        [whiteMobSprites addObject:white_4];
        [whiteMobSprites addObject:white_5];
        [whiteMobSprites addObject:white_6];
        [whiteMobSprites addObject:white_7];
        [whiteMobSprites addObject:white_8];
        [whiteMobSprites addObject:white_9];
        [whiteMobSprites addObject:white_10];
        [whiteMobSprites addObject:white_11];
        [whiteMobSprites addObject:white_12];
        [whiteMobSprites addObject:white_13];
        [whiteMobSprites addObject:white_14];
        [whiteMobSprites addObject:white_15];
        [whiteMobSprites addObject:white_16];
        
        [pinkMobSprites addObject:pink_1];
        [pinkMobSprites addObject:pink_2];
        [pinkMobSprites addObject:pink_3];
        [pinkMobSprites addObject:pink_4];
        [pinkMobSprites addObject:pink_5];
        [pinkMobSprites addObject:pink_6];
        [pinkMobSprites addObject:pink_7];
        [pinkMobSprites addObject:pink_8];
        [pinkMobSprites addObject:pink_9];
        [pinkMobSprites addObject:pink_10];
        [pinkMobSprites addObject:pink_11];
        [pinkMobSprites addObject:pink_12];
        [pinkMobSprites addObject:pink_13];
        [pinkMobSprites addObject:pink_14];
        [pinkMobSprites addObject:pink_15];
        [pinkMobSprites addObject:pink_16];
        
        [purpleMobSprites addObject:purple_1];
        [purpleMobSprites addObject:purple_2];
        [purpleMobSprites addObject:purple_3];
        [purpleMobSprites addObject:purple_4];
        [purpleMobSprites addObject:purple_5];
        [purpleMobSprites addObject:purple_6];
        [purpleMobSprites addObject:purple_7];
        [purpleMobSprites addObject:purple_8];
        [purpleMobSprites addObject:purple_9];
        [purpleMobSprites addObject:purple_10];
        [purpleMobSprites addObject:purple_11];
        [purpleMobSprites addObject:purple_12];
        [purpleMobSprites addObject:purple_13];
        [purpleMobSprites addObject:purple_14];
        [purpleMobSprites addObject:purple_15];
        [purpleMobSprites addObject:purple_16];
        
    }
    
}

@end
