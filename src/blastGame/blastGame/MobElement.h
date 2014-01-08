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
    CCSprite* __weak sprite;
    int spriteTag;
    
    //Type of mob
    MOB_COLOUR mobType;
    
    //action to run when invoked
    id __weak actionSequenceToRun;
    
    //is on the screen and running.
    BOOL isAlive;
    
    //is pumping (been stated)
    BOOL isPumping;
    
    //initialStart point.
    CGPoint initPos;
}

@property (weak, readonly) CCSprite* sprite;
@property (readwrite, weak) id actionSequenceToRun;
@property (readwrite, assign) BOOL isEmptySpace;
@property (readwrite, assign) BOOL isAlive;
@property (readwrite, assign) BOOL isPumping;
//@property (readwrite, assign) CCSprite* sprite;
@property (readwrite, assign) MOB_COLOUR mobType;
@property (readwrite, assign) int spriteTag;
@property (readwrite, assign) CGPoint initPos;


-(CCSprite*) getSprite;
-(void) addSprite:(CCSprite*) spriteToAdd;
-(void) removeSprite;

@end
