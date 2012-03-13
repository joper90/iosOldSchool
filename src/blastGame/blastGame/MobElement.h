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
    //need to change this really.
    BOOL isEmptySpace;
    
    //The Sprite
    CCSprite* sprite;
    int spriteTag;
    
    //Type of mob
    MOB_COLOUR mobType;
    
    //action to run when invoked
    id actionSequenceToRun;
    
    
    //initialStart point.
    CGPoint initPos;
}

@property (readonly) CCSprite* sprite;
@property (readwrite, assign) id actionSequenceToRun;
@property (readwrite, assign) BOOL isEmptySpace;
//@property (readwrite, assign) CCSprite* sprite;
@property (readwrite, assign) MOB_COLOUR mobType;
@property (readwrite, assign) int spriteTag;
@property (readwrite, assign) CGPoint initPos;


-(CCSprite*) getSprite;
-(void) addSprite:(CCSprite*) spriteToAdd;
-(void) removeSprite;

@end
