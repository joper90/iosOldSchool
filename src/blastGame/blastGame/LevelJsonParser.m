//
//  LevelJsonParser.m
//  blastGame
//
//  Created by AppleUser on 05/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "LevelJsonParser.h"

@implementation LevelJsonParser


//Singleton
static LevelJsonParser* levelJsonParser = nil;

+(LevelJsonParser*) instance
{
    if (levelJsonParser == nil)
    {
        levelJsonParser = [[LevelJsonParser alloc]init];
    }
    return levelJsonParser;
}

-(id)init
{
    if (self = [super init])
    {
        jsonFile = @"jsonTest.json";
        CCLOG(@"Using JSON FILE %@", jsonFile);
    }
    return self;
}

-(BOOL)loadAndParseLevelFile
{
    
    NSString* actualPath = [[Utils instance]getActualPath:jsonFile];
    
    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:actualPath encoding:NSUTF8StringEncoding error:nil];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    NSDictionary* dict = [[CJSONDeserializer deserializer]deserializeAsDictionary:jsonData error:nil];
    CCLOG(@"JSON : %@", jsonString);	
    
    [self processMap:dict];
    
    return YES;
}

-(void)processMap:(NSDictionary *)dict
{
    // This needs to be error checked.. 
    // and a validate process needs to be written before publish
    
    NSArray* levels = [dict objectForKey:@"levels"];
    for (id level in levels)
    {
        int levelId = [[level objectForKey:@"levelId"]intValue];
        CCLOG(@"Level ID : %d", levelId);
        
        NSString* levelInfo = [level objectForKey:@"levelInfo"];
        CCLOG(@"Levelinfo : %@", levelInfo);
        
        NSString* baseSpeed = [level objectForKey:@"baseSpeed"];
        CCLOG(@"baseSpeed : %@", baseSpeed);
        
        NSString* lineTime = [level objectForKey:@"lineTime"];
        CCLOG(@"Line Time : %@", lineTime);
        
        NSString* bgPattern = [level objectForKey:@"bg"];
        CCLOG(@"bg Type : %@", bgPattern);
        
        NSArray* rowData = [level objectForKey:@"rowData"];
        CCLOG(@"Wave Count : %d", [rowData count]);
                        
        NSMutableArray* row = [[NSMutableArray alloc]init];
        NSMutableArray* pattern = [[NSMutableArray alloc]init];
        
        for (id singleRow in rowData)
        {
            NSString* rowLine =  [singleRow objectForKey:@"row"];
            NSString* patternLine = [singleRow objectForKey:@"pattern"];
           
           [row addObject:rowLine];
           [pattern addObject:patternLine];
                    
           CCLOG(@"ADDED to elementData : row: %@   -   pattern:%@", rowLine, patternLine); 
        }
                
        LevelElementData* elementData = [[LevelElementData alloc]initWithRowPatternCCArrays:row andAllPattern:pattern ];
        
        elementData.levelId = levelId;
        elementData.levelType = levelInfo;
        elementData.baseSpeed = [baseSpeed floatValue];
        elementData.lineTime = [lineTime floatValue];
        elementData.bgParticle = [bgPattern intValue];
        elementData.waveCount = [rowData count];
        
        [[BlastedEngine instance]addLevelToLevelList:elementData];
    }
}

@end