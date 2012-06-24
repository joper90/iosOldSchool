
//
//  IntroFive.m
//  blastGame
//
//  Created by Joe Humphries on 24/06/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "IntroFive.h"


@implementation IntroFive
+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
	
	IntroFiveLayer* introFive = [IntroFiveLayer node];
    [scene addChild:introFive];
	return scene;
} 
@end
