//
//  MobElement.m
//  blastGame
//
//  Created by AppleUser on 29/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "MobElement.h"

@implementation MobElement
@synthesize mobType, spriteTag, initPos, isEmptySpace,  isAlive, isPumping;

-(CCSprite*) getSprite
{
    return localSprite;
}

-(CCSequence*) getSequence
{
    return actionSequenceToRun;
}

-(void)addSprite:(CCSprite *)spriteToAdd with:(CCSequence *)actionSequence
{
    //TO REMOVE set the initial posistion
    initPos = spriteToAdd.position;
    
    //set the tag so we can get it later by tag without drilling down
    spriteTag = spriteToAdd.tag;
    localSprite = spriteToAdd;
    actionSequenceToRun = actionSequence;
    //sprite = spriteToAdd;
    isAlive = NO;
    isPumping = NO;
}

-(void)removeSprite
{
}

@end
