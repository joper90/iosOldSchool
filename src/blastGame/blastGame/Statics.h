//
//  Statics.h
//  blastGame
//
//  Created by Joe Humphries on 06/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

/*
 
 Elements on the row data
 0 = empty
 1 = RED
 2 = YELLOW 
 3 = BLUE
 4 = GREEN
 5 = PINK
 
 Elements on the pattern data
 
 0 = NULL, for empty row data
 1 = STRAIGHT
 2 = FAST_IN_OUT
 3 = SLOW_IN_OUT
 4 = BEZIER_ONE
 5 = ZOOM
 
*/

#import <Foundation/Foundation.h>

//Elements Tags from 500 up.
#define GUN_TAG                 500;


// Layer tags from 1000 up
#define T_FLASH_FG_LAYER        1000
#define T_MAIN_LAYER            1001


//Scene from 5000 up
#define T_FLASH_SCENE           5000
#define T_MAIN_SCENE            5001


typedef enum
{
    SIMPLE,
    BOSS
}LEVEL_TYPE;

typedef enum
{
    RED,
    YELLOW,
    BLUE,
    GREEN,
    PINK
}MOB_COLOUR;

extern NSString *const RED_SPRITE_FILE;
extern NSString *const YELLOW_SPRITE_FILE;
extern NSString *const BLUE_SPRITE_FILE;
extern NSString *const GREEN_SPRITE_FILE;
extern NSString *const PINK_SPRITE_FILE;

extern NSString *const  GUN_SPRITE_FILE;

//Game constants used for tweaking.
#define DRAG_CLICK_LENIENCY         20 //10 pixels for click/drag issues.
#define MOB_ROW_COUNT               5  //5 rows of mobs at once
#define START_OFFSCREEN_OFFSET      20 //Screen offset for mob placement.
#define MAX_TOUCH_SELECTED          4 // Max number of touches before a swipe is required.

#define GUN_X_POSITION              10 //X poistion of the gun.


//Flash (splash) screen
extern NSString *const COMPANY_NAME;
extern NSString *const COMPANY_SUBTEXT;
extern NSString *const COPYRIGHT_MESSAGE;


//JSON FILE
extern NSString *const JSON_FILE;

@interface Statics : NSObject

@end
