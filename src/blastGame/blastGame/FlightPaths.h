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
SLOW_IN_OUT,
BEZIER_ONE,
ZOOM
    
} FlightPattern;

@interface FlightPaths : NSObject
{
    
}

+(FlightPaths*) instance;

-(CCSequence*) getSequence:(CallBackComplete*) callbackFunction selectedPattern:(FlightPattern)flightPattern movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;

//List of sequeneces.

-(id) straightSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;
-(id) fastinoutSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;
-(id) slowinoutSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;
-(id) bezierOneSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;  
-(id) zoomSeq:(CallBackComplete*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;

@end
