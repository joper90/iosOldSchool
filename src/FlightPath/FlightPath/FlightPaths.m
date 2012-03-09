//
//  FlightPaths.m
//  FlightPath
//
//  Created by AppleUser on 08/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlightPaths.h"

@implementation FlightPaths


static FlightPaths* flightPaths = nil;


+(FlightPaths*) instance
{
    if (flightPaths == nil)
    {
        CCLOG(@"FlightPath instance started....");
        //Alive for the duration of the game
        flightPaths = [[FlightPaths alloc]init];
    }
    return flightPaths;
}

-(CCSequence*)getSequence:(CallBackComplete *)callbackFunction selectedPattern:(FlightPattern)flightPattern movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos
{
    CCLOG(@"Calling with tag %d",tag);
    CCSequence* seq = nil;
    
    switch (flightPattern) 
    {
        case STRAIGHT:
            return [self straightSeq:callbackFunction movementModifer:movementModifier withTag:tag currentPos:currentPos];
            break;
            
        default:
            return seq;
            break;
    }
    
    
}



//
//
//
-(CCSequence*)straightSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos
{
    CCMoveTo* move1 = [CCMoveTo actionWithDuration:2 position:ccp(10,currentPos.y)];
    CCCallFuncO* mobFinished = [CCCallFuncO actionWithTarget:callbackFunction selector:@selector(callme:) object:(id)[NSNumber numberWithInt:tag]];
    CCSequence* seq = [CCSequence actions:move1, mobFinished, nil];
    
    return seq;

}

-(CCSequence*)fastinoutSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos
{
    CCSequence* seq = nil;
    return seq;    
}

-(CCSequence*)slowinoutSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos
{
    CCSequence* seq = nil;
    return seq;
}
@end
