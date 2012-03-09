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
}

@property float screenWidth;
@property float screenHeight;
@property (readonly) CGSize screenSize;

+(Utils*) instance;
-(CGPoint) locationFromTouchSinglePoint:(UITouch *)touch;
-(CGPoint) locationFromTouchMultiPoint:(NSSet*)touches;
-(CGPoint) center;
-(float) distanceBetweenPoints:(CGPoint) startPoint endPoint:(CGPoint) endPoint;
-(NSString*)getActualPath:(NSString*) path;

@end
