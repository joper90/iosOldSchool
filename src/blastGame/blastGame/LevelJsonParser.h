//
//  LevelJsonParser.h
//  blastGame
//
//  Created by AppleUser on 05/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreImports.h"
#import "CJSONDeserializer.h"
#import "LevelElementData.h"
#import "BlastedEngine.h"

@interface LevelJsonParser : NSObject
{
    NSString* jsonFile;
}
+(LevelJsonParser*) instance;
-(BOOL)loadAndParseLevelFile;
-(void)processMap:(NSDictionary*) dict;
@end
