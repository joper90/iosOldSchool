
//
//  IntroFour.m
//  blastGame
//
//  Created by Joe Humphries on 24/06/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "IntroFour.h"


@implementation IntroFour
+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
	
	IntroFourLayer* introFour = [IntroFourLayer node];
    [scene addChild:introFour];
	return scene;
} 
@end
