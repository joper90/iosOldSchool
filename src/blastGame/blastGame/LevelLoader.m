//
//  LevelLoader.m
//  blastGame
//
//  Created by AppleUser on 05/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "LevelLoader.h"

@implementation LevelLoader


//Singleton
static LevelLoader* levelloader = nil;

+(LevelLoader*) instance
{
    if (levelloader == nil)
    {
        levelloader = [[LevelLoader alloc]init];
    }
    return levelloader;
}

@end
