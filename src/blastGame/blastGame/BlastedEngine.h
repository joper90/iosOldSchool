//
//  BlastedEngine.h
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreImports.h"

@interface BlastedEngine : NSObject
{
    //All Engine data here
    int currentScore;
}

@property (assign, readwrite) int currentScore;



//singleton of the engine
+(BlastedEngine*) instance;

@end
