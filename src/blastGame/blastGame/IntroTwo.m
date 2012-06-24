//
//  IntroTwo.m
//  blastGame
//
//  Created by Joe Humphries on 24/06/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "IntroTwo.h"


@implementation IntroTwo

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
	
	IntroTwoLayer* introTwo = [IntroTwoLayer node];
    [scene addChild:introTwo];
	return scene;
} 

@end
