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
    NSArray* levels = [dict objectForKey:@"levels"];
    for (id level in levels)
    {
        int levelId = [[level objectForKey:@"levelId"]intValue];
        CCLOG(@"Level ID : %@", levelId);
        
        NSString* levelInfo = [level objectForKey:@"levelInfo"];
        CCLOG(@"Levelinfo : %@", levelInfo);
        
        NSArray* rowData = [level objectForKey:@"rowData"];
        CCLOG(@"Row Count : %d", [rowData count]);
        
        
        
        
    }
}

@end
