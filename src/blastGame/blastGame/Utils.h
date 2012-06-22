//
//  Utils.h
//  blastGame
//
//  Created by AppleUser on 28/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface Utils : NSObject
{
    CGSize screenSize;
    float screenWidth;
    float screenHeight;
    bool  isHDmode;
}

@property float screenWidth;
@property float screenHeight;
@property bool isHDmode;
@property (readonly) CGSize screenSize;

+(Utils*) instance;
-(CGPoint) locationFromTouchSinglePoint:(UITouch *)touch;
-(CGPoint) locationFromTouchMultiPoint:(NSSet*)touches;
-(CGPoint) center;
-(float) distanceBetweenPoints:(CGPoint) startPoint endPoint:(CGPoint) endPoint;
-(NSString*)getActualPath:(NSString*) path;

-(float)workOutBarFactorFromLenght:(float) lenght byTime:(float)time usingPollTime:(float)pollTime;

-(CGPoint) convertToiPadPoint:(float)iPhonePoint_X:(float)iPhonePoint_Y;

-(CGRect) convertToIPadMakeRect:(float)x y1:(float)y width:(float)width height:(float)height;

-(bool) isHD;

@end
