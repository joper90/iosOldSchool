//
//  LevelElementData.h
//  blastGame
//
//  Created by AppleUser on 05/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreImports.h"

@interface LevelElementData : NSObject
{
    int levelId;                //Level id, i.e the number
    NSString* levelType;        //LevelType - normal, or boss (the name of) to look up in a table.. THis should be an enum really.
    float   baseSpeed;           //Speed at which the mobs move across the screen
    float   lineTime;            //Speed between each line (wave) appearing.
    int     waveCount;
    int     totalMobsOnLevel;   //The total Alive mobs (i.e mobs with tags);
    NSMutableArray* mobAliveStatus; //Current status of the mobs.
    NSMutableArray* rowData;
    NSMutableArray* patternData;
}

@property int levelId;
@property (readwrite, retain) NSString* levelType;
@property (readwrite, assign) float baseSpeed;
@property (readwrite, assign) float lineTime;
@property int waveCount;
@property (readwrite, retain) NSMutableArray* rowData;
@property (readwrite, retain) NSMutableArray* patternData;
@property (readwrite, retain) NSMutableArray* mobAliveStatus;

-(id)initWithRowPatternCCArrays:(NSMutableArray*) allRows andAllPattern:(NSMutableArray*) allPatterns;
-(void)addAllRowsPatterns:(NSMutableArray*) allRows andAllPatterns:(NSMutableArray*) allPatterns;
-(void)dumpLevelData;
-(void)resetMobAliveStatus:(int)mobCount;
-(void)setDeadMob:(int)mobPos;
-(BOOL)isAllMobsDead;


@end
