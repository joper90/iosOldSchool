//
//  CallBackComplete.m
//  FlightPath
//
//  Created by AppleUser on 08/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CallBackComplete.h"

@implementation CallBackComplete
@synthesize count;
-(void) callme:(id)sender
{
    NSNumber* ttt = sender;
    int x = [ttt integerValue];
    CCLOG(@"callme: called with tag : %d", x);
}
@end
