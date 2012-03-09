//
//  LevelLoader.m
//  blastGame
//
//  Created by AppleUser on 05/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "LevelLoader.h"

@implementation LevelLoader


//Singleton
static LevelLoader* levelloader = nil;

+(LevelLoader*) instance
{
    if (levelloader == nil)
    {
        levelloader = [[LevelLoader alloc]init];
    }
    return levelloader;
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
        
        NSArray* rowData = [level objectForKey:@"rowData"];
        CCLOG(@"Row Count : %d", [rowData count]);
                
        CCArray* row = [[CCArray alloc]init];
        CCArray* pattern = [[CCArray alloc]init];
        
        for (id singleRow in rowData)
        {
            NSString* rowLine =  [singleRow objectForKey:@"row"];
            NSString* patternLine = [singleRow objectForKey:@"pattern"];
            
           [row addObject:rowLine];
           [pattern addObject:patternLine];
            
           CCLOG(@"row: %@   -   pattern:%@", rowLine, patternLine); 
        }
        
        LevelElementData* elementData = [[LevelElementData alloc]initWithRowPatternCCArrays:row andAllPattern:pattern ];
        
        elementData.levelId = levelId;
        elementData.levelType = levelInfo;
        elementData.baseSpeed = [baseSpeed floatValue];
        elementData.lineTime = [lineTime floatValue];
        
        
        [[BlastedEngine instance]addLevelToLevelList:elementData];
        
    }
}

@end
