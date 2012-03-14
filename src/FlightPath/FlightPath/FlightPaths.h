//
//  FlightPaths.h
//  FlightPath
//
//  Created by AppleUser on 08/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "CallBackComplete.h"
#import "HelloWorldLayer.h"


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

-(CCSequence*) getSequence:(CCLayer*) callbackFunction selectedPattern:(FlightPattern)flightPattern movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;

//List of sequeneces.

-(id) straightSeq:(CCLayer*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;
-(id) fastinoutSeq:(CCLayer*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;
-(id) slowinoutSeq:(CCLayer*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;
-(id) bezierOneSeq:(CCLayer*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;  
-(id) zoomSeq:(CCLayer*) callbackFunction movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;

@end
