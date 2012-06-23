//
//  TitleBGLayer.h
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "CoreImports.h"
#import "cocos2d.h"
#import "BGparticleEffects.h"
#import "MainScene.h"

@interface TitleBGLayer : CCLayer
{
    CGRect startGameRect;
    CGRect hiScoreRect;
    CGRect howToPlayRect;
    
    CCParticleSystem* partSystemTitleGalaxy1;
    CCParticleSystem* partSystemTitleGalaxy2;
    CCParticleSystem* partSystemTitleStars;
}


@end
