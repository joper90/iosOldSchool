//
//  LevelCompleteLayer.m
//  blastGame
//
//  Created by AppleUser on 28/03/2012.
//  Copyright 2012 funkvoodoo.com. All rights reserved.
//

#import "LevelCompleteLayer.h"


@implementation LevelCompleteLayer

-(id) init
{
    CCLOG(@"GameOver Layer...with RC: %d",[self retainCount]);
	if( (self=[super init])) 
    {
        self.isTouchEnabled = YES;
        
        CCLabelTTF *levelComplete = [CCLabelTTF labelWithString:@"Level Complete..." fontName:@"efmi" fontSize:48];
        
        // position the label on the center of the screen
        CGPoint centerPos= [[Utils instance]center];
		levelComplete.position =  centerPos;   
        
        [self addChild:levelComplete];
    }
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[BlastedEngine instance]increaseLevelCount];
    CCTransitionFade* ccFade = [CCTransitionFade transitionWithDuration:2 scene:[MainScene scene]];
    [[CCDirector sharedDirector]pushScene:ccFade];
}
@end
