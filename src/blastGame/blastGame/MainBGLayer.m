//
//  MainBGLayer.m
//  blastGame
//
//  Created by Joe Humphries on 28/02/2012.
//  Copyright (c) 2012 funkvoodoo.com All rights reserved.
//

#import "MainBGLayer.h"

@implementation MainBGLayer

@synthesize partSystem;

-(id) init
{
    CCLOG(@"MainLayer FG Layer...");
	if( (self=[super init])) 
    {
        //disable touches
        self.isTouchEnabled = YES;

        int part = [[BlastedEngine instance]getBackGroundParticle];
        partSystem = [BGparticleEffects getParticle:part];
    
        [self addChild:partSystem];     
        
        //Setup the lines
        lineOneStart = ccp([Properties instance].LINE_ONE,0);
        lineOneEnd = ccp([Properties instance].LINE_ONE, [Utils instance].screenHeight);
        lineTwoStart = ccp([Properties instance].LINE_TWO,0);
        lineTwoEnd = ccp([Properties instance].LINE_TWO, [Utils instance].screenHeight);
        lineThreeStart = ccp([Properties instance].LINE_THREE,0);
        lineThreeEnd = ccp([Properties instance].LINE_THREE, [Utils instance].screenHeight);
    }
	return self;
}


-(void)draw
{
    //Overide draw.
    //glEnable(GL_LINE_SMOOTH);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    //Line One
    glLineWidth(10);
    glColor4ub(150, 0, 0, 40);
	    
    ccDrawLine(lineOneStart, lineOneEnd);
    ccDrawLine(lineTwoStart, lineTwoEnd);
    ccDrawLine(lineThreeStart, lineThreeEnd);
    
    glColor4ub(200, 0, 0, 100);
    glLineWidth(2);
    ccDrawLine(lineOneStart, lineOneEnd);
    ccDrawLine(lineTwoStart, lineTwoEnd);
    ccDrawLine(lineThreeStart, lineThreeEnd);
}
@end
