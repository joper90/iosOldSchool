//
//  TitleFGlayer.h
//  blastGame
//
//  Created by AppleUser on 23/06/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "CoreImports.h"
#import "cocos2d.h"
#import "Properties.h"
#import "IntroOne.h"

@interface TitleFGlayer : CCLayer {
    
    CGRect startGameRect;
    CGRect hiScoreRect;
    CGRect howToPlayRect;
    CGRect soundSet;
    
    CCSprite* soundEnabledSprite;
    CCSprite* soundDisabledSprite;

}

@end
