//
//  FlightPaths.m
//  FlightPath
//
//  Created by AppleUser on 08/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
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

-(id)getSequence:(FlightPattern)flightPattern movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos 
{
    CCLOG(@"Calling with tag %d",tag);
    CCSequence* seq = nil;
    
    switch (flightPattern) 
    {
        case STRAIGHT:
            return [self straightSeq:movementModifier withTag:tag currentPos:currentPos];
            break;
            
        case FAST_IN_OUT:
            return [self fastinoutSeq:movementModifier withTag:tag currentPos:currentPos];
            
        case SLOW_IN_OUT:
            return [self slowinoutSeq:movementModifier withTag:tag currentPos:currentPos];
            
        case BEZIER_ONE:
            return [self bezierOneSeq:movementModifier withTag:tag currentPos:currentPos];
            
        case ZOOM:
            return [self zoomSeq:movementModifier withTag:tag currentPos:currentPos];
            
        default:
            return seq;
            break;
    }
    
    
}



//
//
//
-(id)straightSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos
{
    CCMoveTo* move1 = [CCMoveTo actionWithDuration:[[BlastedEngine instance] getCurrentSpeed] position:ccp(10,currentPos.y)];
    CCCallFuncO* mobFinished = [CCCallFuncO actionWithTarget:self selector:@selector(callBackMobMoveComplete:) object:(id)[NSNumber numberWithInt:tag]];
    CCSequence* seq = [CCSequence actions:move1, mobFinished, nil];
    
    return seq;

}

-(id)fastinoutSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos
{
    CCMoveTo* move1 = [CCMoveTo actionWithDuration:[[BlastedEngine instance] getCurrentSpeed] position:ccp(10,currentPos.y)];
    CCEaseIn* easeIn = [CCEaseIn actionWithAction:move1 rate:2.0f];
    CCCallFuncO* mobFinished = [CCCallFuncO actionWithTarget:self selector:@selector(callBackMobMoveComplete:) object:(id)[NSNumber numberWithInt:tag]];
    CCSequence* seq = [CCSequence actions:easeIn, mobFinished, nil];
    return seq;    
}

-(id)slowinoutSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos
{
    CCMoveTo* move1 = [CCMoveTo actionWithDuration:[[BlastedEngine instance] getCurrentSpeed] position:ccp(10,currentPos.y)];
    CCEaseOut* easeOut = [CCEaseOut actionWithAction:move1 rate:2.0f];
    CCCallFuncO* mobFinished = [CCCallFuncO actionWithTarget:self selector:@selector(callBackMobMoveComplete:) object:(id)[NSNumber numberWithInt:tag]];
    CCSequence* seq = [CCSequence actions:easeOut, mobFinished, nil];
    return seq;    
}

-(id)bezierOneSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos 
{
    ccBezierConfig bezier;
	bezier.controlPoint_1 = ccp(currentPos.x-50, currentPos.y+150);
	bezier.controlPoint_2 = ccp(120, currentPos.y-150);
	bezier.endPosition = ccp(10,currentPos.y);
	
	CCBezierTo* bezierForward = [CCBezierTo actionWithDuration:[[BlastedEngine instance] getCurrentSpeed] bezier:bezier];
    CCCallFuncO* mobFinished = [CCCallFuncO actionWithTarget:self selector:@selector(callBackMobMoveComplete:) object:(id)[NSNumber numberWithInt:tag]];
    CCSequence* seq = [CCSequence actions:bezierForward, mobFinished, nil];
    return seq;  
}

-(id)zoomSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos
{
    CCMoveTo* move1 = [CCMoveTo actionWithDuration:[[BlastedEngine instance] getCurrentSpeed] position:ccp(10,currentPos.y)];
    CCScaleTo* scale = [CCScaleTo actionWithDuration:3 scale:2.5f];
    CCScaleTo* scale2 = [CCScaleTo actionWithDuration:3 scale:1.0f];
    
    CCSequence* seq = [CCSequence actions:scale, scale2, nil];
    CCSpawn* spawn = [CCSpawn actions:seq, move1, nil];
    
    CCCallFuncO* mobFinished = [CCCallFuncO actionWithTarget:self selector:@selector(callBackMobMoveComplete:) object:(id)[NSNumber numberWithInt:tag]];
    
    CCSequence* seq2 = [CCSequence actions:spawn, mobFinished, nil];
    return seq2;    
}

-(void)callBackMobMoveComplete:(id)sender
{
    [[BlastedEngine instance] callBackMobMoveComplete:sender];
}

-(void)dealloc
{
    [flightPaths release];
    [super dealloc];
}

@end
