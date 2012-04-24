//
//  HiScoreLayer.m
//  blastGame
//
//  Created by Joe Humphries on 19/04/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "HiScoreLayer.h"


@implementation HiScoreLayer


-(id) init
{
    CCLOG(@"hiScore Layer...with RC: %d",[self retainCount]);
	if( (self=[super init])) 
    {
        
        //Get and push the new hiscore:
        BOOL newHiScore = [[BlastedEngine instance]submitHiScore:[[BlastedEngine instance]currentScore]];
        
        CCLabelTTF *hiScore = [CCLabelTTF labelWithString:@"hi-scores" fontName:@"efmi" fontSize:[Properties instance].FONT_HISCORE_SIZE];
        
        //Get the current scores
        NSMutableArray* hiScoreArray = [[BlastedEngine instance]getHiScoreArray];
        
        CCLabelTTF *scoreOne = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[hiScoreArray objectAtIndex:0] intValue]] fontName:@"efmi" fontSize:[Properties instance].FONT_HISCORE_SIZE];
        CCLabelTTF *scoreTwo = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[hiScoreArray objectAtIndex:1]intValue]] fontName:@"efmi" fontSize:[Properties instance].FONT_HISCORE_SIZE];        
        CCLabelTTF *scoreThree = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[hiScoreArray objectAtIndex:2]intValue]] fontName:@"efmi" fontSize:[Properties instance].FONT_HISCORE_SIZE]; 
        CCLabelTTF *scoreFour = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[hiScoreArray objectAtIndex:3]intValue]] fontName:@"efmi" fontSize:[Properties instance].FONT_HISCORE_SIZE]; 
        CCLabelTTF *scoreFive = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[hiScoreArray objectAtIndex:4]intValue]] fontName:@"efmi" fontSize:[Properties instance].FONT_HISCORE_SIZE]; 
        
        // position the label on the center of the screen
        CGPoint centerPos= [[Utils instance]center];
		hiScore.position =  centerPos;   
        
        float yPos = [Properties instance].HI_SCORE_START_POS;
        CGPoint localPos = ccp(centerPos.x, yPos);
        
        scoreOne.position = localPos;
        yPos -= [Properties instance].HI_SCORE_GAP_SIZE;
        localPos = ccp(centerPos.x, yPos);
        
        scoreTwo.position = localPos;
        yPos -= [Properties instance].HI_SCORE_GAP_SIZE;
        localPos = ccp(centerPos.x, yPos);
        
        scoreThree.position = localPos;
        yPos -= [Properties instance].HI_SCORE_GAP_SIZE;
        localPos = ccp(centerPos.x, yPos);
        
        
        scoreFour.position = localPos;
        yPos -= [Properties instance].HI_SCORE_GAP_SIZE;
        localPos = ccp(centerPos.x, yPos);
        
        scoreFive.position = localPos;
        
        [self addChild:hiScore];
        [self addChild:scoreOne];
        [self addChild:scoreTwo];
        [self addChild:scoreThree];
        [self addChild:scoreFour];
        [self addChild:scoreFive];
                
        self.isTouchEnabled = YES;
        
    }
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCTransitionFade* ccFade = [CCTransitionFade transitionWithDuration:0.5f scene:[TitleScene scene]];
    [[CCDirector sharedDirector]pushScene:ccFade];
}

@end
