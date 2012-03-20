//
//  BangAction.h
//  blastGame
//
//  Created by AppleUser on 16/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BangAction : NSObject
{
    int tag;
    int bulletElement;
    CGPoint position;
}

@property (readwrite,assign) int bulletElement;
@property (readwrite,assign) int tag;
@property (readwrite,assign) CGPoint position;
@end
