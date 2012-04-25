//
//  Properties.m
//  blastGame
//
//  Created by AppleUser on 03/04/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "Properties.h"

@implementation Properties
@synthesize RED_SPRITE_FILE, YELLOW_SPRITE_FILE, BLUE_SPRITE_FILE, GREEN_SPRITE_FILE, PINK_SPRITE_FILE,
            BLASTED_MENU_FILE, BASE_SPRITE_FILE, LOCKON_SPRITE_FILE,
            GUN_X_POSISTION,
            GUN_SPRITE_FILE,
            LINE_ONE, LINE_TWO, LINE_THREE,
            FONT_SIZE, FONT_SIZE_COUNTDOWN,
            FONT_LEVEL_NAME_SIZE,
            FONT_HISCORE_SIZE, HI_SCORE_GAP_SIZE, HI_SCORE_START_POS,
            DRAG_SELECT_FREEDOM,
            isValid;

static Properties* properties = nil;

+(Properties*) instance
{
    if (properties == nil)
    {
        CCLOG(@"properties instance started....");
        //Alive for the duration of the game
        properties = [[Properties alloc]init];
        PropertiesJsonParser* jsonParse = [[PropertiesJsonParser alloc]init];
        [jsonParse parseAndDigest];
        [jsonParse release];
        
        CCLOG(@"properties instance complete....");
    }
    return properties;
}


-(void)dealloc
{
    [properties release];
    [super dealloc];
}

@end
