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
    float  baseSpeed;
    float  lineTime;
    int rowCount;
    CCArray* rowData;
    CCArray* patternData;
}

@property int levelId;
@property (readwrite, retain) NSString* levelType;
@property (readwrite, assign) float baseSpeed;
@property (readwrite, assign) float lineTime;
@property int rowCount;
@property (readwrite, retain) CCArray* rowData;
@property (readwrite, retain) CCArray* patternData;

-(id)initWithRowPatternCCArrays:(CCArray*) allRows andAllPattern:(CCArray*) allPatterns;
-(void)addAllRowsPatterns:(CCArray*) allRows andAllPatterns:(CCArray*) allPatterns;
-(void)dumpLevelData;


@end
