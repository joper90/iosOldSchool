//
//  PropertiesJsonParser.m
//  blastGame
//
//  Created by AppleUser on 03/04/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "PropertiesJsonParser.h"

@implementation PropertiesJsonParser

-(id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}


-(void)parseAndDigest
{
    CCLOG(@"parseing and digesting properties file");
    
    NSString* propertiesFile = @"";
    if ([BlastedEngine instance].isHdMode)
    {
        propertiesFile = IPAD_PROPERTIES;
    }
    else
    {
        propertiesFile = IPHONE_PROPERTIES;
        //propertiesFile = JSON_FILE;
    }    
    NSString* actualPath = [[Utils instance]getActualPath:propertiesFile];
    NSString* jsonString = [[NSString alloc]initWithContentsOfFile:actualPath encoding:NSUTF8StringEncoding error:nil];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    NSDictionary* dict = [[CJSONDeserializer deserializer]deserializeAsDictionary:jsonData error:nil];
    CCLOG(@"JSON Properties file: %@", jsonString);	

    //NSString* i = [dict valueForKey:@"information"];
   
    NSArray* props = [dict valueForKey:@"properties"];
    for (id p in props)
    {
        [Properties instance].DRAG_SELECT_FREEDOM = [[p objectForKey:@"dragselectfreedom"]floatValue];
        [Properties instance].QUIT_DRAG_SIZE = [[p objectForKey:@"quitdragsize"]floatValue];
        
        [Properties instance].ROCKET = [p objectForKey:@"rocket"];
        [Properties instance].EXPLODE = [p objectForKey:@"explode"];
        
        [Properties instance].GUN_SPRITE_FILE = [p objectForKey:@"gun"];
        [Properties instance].BASE_SPRITE_FILE = [p objectForKey:@"base"];
        [Properties instance].LOCKON_SPRITE_FILE = [p objectForKey:@"lockon"];
        
        [Properties instance].BLASTED_MENU_BG_FILE = [p objectForKey:@"menubackground"];
        [Properties instance].BLASTED_TITLE_FILE = [p objectForKey:@"titlegfx"];
        [Properties instance].BLASTED_MENU_LOCATION = [[Utils instance]covertStringOfCGPointToCGPoint:[p objectForKey:@"menulocation"]];
        [Properties instance].BLASTED_TITLE_FILE = [p objectForKey:@"titlegfx"];
        [Properties instance].BLASTED_MENU_BUTTONS = [p objectForKey:@"menubuttons"];
        
        NSArray* soundArray = [[p objectForKey:@"soundbuttons"] componentsSeparatedByString:@"|"];
        [Properties instance].BLASTED_MENU_SOUND_ON = [soundArray objectAtIndex:0];
        [Properties instance].BLASTED_MENU_SOUND_OFF = [soundArray objectAtIndex:1];
        
        [Properties instance].BLASTED_MENU_SOUND_LOCATION = [[Utils instance]covertStringOfCGPointToCGPoint:[p objectForKey:@"soundbuttonslocation"]];
        
        [Properties instance].FONT_SIZE = [[p objectForKey:@"fontsize"]floatValue];
        [Properties instance].FONT_SIZE_COUNTDOWN = [[p objectForKey:@"fontsizecountdown"]floatValue];
        [Properties instance].FONT_LEVEL_NAME_SIZE =[[p objectForKey:@"fontlevelnamesize"]floatValue];
        
        [Properties instance].FONT_HISCORE_SIZE  =[[p objectForKey:@"fonthiscoresize"]floatValue];
        [Properties instance].HI_SCORE_START_POS  =[[p objectForKey:@"hiscorestartpos"]floatValue]; 
        [Properties instance].HI_SCORE_GAP_SIZE  =[[p objectForKey:@"hiscoregap"]floatValue];
               
        [Properties instance].LINE_ONE = [[p objectForKey:@"lineone"]floatValue];
        [Properties instance].LINE_TWO = [[p objectForKey:@"linetwo"]floatValue];
        [Properties instance].LINE_THREE = [[p objectForKey:@"linethree"]floatValue];
        
        
    }
       
    //CCLOG(@" Processed : %@",i);
    CCLOG(@"Data : %@", [Properties instance].BASE_SPRITE_FILE);
    
}

@end
