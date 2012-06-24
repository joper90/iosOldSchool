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
    
    bool isHD;
    
    CCParticleSystem* partSystemTitleGalaxy1;
    CCParticleSystem* partSystemTitleGalaxy2;
    CCParticleSystem* partSystemTitleStars;
    
    NSMutableArray* mobList;
}

-(void)loadUpMobs;
-(void)fireMob:(ccTime)delta;
-(void)cleanupSprite:(CCSprite*)spriteToRemove;

@end
