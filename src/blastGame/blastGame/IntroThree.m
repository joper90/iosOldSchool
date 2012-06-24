
//
//  IntroThree.m
//  blastGame
//
//  Created by Joe Humphries on 24/06/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "IntroThree.h"


@implementation IntroThree
+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
	
	IntroThreeLayer* introThree = [IntroThreeLayer node];
    [scene addChild:introThree];
	return scene;
} 
@end
