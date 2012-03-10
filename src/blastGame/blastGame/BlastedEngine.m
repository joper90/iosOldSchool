//
//  BlastedEngine.m
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo. All rights reserved.
//

#import "BlastedEngine.h"


@implementation BlastedEngine

@synthesize currentScore, mobsArray, level, levelList, valid, startPositionMap, currentPlayingLevel;

static BlastedEngine* blastedEngine = nil;

+(BlastedEngine*) instance
{
    if (blastedEngine == nil)
    {
        CCLOG(@"Engine instance started....");
        //Alive for the duration of the game
        blastedEngine = [[BlastedEngine alloc]init];
        CCLOG(@"Engine instance complete....");
    }
    return blastedEngine;
}

-(id)init
{
    //Called before the instance init...
    CCLOG(@"Engine init method");
    self = [super self];
    if (self != nil)
    {
        
        self.mobsArray = [[NSMutableArray alloc]init];
        self.startPositionMap = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(BOOL) isValid
{
    return valid;
}

//
// Level utils.
//

//Call to parse and load the levels, return BOOL 
-(BOOL)loadAndParseLevels
{
    [[LevelLoader instance]loadAndParseLevelFile];
    //[self loadLevel:1];
    return YES;
}

//Create the start positions
-(void)setStartPositions
{
    //Get the screen sizes.
    CGSize screenSize = [Utils instance].screenSize;
    CCLOG(@"screen size X: %f  -  Y: %f",screenSize.width, screenSize.height);
    
    float offscreenStart = screenSize.width + START_OFFSCREEN_OFFSET;
    
    float stepCount = screenSize.height / (MOB_ROW_COUNT + 1); // +1 to get the correct spacing so all on screen.
    
    float screenYpostion = stepCount; // First position
    
    for (int x = 0; x < MOB_ROW_COUNT ; x++)
    {
        NSNumber* number = [NSNumber numberWithInt:x];
        CGPoint point = ccp(offscreenStart, screenYpostion);
        NSValue* pointValue = [NSValue valueWithCGPoint:point];
        
        [startPositionMap setObject:pointValue forKey:number];
        screenYpostion = screenYpostion + stepCount;
    }
    
    CCLOG(@"setStartScreen complete..");
    
}


//Load a level from the LevelsLoader populated array
-(BOOL)loadLevel:(int)levelToLoad
{
    BOOL allValid = YES;
    
    //Hopefully arrays keep the order, and need some more rubust defensive codign in here.
    currentPlayingLevel = [levelList objectForKey:[NSNumber numberWithInt:levelToLoad]];
    
    //Add the inital row to the mob list
    for (int x = 0; x < MOB_ROW_COUNT; x++)
    {
        MobElement* mob = [[MobElement alloc]init];
        
    }
    
    
    //Fake Data at the moment.
    /*
    int posUp = 50;
    
     for (int x = 0; x < 5 ; x ++)
    {
        MobElement* mob = [[MobElement alloc]init];
        CCSprite* sprite = [CCSprite spriteWithFile:@"Icon-Small.png"];
        sprite.anchorPoint = ccp(0.5f, 0.5f);
        sprite.position = ccp(600,posUp);
        sprite.tag = x;
        
        [mob addSprite:sprite];
        
        [mobsArray addObject:mob];
        
        posUp += 50;
    }
     */
    
    
    return allValid;
}

//Sprite functionality
-(MobElement*)getMobBySpriteTag:(int)tag
{
    MobElement* mob = nil;
    for (MobElement* m in mobsArray)
    {
        if (m.spriteTag == tag)
        {
            mob = m;
            return mob;
        }
    }
    return mob;
}

-(CGPoint)getInitPosBySpriteTag:(int)tag
{
    MobElement* mob = nil;
    mob = [self getMobBySpriteTag:tag];
    if (mob != nil)
    {
        return mob.initPos;
    }
    CGPoint deadPoint;
    return deadPoint;
}

-(MobElement*)whichMobTouched:(CGPoint)touchPoint
{
    MobElement* mob = nil;
    for (MobElement* m in mobsArray)
    {
        CCSprite* mSprite = [m getSprite];
        if (CGRectContainsPoint(mSprite.boundingBox, touchPoint))
        {
            CCLOG(@"Found a mob %d", m.spriteTag);
            //Found a touched sprite.. so return the mob.
            return m;
        }
    }
    
    return mob;
}

//Level Loading and setting
-(void)addLevelToLevelList:(LevelElementData *)levelDataElement
{
    //need to retain?
    //switched to a dict now for quick level lookup when loadign a new level.
    NSNumber* levelId = [NSNumber numberWithInt:levelDataElement.levelId]; 
    [levelList setObject:levelDataElement forKey:levelId];
}

-(void)dealloc
{
    [mobsArray release];
    [startPositionMap release];
    [super dealloc];
}

@end
