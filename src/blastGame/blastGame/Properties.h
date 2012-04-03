//
//  Properties.h
//  blastGame
//
//  Created by AppleUser on 03/04/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "cocos2d.h"
#import "PropertiesJsonParser.h"

@interface Properties : NSObject
{
    NSString* RED_SPRITE_FILE;
    NSString* YELLOW_SPRITE_FILE;
    NSString* BLUE_SPRITE_FILE;
    NSString* GREEN_SPRITE_FILE;
    NSString* PINK_SPRITE_FILE;
    
    NSString* GUN_SPRITE_FILE;
    NSString* PLANET_SPRITE_FILE;
    
    float     GUN_X_POSISTION;
    
    float     FONT_SIZE;
    float     FONT_SIZE_COUNTDOWN;
    
    float     LINE_ONE;
    float     LINE_TWO;
    float     LINE_THREE;
    
    bool      isValid;
}

@property (assign, readwrite) NSString* RED_SPRITE_FILE ;
@property (assign, readwrite) NSString* YELLOW_SPRITE_FILE ;
@property (assign, readwrite) NSString* BLUE_SPRITE_FILE ;
@property (assign, readwrite) NSString* GREEN_SPRITE_FILE ;
@property (assign, readwrite) NSString* PINK_SPRITE_FILE ;

@property (assign, readwrite) NSString*  GUN_SPRITE_FILE;
@property (assign, readwrite) NSString*  PLANET_SPRITE_FILE;

@property (assign, readwrite) float GUN_X_POSISTION;

@property (assign, readwrite) float FONT_SIZE;
@property (assign, readwrite) float FONT_SIZE_COUNTDOWN;

@property (assign, readwrite) float LINE_ONE;
@property (assign, readwrite) float LINE_TWO;
@property (assign, readwrite) float LINE_THREE;

@property (assign, readwrite) bool  isValid;

//singleton of the engine
+(Properties*) instance;


@end
