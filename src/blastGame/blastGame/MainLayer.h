//
//  MainLayer.h
//  blastGame
//
//  Created by AppleUser on 29/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "cocos2d.h"
#import "BlastedEngine.h"
#import "MobElement.h"

@interface MainLayer : CCLayer
{
    int tagCount;
    BOOL touchMoved;
    
    CGPoint initialTouch;
    CGPoint endTouch;
    MobElement* mobTouched;
}

-(void)mobFinished:(id) object;
-(void)checkSpriteTouchedAction;
-(void)laserAction;

@end
