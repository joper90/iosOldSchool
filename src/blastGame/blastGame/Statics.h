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


#define LINE_ONE_SCORE      10
#define LINE_TWO_SCORE      20
#define LINE_THREE_SCORE    30
#define LINE_ENDZONE_SCORE  40


//Game constants used for tweaking.
#define MOB_ROW_COUNT               5  //5 rows of mobs at once
#define START_OFFSCREEN_OFFSET      20 //Screen offset for mob placement.
#define MAX_TOUCH_SELECTED          4 // Max number of touches before a swipe is required.
#define PLANET_X_POSITION           20// position the mob moved to (planet hit)

#define GUN_X_POSITION              40 //X poistion of the gun.
#define GUN_FIRE_OFFSET             5 // postion to fire from for the gun.
#define GUN_FIRE_TIME               0.5f // time for the bullets to fly
#define MOB_PREDICTIVENESS          5

#define LEVEL_COMPLETE_POLLTIME     5 // 2 seconds..

#define MULTIPLIER_END_X            40 //end position for the multiplier
#define MULTIPLIER_BASE_SPEED      8 //seconds to move across the screen.
#define MULTIPLIER_INC_SPEED        0.5 // time to modify the base speed by each increase

//Flash (splash) screen
extern NSString *const COMPANY_NAME;
extern NSString *const COMPANY_SUBTEXT;
extern NSString *const COPYRIGHT_MESSAGE;


//JSON FILE
extern NSString *const JSON_FILE;
extern NSString *const IPAD_PROPERTIES;
extern NSString *const IPHONE_PROPERTIES;

//SAVE DATA FILE
extern NSString *const BLASTED_SCORES;

@interface Statics : NSObject

@end
