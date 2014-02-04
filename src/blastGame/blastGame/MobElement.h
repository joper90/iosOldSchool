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
    CCSprite* localSprite;
    int spriteTag;
    
    //Type of mob
    MOB_COLOUR mobType;
    
    //action to run when invoked
    id  actionSequenceToRun;
    
    //is on the screen and running.
    BOOL isAlive;
    
    //is pumping (been stated)
    BOOL isPumping;
    
    //initialStart point.
    CGPoint initPos;
}

@property (readwrite, assign) BOOL isEmptySpace;
@property (readwrite, assign) BOOL isAlive;
@property (readwrite, assign) BOOL isPumping;
@property (readwrite, assign) int spriteTag;
@property (readonly) MOB_COLOUR mobType;
@property (readonly) CGPoint initPos;


-(CCSprite*) getSprite;
-(CCSequence*) getSequence;
//-(void) addSprite:(CCSprite*) spriteToAdd with:(CCSequence*) actionSequence;

-(void)addCompleteSprite:(CCSprite *)pointerToSprite
                 withTag:(int) tag
       withSequence:(CCSequence *)actionsSequence
       withAnchorpoint:(CGPoint) aPoint
       withMobType:(MOB_COLOUR) mobType
      andSetInitPosition:(CGPoint) initPositions
       ;



-(void) removeSprite;

@end
