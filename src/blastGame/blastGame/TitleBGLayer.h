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
    float  barPercentTime;
    
    CCParticleSystem* partSystemTitleGalaxy1;
    CCParticleSystem* partSystemTitleGalaxy2;
    CCParticleSystem* partSystemTitleStars;
}

@property (readwrite,assign) float barPercentTime;
@property (readwrite,assign) CCParticleSystem* partSystemTitleGalaxy1;
@property (readwrite,assign) CCParticleSystem* partSystemTitleGalaxy2;
@property (readwrite,assign) CCParticleSystem* partSystemTitleStars;

-(void)setBarTimeToZero;
-(void)setBatTimeToMax;
-(BOOL)isBarTimeZero;
-(BOOL)decreaseBarTimeByFactor:(float) factor;


@end
