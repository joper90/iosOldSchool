//
//  MobElement.m
//  blastGame
//
//  Created by AppleUser on 29/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "MobElement.h"

@implementation MobElement
@synthesize mobType, spriteTag, initPos;

-(CCSprite*) getSprite
{
    return sprite;
}

-(void)addSprite:(CCSprite *)spriteToAdd
{
    //TO REMOVE set the initial posistion
    initPos = spriteToAdd.position;
    
    //set the tag so we can get it later by tag without drilling down
    spriteTag = spriteToAdd.tag;
    sprite = spriteToAdd;
    [sprite retain];
}

-(void)removeSprite
{
    [sprite release];
}

-(void)dealloc
{
    [sprite dealloc];
    [super dealloc];
}
@end
