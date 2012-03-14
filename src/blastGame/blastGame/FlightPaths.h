//
//  FlightPaths.h
//  FlightPath
//
//  Created by AppleUser on 08/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "cocos2d.h"
#import "MainScene.h"

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

-(id) getSequence:(FlightPattern)flightPattern movementModifer:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos withLayer:(CCLayer*) layer;

//List of sequeneces.

-(id) straightSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos withLayer:(CCLayer*) layer;
-(id) fastinoutSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos withLayer:(CCLayer*) layer;
-(id) slowinoutSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos withLayer:(CCLayer*) layer;
-(id) bezierOneSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos withLayer:(CCLayer*) layer;  
-(id) zoomSeq:(float)movementModifier withTag:(int)tag currentPos:(CGPoint)currentPos withLayer:(CCLayer*) layer;

@end
