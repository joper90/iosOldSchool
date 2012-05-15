//
//  BlastedEngine.h
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreImports.h"
#import "MobElement.h"
#import "LevelElementData.h"
#import "LevelJsonParser.h"
#import "FlightPaths.h"
#import "Properties.h"
#import "PropertiesJsonParser.h"
#import "PersistElements.h"
#import "RowPositions.h"
#import "AudioElementData.h"
@class MainLayer;
@class MainFGLayer;

@interface BlastedEngine : NSObject
{    
    
    bool isHdMode;
    
    //CCLayer CallBack information
    MainLayer* injectedGamePlayLayer;
    //SCore layer
    MainFGLayer* injectedScoreLayer;
    
    //All Engine data here
    int currentScore;
    int currentMultiplier;
    float currentMultiplierCountDownSpeed;
    float levelPercentComplete;
    int level;
    int currentMobDisplayedCount;
    
    LevelElementData* currentPlayingLevel;
    
    //HiScore Element;
    PersistElements* persistHiScoreElement;
    
    //Dict of the sprites themselves to load up.
    //The actual sprites we copy into the mobsArray.
    NSMutableDictionary* actualMobSprites;
    
    //Object containing all the row positions.
    RowPositions* rowPositionData;
    
    //Array the mobs, the actual mobs on the screen, that move !.
    //This will get completely populated on levelLoad.. 
    NSMutableArray* mobsArray;
    
    CCSprite* planetAndGun;
       
    //Array of the levels, from the lever loader.. the actual level data.
     NSMutableDictionary*  levelList; 
    
    //Array of the hiScores:
    NSMutableArray* hiScores;
    
}

@property (retain, readwrite) NSMutableDictionary* iosDeviceProperties;
@property (retain, readwrite) NSMutableDictionary* actualMobSprites;
@property (assign, readwrite) LevelElementData* currentPlayingLevel;
@property (assign, readwrite) RowPositions* rowPositionData;
@property (assign, readwrite) float levelPercentComplete; 
@property (assign, readwrite) int currentScore;
@property (assign, readwrite) int currentMultiplier;
@property (assign, readwrite) int currentMobDisplayedCount;
@property (assign, readwrite) int level;
@property (assign, readwrite) bool isHdMode;
@property (retain, readwrite) NSMutableArray* mobsArray;
@property (retain, readwrite) NSMutableDictionary*  levelList;
@property (assign, readwrite) float currentMultiplierCountDownSpeed;
@property (assign, readwrite) NSMutableArray* hiScores;



//singleton of the engine
+(BlastedEngine*) instance;

//GamePlayLayer Stuff
-(void)injectGamePlayLayer:(MainLayer*)gamePlayLayer;
-(void)releaseGamePlayLayer;
-(void)injectScoreLayer:(MainFGLayer*)scorePlayLayer;
-(void)releaseScoreLayer;
-(void)callBackMobMoveComplete:(id)sender;
-(void)increaseLevelCount;
-(void)resetLevelCount;

//level stuff and information
-(BOOL)loadLevel:(int) levelToLoad withLayer:(CCLayer*) layer;
-(int)getWaveCountByCurrentLevel;
-(float)getCurrentTimeBetweenWaves;
-(float)getCurrentSpeed;
-(int)getBackGroundParticle;
-(NSString*)getBackGroundMusic;
-(NSString*)getCurrentLevelName;
-(void)increaseMobDisplayCount:(int)incAmount;

-(NSMutableArray*) getMobListArray;
-(void)setDeadMob:(int)mobTag;
-(BOOL)isLevelCompleted;

//Score Stuff
-(void)resetScore;
-(void)incMultiplier;
-(void)decMultiplier;
-(void)resetMultiplier;
-(int)getMultipiler;
-(void)addToScore:(int) addAmount;
-(int)getCurrentScore;
-(void)pokeScoreLayer;
-(void)pokeMultiplier;
-(void)pokePercentageComplete:(float)newPercentage;

//HiScore stuff
-(BOOL)submitHiScore:(int)currentScore; //sumbit a hiScore, adds if needed, sorts and sync's (saves), returns true is a new hiscore.
-(NSMutableArray*)getHiScoreArray;

-(NSArray*)getMobsForRenderRangeFrom:(int) startRange to:(int)endRange;
-(int)getRowCountSizeByRowNumber:(int)rowNumber;
-(MobElement*)getMobBySpriteTag:(int) tag;
-(void)addLevelToLevelList:(LevelElementData*) levelDataElement;
-(id) getPatternFromInt:(int) patternNumber movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos withLayer:(CCLayer*) layer;
-(CGPoint) getStartPositionByRowCount:(int) rowCount andPosition:(int)position;

-(BOOL)loadAndParseLevels;
-(void)setStartPositions;
-(void)loadSprites;
-(NSString*) convertNumberToSpriteType:(int) spriteNumber;
-(MOB_COLOUR) insertMobEnumFromSpriteNumber:(int) spriteNumber;



//Intersection testing
-(MobElement*)whichMobTouched:(CGPoint) touchPoint;
-(CGPoint)getInitPosBySpriteTag:(int) tag;
@end
