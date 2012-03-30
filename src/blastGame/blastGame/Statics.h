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

//Elements Z level Tag from 100 up
#define Z_PLANET_TAG            100
#define Z_GUN_TAG               101
#define Z_PLANT_HIT_TAG         102
#define Z_COUNTDOWN_TEXT_TAG    103
#define Z_BG_MENU_TAG           104
#define Z_BG_MENU_GAMENAME      105
#define Z_BG_MENU_STARTBUTTON   106
#define Z_BG_MENU_HISCORE_HELP  107



//Elements Tags from 500 up.
#define PLANET_TAG              500
#define GUN_TAG                 501
#define PLANET_HIT_TAG          502
#define COUNTDOWN_TEXT_TAG      503


// Layer tags from 1000 up
#define T_FLASH_FG_LAYER        1000
#define T_MAIN_LAYER            1001
#define T_MAIN_FG_SCORE_LAYER   1002
#define T_MAIN_BG_LAYER         1003


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

//Barrier Locations:
#define LINE_ONE       150
#define LINE_TWO       250
#define LINE_THREE     350

#define LINE_ONE_SCORE      10
#define LINE_TWO_SCORE      20
#define LINE_THREE_SCORE    30
#define LINE_ENDZONE_SCORE  40


//Game constants used for tweaking.
#define DRAG_CLICK_LENIENCY         20 //10 pixels for click/drag issues.
#define MOB_ROW_COUNT               5  //5 rows of mobs at once
#define START_OFFSCREEN_OFFSET      20 //Screen offset for mob placement.
#define MAX_TOUCH_SELECTED          4 // Max number of touches before a swipe is required.
#define PLANET_X_POSITION           20// position the mob moved to (planet hit)

#define GUN_X_POSITION              40 //X poistion of the gun.

#define LEVEL_COMPLETE_POLLTIME     5 // 2 seconds..

#define FONT_SIZE                   20 //base fontsize
#define FONT_SIZE_COUNTDOWN         70 //countdown fontsize.

//Flash (splash) screen
extern NSString *const COMPANY_NAME;
extern NSString *const COMPANY_SUBTEXT;
extern NSString *const COPYRIGHT_MESSAGE;


//JSON FILE
extern NSString *const JSON_FILE;

@interface Statics : NSObject

@end
