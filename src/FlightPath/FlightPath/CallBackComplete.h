//
//  CallBackComplete.h
//  FlightPath
//
//  Created by AppleUser on 08/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
@interface CallBackComplete : NSObject
{
    int count; 
}
@property (readwrite,assign) int count;
-(void) callme:(id) sender;
@end
