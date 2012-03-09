//
//  FlightPaths.h
//  FlightPath
//
//  Created by AppleUser on 08/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "CallBackComplete.h"


typedef enum{
STRAIGHT = 0,
FAST_IN_OUT,
SLOW_IN_OUT
    
} FlightPattern;

@interface FlightPaths : NSObject
{
    
}

+(FlightPaths*) instance;

-(CCSequence*) getSequence:(CallBackComplete*) callbackFunction selectedPattern:(FlightPattern)flightPattern movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;

//List of sequeneces.

-(CCSequence*) straightSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;
-(CCSequence*) fastinoutSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;
-(CCSequence*) slowinoutSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;
  

@end
