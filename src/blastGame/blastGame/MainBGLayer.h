//
//  MainBGLayer.h
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo. All rights reserved.
//

#import "cocos2d.h"
#import "BGparticleEffects.h"
#import "BlastedEngine.h"

@interface MainBGLayer : CCLayer
{
    CCParticleSystem* partSystem;
    
    CGPoint lineOneStart;
    CGPoint lineTwoStart;
    CGPoint lineThreeStart;
}

@property (readwrite, assign) CCParticleSystem* partSystem;

@end
