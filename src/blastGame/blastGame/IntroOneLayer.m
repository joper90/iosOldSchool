//
//  IntroOneLayer.m
//  blastGame
//
//  Created by Joe Humphries on 24/06/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "IntroOneLayer.h"


@implementation IntroOneLayer


-(id) init
{
    CCLOG(@"IntroOne Layer...with RC: %d",[self retainCount]);
	if( (self=[super init])) 
    {
        
        self.isTouchEnabled = YES;
        
    }
	return self;
}
@end
