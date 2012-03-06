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
    int level;
    NSString* levelType;
    LEVEL_TYPE levelTypeEnum;
    
    int rowCount;
    CCArray* rowData;
    CCArray* patternData;
}

@property int level;
@property (readwrite, retain) NSString* levelType;
@property LEVEL_TYPE levelTypeEnum;
@property int rowCount;
@property (readwrite, retain) CCArray* rowData;
@property (readwrite, retain) CCArray* patternData;

-(id)initWithRowPatternCCArrays:(CCArray*) allRows andAllPattern:(CCArray*) allPatterns;
-(void)addAllRowsPatterns:(CCArray*) allRows andAllPatterns:(CCArray*) allPatterns;



@end
