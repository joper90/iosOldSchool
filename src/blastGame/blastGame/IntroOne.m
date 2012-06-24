
//
//  IntroOne.m
//  blastGame
//
//  Created by Joe Humphries on 24/06/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "IntroOne.h"


@implementation IntroOne

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
	
	IntroOneLayer* introOne = [IntroOneLayer node];
    [scene addChild:introOne];
	return scene;
} 

@end
