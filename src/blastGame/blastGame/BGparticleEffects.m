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
    
    //Check if HD
    
    bool HD = NO;
    NSString* partFile;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        HD = YES;
    }
    
    
    if (pattern == SPORE)
    {
        HD = NO;
        partFile = @"spore.plist";
    } 
    else if (pattern == GALAXY_ONE)
    {
        partFile = @"galaxyOne.plist";
    }
    else if (pattern == STARFIELD1)
    {
        partFile = @"starfield1.plist";
    }
    
    
    
    
    if (HD)
    {
        partFile = [NSString stringWithFormat:@"2%@",partFile]; 
    }
    
    retPart = [CCParticleSystemQuad particleWithFile:partFile];
    CCLOG(@"Using particle file from %@", partFile);
    return retPart;
}

+(CCParticleSystem*) getHitPlanet
{
    CCParticleSystem* retPart = nil;
    
    retPart = [CCParticleSystemQuad particleWithFile:@"hitplanet.plist"];
    
    return retPart;
}


@end
