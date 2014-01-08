
//
//  IntroFourLayer.m
//  blastGame
//
//  Created by Joe Humphries on 24/06/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "IntroFourLayer.h"


@implementation IntroFourLayer

-(id) init
{
    CCLOG(@"IntroOne Layer...with ");
	if( (self=[super init])) 
    {
        
        self.touchEnabled = YES;
        
    }
	return self;
}

@end
