//
//  BGparticleEffects.m
//  blastGame
//
//  Created by AppleUser on 19/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "BGparticleEffects.h"

@implementation BGparticleEffects


+(CCParticleSystem*) getParticle:(backroundPattern) pattern
{
    CCParticleSystem* retPart = nil;
    
    if (pattern == SPORE)
    {
        retPart = [CCParticleSystemQuad particleWithFile:@"spore.plist"];
    } 
    else if (pattern == GALAXY_ONE)
    {
        retPart = [CCParticleSystemQuad particleWithFile:@"galaxyOne.plist"];
    }
    
    return retPart;
}

+(CCParticleSystem*) getHitPlanet
{
    CCParticleSystem* retPart = nil;
    
    retPart = [CCParticleSystemQuad particleWithFile:@"hitplanet.plist"];
    
    return retPart;
}


@end
