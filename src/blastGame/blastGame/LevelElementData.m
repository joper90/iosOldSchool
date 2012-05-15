//
//  LevelElementData.m
//  blastGame
//
//  Created by AppleUser on 05/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "LevelElementData.h"

@implementation LevelElementData
@synthesize levelId,levelType,baseSpeed,lineTime,rowData,waveCount,patternData, mobAliveStatus,bgParticle,music,levelName, rowSizeCountArray,dropDelay,pumpSpace;


//Should callinitWithCCArraySize.
-(id) init
{
	if (self=[super init])
    {
        rowData = [[NSMutableArray alloc]init];
        patternData = [[NSMutableArray alloc]init];
        rowSizeCountArray = [[NSMutableArray alloc]init];
	}
	return self;
}

-(id)initWithRowPatternCCArrays:(NSMutableArray *)allRows andAllPattern:(NSMutableArray*)allPatterns andRowSizeData:(NSMutableArray*)rowSizeData
{

    
    if (self=[super init])
    {
        rowData = [allRows copy];
        patternData = [allPatterns copy]; 
        rowSizeCountArray = [rowSizeData copy];
    }
    return self;
    
}

-(void)addAllRowsPatterns:(NSMutableArray *)allRows andAllPatterns:(NSMutableArray *)allPatterns
{
    rowData = [allRows copy];
    [rowData retain];
    patternData = [allPatterns copy]; 
    [patternData retain];
}

-(void)dumpLevelData
{
    CCLOG(@"Level id       :%d",levelId);
    CCLOG(@"Level Info     :%@",levelType);
    CCLOG(@"Base Speed     :%f",baseSpeed);
    CCLOG(@"Wave Count      :%d",[rowData count]);
    CCLOG(@"Patten Count   :%d",[patternData count]);
    for (NSString* row in rowData)
    {
        CCLOG(@"row        :%@",row);
    }
    for (NSString* pat in patternData)
    {
        CCLOG(@"pattern    :%@",pat);
    }
    
}

-(NSMutableArray*) getCurrentMobAliveStatus
{
    return mobAliveStatus;
}

-(void)setDeadMob:(int)mobPos
{
    [mobAliveStatus replaceObjectAtIndex:mobPos withObject:[NSNumber numberWithBool:YES]];
    CCLOG(@"Set mob to dead : %d / %d", mobPos, [mobAliveStatus count]);
}

-(void)resetMobAliveStatus:(int)mobCount
{
    mobAliveStatus = [[NSMutableArray alloc]initWithCapacity:mobCount ];
    for (int x = 0; x < mobCount; x++)
    {
        [mobAliveStatus addObject:[NSNumber numberWithBool:NO]];
    }
    CCLOG(@"Cleaned MobAliveStatus :%d", mobCount);
}

-(BOOL)isAllMobsDead
{
    int count = [mobAliveStatus count];
    for (int x = 0; x < count; x++) 
    {
        BOOL b = [[mobAliveStatus objectAtIndex:x] boolValue];
        if (b == NO)
        {
            return NO;
        }
    }
    return YES;
}

-(void)dealloc
{
    [rowData release];
    [rowData dealloc];
    rowData = nil;
    
    [patternData release];
    [patternData dealloc];
    
    [rowSizeCountArray release];
    [rowSizeCountArray dealloc];
    patternData = nil;
    [super dealloc];
}

@end
