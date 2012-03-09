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
            
        case FAST_IN_OUT:
            return [self fastinoutSeq:callbackFunction movementModifer:movementModifier withTag:tag currentPos:currentPos];
            
        case SLOW_IN_OUT:
            return [self slowinoutSeq:callbackFunction movementModifer:movementModifier withTag:tag currentPos:currentPos];
            
        case BEZIER_ONE:
            return [self bezierOneSeq:callbackFunction movementModifer:movementModifier withTag:tag currentPos:currentPos];
            
        case ZOOM:
            return [self zoomSeq:callbackFunction movementModifer:movementModifier withTag:tag currentPos:currentPos];
            
        default:
            return seq;
            break;
    }
    
    
}



//
//
//
-(id)straightSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos
{
    CCMoveTo* move1 = [CCMoveTo actionWithDuration:2 position:ccp(10,currentPos.y)];
    CCCallFuncO* mobFinished = [CCCallFuncO actionWithTarget:callbackFunction selector:@selector(callme:) object:(id)[NSNumber numberWithInt:tag]];
    CCSequence* seq = [CCSequence actions:move1, mobFinished, nil];
    
    return seq;

}

-(id)fastinoutSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos
{
    CCMoveTo* move1 = [CCMoveTo actionWithDuration:2 position:ccp(10,currentPos.y)];
    CCEaseIn* easeIn = [CCEaseIn actionWithAction:move1 rate:2.0f];
    CCCallFuncO* mobFinished = [CCCallFuncO actionWithTarget:callbackFunction selector:@selector(callme:) object:(id)[NSNumber numberWithInt:tag]];
    CCSequence* seq = [CCSequence actions:easeIn, mobFinished, nil];
    return seq;    
}

-(id)slowinoutSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos
{
    CCMoveTo* move1 = [CCMoveTo actionWithDuration:2 position:ccp(10,currentPos.y)];
    CCEaseOut* easeOut = [CCEaseOut actionWithAction:move1 rate:2.0f];
    CCCallFuncO* mobFinished = [CCCallFuncO actionWithTarget:callbackFunction selector:@selector(callme:) object:(id)[NSNumber numberWithInt:tag]];
    CCSequence* seq = [CCSequence actions:easeOut, mobFinished, nil];
    return seq;    
}

-(id)bezierOneSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos; 
{
    ccBezierConfig bezier;
	bezier.controlPoint_1 = ccp(currentPos.x-50, currentPos.y+150);
	bezier.controlPoint_2 = ccp(120, currentPos.y-150);
	bezier.endPosition = ccp(10,currentPos.y);
	
	CCBezierTo* bezierForward = [CCBezierTo actionWithDuration:3 bezier:bezier];
    CCCallFuncO* mobFinished = [CCCallFuncO actionWithTarget:callbackFunction selector:@selector(callme:) object:(id)[NSNumber numberWithInt:tag]];
    CCSequence* seq = [CCSequence actions:bezierForward, mobFinished, nil];
    return seq;  
}

-(id)zoomSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;
{
    CCMoveTo* move1 = [CCMoveTo actionWithDuration:2 position:ccp(10,currentPos.y)];
    CCScaleTo* scale = [CCScaleTo actionWithDuration:1 scale:2.5f];
    CCScaleTo* scale2 = [CCScaleTo actionWithDuration:1 scale:1.0f];
    
    CCSequence* seq = [CCSequence actions:scale, scale2, nil];
    CCSpawn* spawn = [CCSpawn actions:seq, move1, nil];
    
    CCCallFuncO* mobFinished = [CCCallFuncO actionWithTarget:callbackFunction selector:@selector(callme:) object:(id)[NSNumber numberWithInt:tag]];
    
    CCSequence* seq2 = [CCSequence actions:spawn, mobFinished, nil];
    return seq2;    
}
@end
