//
//  PersistElements.m
//  blastGame
//
//  Created by Joe Humphries on 18/04/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "PersistElements.h"

@implementation PersistElements

-(NSMutableArray*) getHiScores;
{
    CCLOG(@"getHiScore called");
    NSMutableArray* hiScores = (NSMutableArray*) [[NSUserDefaults standardUserDefaults] objectForKey:BLASTED_SCORES];
    return hiScores;
}

-(void) initHiScores
{
    CCLOG(@"initHiScores called");
    
    NSMutableArray* hiScores = (NSMutableArray*) [[NSUserDefaults standardUserDefaults] objectForKey:BLASTED_SCORES];
    
    if (hiScores == nil)
    {
        CCLOG(@"Creating the init hiScores on device.");
        hiScores = [[NSMutableArray alloc]initWithObjects:  [NSNumber numberWithInt: 100],
                                                            [NSNumber numberWithInt: 200],
                                                            [NSNumber numberWithInt: 300],
                                                            [NSNumber numberWithInt: 400],
                                                            [NSNumber numberWithInt: 500],
                                                            nil];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:hiScores forKey:BLASTED_SCORES]; 
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(bool) pushScoreAndSave:(int) newScore
{
    CCLOG(@"pushScoreAndSave called with %d", newScore);
    [self initHiScores]; //check its not been removed. 
    NSMutableArray* hiScores = (NSMutableArray*) [[NSUserDefaults standardUserDefaults] objectForKey:BLASTED_SCORES];
    
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    [hiScores sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    
    //get the lowest score of the lot. (this should be element number 5
    NSNumber* lowest = [hiScores objectAtIndex:4];  /// check if 4 or 5 start at zero in objective c?
    
    int lowestInt = [lowest intValue];
    
    if (newScore > lowestInt) // a new hi score.. 
    {
        CCLOG(@"===> new hiScore recored. called");
        [hiScores insertObject:[NSNumber numberWithInt: newScore] atIndex:4];
        [hiScores sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
        
        //Now save away
        [[NSUserDefaults standardUserDefaults] setObject:hiScores forKey:BLASTED_SCORES]; 
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        return YES;
    }
    return NO;
}

@end
