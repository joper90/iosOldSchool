//
//  BGparticleEffects.h
//  blastGame
//
//  Created by AppleUser on 19/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "cocos2d.h"

typedef enum{
    SPORE = 0,
    GALAXY_ONE,
    STARFIELD1
    
} backroundPattern;

typedef enum
{
    GALAXYONE,
    GALAXYTWO,
    STARFIELD
} titlePatterns;

@interface BGparticleEffects : NSObject
{
    
}

+(CCParticleSystem*) getParticle:(backroundPattern) pattern;
+(CCParticleSystem*) getHitPlanet;
+(CCParticleSystem*) getTitleGalaxy:(titlePatterns)titlePatterns;
@end
