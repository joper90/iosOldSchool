//
//  PersistElements.h
//  blastGame
//
//  Created by Joe Humphries on 18/04/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "cocos2d.h"
#import "CoreImports.h"

@interface PersistElements : NSObject
{
    
}
 
-(NSMutableArray*) getHiScores;
-(id) initHiScores;
-(bool) pushScoreAndSave:(int) newScore;



@end
