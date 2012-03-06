//
//  Statics.h
//  blastGame
//
//  Created by Joe Humphries on 06/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//Elements Tags from 1 up.


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

//Game constants used for tweaking.
#define DRAG_CLICK_LENIENCY  20 //10 pixels for click/drag issues.


//Flash (splash) screen
#define COMPANY_NAME "funkVoodoo";
#define COMPANY_SUBTEXT "productions";
#define COPYRIGHT_MESSAGE "(c) 2012 funkVoodoo";




//JSON FILE
extern NSString *const JSON_FILE;

@interface Statics : NSObject

@end
