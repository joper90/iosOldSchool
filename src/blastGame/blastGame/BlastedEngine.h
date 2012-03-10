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
#import "LevelLoader.h"

@interface BlastedEngine : NSObject
{
    //is Everything all ok
    BOOL valid;
    
    
    //All Engine data here
    int currentScore;
    
    int level;
    
    LevelElementData* currentPlayingLevel;
    
    //Array the mobs, the actual mobs
    NSMutableArray* mobsArray;
    
    //Map of init start positions, based on screen sizes. // start with 5 rows.
    NSMutableDictionary* startPositionMap;
    
    //Array of the levels, from the lever loader.. the actual level data.
     NSMutableDictionary*  levelList; 
    
}

@property (assign, readwrite) LevelElementData* currentPlayingLevel;
@property (retain, readwrite) NSMutableDictionary* startPositionMap;
@property (assign, readwrite) BOOL valid;
@property (assign, readwrite) int currentScore;
@property (assign, readwrite) int level;
@property (retain, readwrite) NSMutableArray* mobsArray;
@property (retain, readwrite) NSMutableDictionary*  levelList;



//singleton of the engine
+(BlastedEngine*) instance;

-(BOOL)isValid;
-(BOOL)loadLevel:(int) levelToLoad;
-(MobElement*)getMobBySpriteTag:(int) tag;
-(void)addLevelToLevelList:(LevelElementData*) levelDataElement;

-(BOOL)loadAndParseLevels;
-(void)setStartPositions;

//Intersection testing
-(MobElement*)whichMobTouched:(CGPoint) touchPoint;
//TO REMOVE
-(CGPoint)getInitPosBySpriteTag:(int) tag;
@end
