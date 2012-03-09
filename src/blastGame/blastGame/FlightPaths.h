//
//  FlightPaths.h
//  FlightPath
//
//  Created by AppleUser on 08/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "cocos2d.h"


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

-(id) getSequence:(FlightPattern)flightPattern movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;

//List of sequeneces.

-(id) straightSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;
-(id) fastinoutSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;
-(id) slowinoutSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;
-(id) bezierOneSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;  
-(id) zoomSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos;

-(void) mobMoveCompleted:(id)sender;

@end
