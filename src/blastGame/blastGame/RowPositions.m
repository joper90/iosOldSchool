//
//  RowPositions.m
//  blastGame
//
//  Created by AppleUser on 26/04/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "RowPositions.h"


@implementation RowPositions
@synthesize startPositionMap1, startPositionMap2, startPositionMap3, startPositionMap4, startPositionMap5, startPositionMap6, startPositionMap7, startPositionMap8;

-(id) init
{
    CCLOG(@"Setting up all rowpositions");
	if (self=[super init])
    {
        startPositionMap1 = [[NSMutableDictionary alloc]init];
        startPositionMap2 = [[NSMutableDictionary alloc]init];
        startPositionMap3 = [[NSMutableDictionary alloc]init];
        startPositionMap4 = [[NSMutableDictionary alloc]init];
        startPositionMap5 = [[NSMutableDictionary alloc]init];
        startPositionMap6 = [[NSMutableDictionary alloc]init];
        startPositionMap7 = [[NSMutableDictionary alloc]init];
        startPositionMap8 = [[NSMutableDictionary alloc]init];
        screenSize = [Utils instance].screenSize;
        CCLOG(@"screen size X: %f  -  Y: %f",screenSize.width, screenSize.height);
        offscreenStart = screenSize.width + START_OFFSCREEN_OFFSET;
        
        [self createAllData];
	}
	return self;
}

-(void)createAllData
{    
    [self injectElements:startPositionMap1 withRows:1];
    [self injectElements:startPositionMap2 withRows:2];
    [self injectElements:startPositionMap3 withRows:3];
    [self injectElements:startPositionMap4 withRows:4];
    [self injectElements:startPositionMap5 withRows:5];
    [self injectElements:startPositionMap6 withRows:6];
    [self injectElements:startPositionMap7 withRows:7];
    [self injectElements:startPositionMap8 withRows:8];
    CCLOG(@"setStartScreen complete.. all maps are done.");
}

-(void)injectElements:(NSMutableDictionary*) elementToInject withRows:(int)rowCount
{ 
    float stepCount = screenSize.height / (rowCount + 1); // +1 to get the correct spacing so all on screen.
    
    float screenYpostion = stepCount; // First position
    
    for (int x = 0; x < rowCount ; x++)
    {
        NSNumber* number = [NSNumber numberWithInt:x];
        CGPoint point = ccp(offscreenStart, screenYpostion);
        NSValue* pointValue = [NSValue valueWithCGPoint:point];
        
        [elementToInject setObject:pointValue forKey:number];
        screenYpostion = screenYpostion + stepCount;
    }  
}

-(CGPoint) getRowPositionByRowCount:(int) rowCount andPositionRequired:(int) position
{
   
    switch (rowCount) {
        case 1:
            return [[startPositionMap1 objectForKey:[NSNumber numberWithInt:position]]CGPointValue];
        case 2:
            return [[startPositionMap2 objectForKey:[NSNumber numberWithInt:position]]CGPointValue];
        case 3:
            return [[startPositionMap3 objectForKey:[NSNumber numberWithInt:position]]CGPointValue];
        case 4:
            return [[startPositionMap4 objectForKey:[NSNumber numberWithInt:position]]CGPointValue];
        case 5:
            return [[startPositionMap5 objectForKey:[NSNumber numberWithInt:position]]CGPointValue];
        case 6:
            return [[startPositionMap6 objectForKey:[NSNumber numberWithInt:position]]CGPointValue];
        case 7:
            return [[startPositionMap7 objectForKey:[NSNumber numberWithInt:position]]CGPointValue];
        case 8:
            return [[startPositionMap8 objectForKey:[NSNumber numberWithInt:position]]CGPointValue];

            
       
    }
    return ccp(0,0);
}

-(void)dealloc
{
    [startPositionMap1 release];
    [startPositionMap2 release];
    [startPositionMap3 release];
    [startPositionMap4 release];
    [startPositionMap5 release];
    [startPositionMap6 release];
    [super dealloc];
}
@end
