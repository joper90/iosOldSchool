//
//  RowPositions.h
//  blastGame
//
//  Created by AppleUser on 26/04/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "cocos2d.h"
#import "CoreImports.h"

@interface RowPositions : NSObject 
{
    NSMutableDictionary* startPositionMap1;
    NSMutableDictionary* startPositionMap2;
    NSMutableDictionary* startPositionMap3;
    NSMutableDictionary* startPositionMap4;
    NSMutableDictionary* startPositionMap5;
    NSMutableDictionary* startPositionMap6;
    NSMutableDictionary* startPositionMap7;
    NSMutableDictionary* startPositionMap8;
    
    CGSize screenSize;
    float offscreenStart;
}

@property (strong, readwrite) NSMutableDictionary* startPositionMap1;
@property (strong, readwrite) NSMutableDictionary* startPositionMap2;
@property (strong, readwrite) NSMutableDictionary* startPositionMap3;
@property (strong, readwrite) NSMutableDictionary* startPositionMap4;
@property (strong, readwrite) NSMutableDictionary* startPositionMap5;
@property (strong, readwrite) NSMutableDictionary* startPositionMap6;
@property (strong, readwrite) NSMutableDictionary* startPositionMap7;
@property (strong, readwrite) NSMutableDictionary* startPositionMap8;

-(void)createAllData;
-(void)injectElements:(NSMutableDictionary*) elementToInject withRows:(int)rowCount;
-(CGPoint) getRowPositionByRowCount:(int) rowCount andPositionRequired:(int) position;
@end
