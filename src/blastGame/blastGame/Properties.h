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
    float     DRAG_SELECT_FREEDOM;
    float     QUIT_DRAG_SIZE;
    
    NSString* ROCKET;
    NSString* EXPLODE;
    
    NSString* RED_SPRITE_FILE;
    NSString* YELLOW_SPRITE_FILE;
    NSString* BLUE_SPRITE_FILE;
    NSString* GREEN_SPRITE_FILE;
    NSString* PINK_SPRITE_FILE;
    NSString* PURPLE_SPRITE_FILE;
    NSString* WHITE_SPRITE_FILE;
    
    NSString* GUN_SPRITE_FILE;
    NSString* BASE_SPRITE_FILE;
    NSString* LOCKON_SPRITE_FILE;
    
    NSString* BLASTED_MENU_FILE; 
    
    float     GUN_X_POSISTION;
    
    float     FONT_SIZE;
    float     FONT_SIZE_COUNTDOWN;
    float     FONT_LEVEL_NAME_SIZE;
    
    float     FONT_HISCORE_SIZE;
    float     HI_SCORE_START_POS;
    float     HI_SCORE_GAP_SIZE;
    
    float     LINE_ONE;
    float     LINE_TWO;
    float     LINE_THREE;
    
    bool      isValid;
}

@property (assign, readwrite) float DRAG_SELECT_FREEDOM;
@property (assign, readwrite) float QUIT_DRAG_SIZE;

@property (retain, readwrite) NSString* ROCKET ;
@property (retain, readwrite) NSString* EXPLODE ;
@property (retain, readwrite) NSString* RED_SPRITE_FILE ;
@property (retain, readwrite) NSString* YELLOW_SPRITE_FILE ;
@property (retain, readwrite) NSString* BLUE_SPRITE_FILE ;
@property (retain, readwrite) NSString* GREEN_SPRITE_FILE ;
@property (retain, readwrite) NSString* PINK_SPRITE_FILE ;
@property (retain, readwrite) NSString* PURPLE_SPRITE_FILE ;
@property (retain, readwrite) NSString* WHITE_SPRITE_FILE ;

@property (retain, readwrite) NSString* GUN_SPRITE_FILE;
@property (retain, readwrite) NSString* BASE_SPRITE_FILE;
@property (retain, readwrite) NSString* LOCKON_SPRITE_FILE;

@property (retain, readwrite) NSString* BLASTED_MENU_FILE;  

@property (assign, readwrite) float GUN_X_POSISTION;

@property (assign, readwrite) float FONT_SIZE;
@property (assign, readwrite) float FONT_SIZE_COUNTDOWN;
@property (assign, readwrite) float FONT_LEVEL_NAME_SIZE;
@property (assign, readwrite) float FONT_HISCORE_SIZE;
@property (assign, readwrite) float HI_SCORE_START_POS;
@property (assign, readwrite) float HI_SCORE_GAP_SIZE;

@property (assign, readwrite) float LINE_ONE;
@property (assign, readwrite) float LINE_TWO;
@property (assign, readwrite) float LINE_THREE;

@property (assign, readwrite) bool  isValid;

//singleton of the engine
+(Properties*) instance;
-(void)setupAndParse;


@end
