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

@interface BlastedEngine : NSObject
{
    //is Everything all ok
    BOOL valid;
    
    
    //All Engine data here
    int currentScore;
    
    int level;
    
    //Array the mobs
    NSMutableArray* mobsArray;
}

@property (assign, readwrite) int currentScore;
@property (assign, readwrite) int level;
@property (assign, readwrite) NSMutableArray* mobsArray;



//singleton of the engine
+(BlastedEngine*) instance;
-(BOOL)isValid;
-(BOOL)loadLevel:(int) levelToLoad;
-(MobElement*)getMobBySpriteTag:(int) tag;

//Intersection testing
-(MobElement*)whichMobTouched:(CGPoint) touchPoint;
//TO REMOVE
-(CGPoint)getInitPosBySpriteTag:(int) tag;
@end
