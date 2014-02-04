//
//  MobElement.m
//  blastGame
//
//  Created by AppleUser on 29/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "MobElement.h"

@implementation MobElement
@synthesize spriteTag, initPos, isEmptySpace,  isAlive, isPumping, mobType;

-(CCSprite*) getSprite
{
    return localSprite;
}

-(CCSequence*) getSequence
{
    return actionSequenceToRun;
}

-(void)addCompleteSprite:(CCSprite *)pointerToSprite withTag:(int) tag
                        withSequence:(CCSequence *)actionsSequence
                        withAnchorpoint:(CGPoint)aPoint
                        withMobType:(MOB_COLOUR)mobType
                        andSetInitPosition:(CGPoint)initPositions
{
    localSprite = [CCSprite spriteWithTexture:[pointerToSprite texture]];
    initPos = localSprite.position;
    spriteTag = tag;
    localSprite.tag = spriteTag;
    actionSequenceToRun = actionsSequence;
    isAlive = NO;
    isPumping = NO;
    isEmptySpace = NO;
    initPos = initPositions;
    localSprite.position = initPos;
}


-(void)removeSprite
{
}

@end
