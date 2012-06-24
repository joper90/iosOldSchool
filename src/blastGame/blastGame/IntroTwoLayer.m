//
//  IntroTwoLayer.m
//  blastGame
//
//  Created by Joe Humphries on 24/06/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "IntroTwoLayer.h"


@implementation IntroTwoLayer

-(id) init
{
    CCLOG(@"IntroTwo Layer...with RC: %d",[self retainCount]);
	if( (self=[super init])) 
    {
        
        self.isTouchEnabled = YES;
        
    }
	return self;
}


@end
