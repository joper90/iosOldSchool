//
//  MobElement.h
//  blastGame
//
//  Created by AppleUser on 29/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "cocos2d.h"
#import "CoreImports.h"

@interface MobElement : NSObject
{
    //The Sprite
    CCSprite* sprite;
    int spriteTag;
    
    //Type of mob
    MOBTYPE mobType;
    
    
    //TESTING TO BE REMOVED
    CGPoint initPos;
}

//@property (readwrite, assign) CCSprite* sprite;
@property (readwrite, assign) MOBTYPE mobType;
@property (readwrite, assign) int spriteTag;
@property (readwrite, assign) CGPoint initPos;


-(CCSprite*) getSprite;
-(void) addSprite:(CCSprite*) spriteToAdd;
-(void) removeSprite;

@end
