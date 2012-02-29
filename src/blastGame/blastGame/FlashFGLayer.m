//
//  FlashFGLayer.m
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "FlashFGLayer.h"

@implementation FlashFGLayer

-(id) init
{
	if( (self=[super init])) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"funkVoodoo" fontName:@"Futura" fontSize:48];
        
		// position the label on the center of the screen
		label.position =  [[Utils instance]center];		
		// add the label as a child to this Layer
		[self addChild: label];
        
        //Add the timeout scheduler
        [self schedule:@selector(timeToGo:) interval:5.0f];
	}
	return self;
}

-(void)timeToGo:(ccTime) delta
{
    //remove this scheduler
    [self unschedule:_cmd];
    CCLOG(@"Timed OUT....");
}
@end
