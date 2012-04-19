//
//  HiScoreScene.m
//  blastGame
//
//  Created by Joe Humphries on 19/04/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "HiScoreScene.h"


@implementation HiScoreScene

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    
	CCLayer* highScoreLayer = [HiScoreLayer node];
    [scene addChild:highScoreLayer];
    
    
    return scene;
}    

@end
