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
#import "CoreImports.h"

@interface MainBGLayer : CCLayer
{
    CCParticleSystem* partSystem;
    
    CGPoint lineOneStart;
    CGPoint lineOneEnd;
    CGPoint lineTwoStart;
    CGPoint lineTwoEnd;
    CGPoint lineThreeStart;
    CGPoint lineThreeEnd;
}

@property (readwrite, assign) CCParticleSystem* partSystem;

@end
