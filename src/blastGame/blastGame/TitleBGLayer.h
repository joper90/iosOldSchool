//
//  TitleBGLayer.h
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "CoreImports.h"
#import "cocos2d.h"
#import "MainScene.h"

@interface TitleBGLayer : CCLayer
{
    CGRect startGameRect;
    CGRect hiScoreRect;
    float  barPercentTime;
}

@property (readwrite,assign) float barPercentTime;

-(void)setBarTimeToZero;
-(void)setBatTimeToMax;
-(BOOL)isBarTimeZero;
-(BOOL)decreaseBarTimeByFactor:(float) factor;


@end
