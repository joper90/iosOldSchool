//
//  Utils.m
//  blastGame
//
//  Created by AppleUser on 28/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"

@implementation Utils
@synthesize screenWidth,screenHeight,screenSize,isHDmode;

//Singleton
static Utils* utils = nil;

+(Utils*) instance
{
    if (utils == nil)
    {
        utils = [[Utils alloc]init];
    }
    return utils;
}

-(id)init {
    
    self = [super init];
    if (self) {
        screenSize = [[CCDirector sharedDirector] winSize];
        screenWidth = screenSize.width;
        screenHeight = screenSize.height;  
        
        isHDmode = NO;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            isHDmode = YES;
        }
        
     /*   UIDevice *myDevice = [UIDevice currentDevice];
        [myDevice beginGeneratingDeviceOrientationNotifications];
        UIDeviceOrientation or = myDevice.orientation;
        isLandscapeMode = UIDeviceOrientationIsLandscape(or);
        [myDevice endGeneratingDeviceOrientationNotifications];
       */
    }
    return self;
}

-(float)workOutBarFactorFromLenght:(float) lenght byTime:(float)time usingPollTime:(float)pollTime
{
    
    float numberOfPolls = time / pollTime; //This gives the number of polls to do the complete time based on the polltime
    float ret = lenght / numberOfPolls; // number of pixels to remove each poll time to get to zero in the time needed
    
    return ret;
}

-(CGPoint) locationFromTouchSinglePoint:(UITouch *)touch
{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

-(CGPoint) locationFromTouchMultiPoint:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

-(CGPoint) centerForTitle
{
    return ccp(screenWidth/2, screenHeight/2);
}

-(CGPoint) center
{
    CGPoint cpPoint = ccp(screenHeight/2, screenWidth/2);
    
    CCLOG(@"----> CENTERPOINT XPOS %f , YPOS %f", cpPoint.x, cpPoint.y);
    return cpPoint;
}

-(float)distanceBetweenPoints:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CGFloat dx = endPoint.x - startPoint.x;
    CGFloat dy = endPoint.y - startPoint.y;
    return sqrt(dx*dx + dy*dy);
}

-(NSString*) getActualPath:(NSString *)path
{
    NSArray* bits = [path componentsSeparatedByString:@"."];
    NSString* actualPath = [[NSBundle mainBundle]pathForResource:[bits objectAtIndex:0] ofType:[bits objectAtIndex:1]];
    return actualPath;
}

-(CGPoint) convertToiPadPointX:(float)iPhonePoint_X andY:(float)iPhonePoint_Y
{
    if (isHDmode)
        return ccp(iPhonePoint_X/480*1024,iPhonePoint_Y/320*768);
    else
        return ccp(iPhonePoint_X,iPhonePoint_Y);
}

-(float) convertXtoiPad:(float)pointX
{
    if (isHDmode)
        return pointX/480*1024;
    else
        return pointX;
}

-(float) convertYtoiPad:(float)pointY
{
    if (isHDmode)
        return pointY/320*768;
    else
        return pointY;
}

-(CGRect) convertToIPadMakeRect:(float)x y1:(float)y width:(float)width height:(float)height
{
    if (isHDmode)
    {
        return CGRectMake(x/480*1024,y/320*768, width/480*1024, height/320*768);
    }
    else
    {
        return CGRectMake(x, y, width, height);
    }
}

-(bool)isHD
{
    return isHDmode;
}

-(CGPoint) covertStringOfCGPointToCGPoint:(NSString*) stringOfPoints
{
    int xLoc = 	[stringOfPoints rangeOfString:@"x"].location;
    int xPos = [[stringOfPoints substringToIndex:xLoc]intValue];
    int yPos = [[stringOfPoints substringFromIndex:xLoc + 1]intValue];
    
    CCLOG(@" x = %d and y = %d", xPos, yPos);		
      
    return ccp(xPos,yPos);
}


@end
