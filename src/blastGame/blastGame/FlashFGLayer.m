//
//  FlashFGLayer.m
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "FlashFGLayer.h"

@implementation FlashFGLayer

-(id) init
{
	if( (self=[super init])) {
		
        
        
		// create and initialize a Label
		CCLabelTTF *companyLabel = [CCLabelTTF labelWithString:@"funkVoodoo" fontName:@"efmi" fontSize:48];
        CCLabelTTF *companySubtext = [CCLabelTTF labelWithString:@"productions" fontName:@"efmi" fontSize:25];
        CCLabelTTF *copyrightMessage = [CCLabelTTF labelWithString:@"(c) 2012 funkVoodoo productions" fontName:@"Arial" fontSize:10];
        
		// position the label on the center of the screen
        CGPoint centerPos= [[Utils instance]center];
		companyLabel.position =  centerPos;
        
        CGPoint companySubtextPostion = ccp(centerPos.x + 40 , centerPos.y - 30);
		companySubtext.position = companySubtextPostion;
        
        CGPoint copyrightMessagePosition = ccp(centerPos.x , centerPos.y -150);
        copyrightMessage.position = copyrightMessagePosition;
        
        
		// add the label as a child to this Layer
		[self addChild: companyLabel];
        [self addChild: companySubtext];
        [self addChild: copyrightMessage];
        
        //Add the timeout scheduler
        [self schedule:@selector(timeToGo:) interval:5.0f];
	}
	return self;
}

-(void)timeToGo:(ccTime) delta
{
    //remove this scheduler
    [self unschedule:_cmd];
    CCLOG(@"Timed OUT....");
    
    //Insert transistion here to mailScene
    CCTransitionFade* ccFade = [CCTransitionFade transitionWithDuration:2 scene:[TitleScene scene]];
    
    [[CCDirector sharedDirector]pushScene:ccFade];
}
@end
