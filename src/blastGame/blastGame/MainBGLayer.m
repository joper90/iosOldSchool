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
    }
	return self;
}


-(void)draw
{
    //Overide draw.
    glLineWidth(2);
    glEnable(GL_LINE_SMOOTH);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    //Line One
    glLineWidth(10);
    glColor4ub(150, 0, 0, 100);
	
    ccDrawLine(dLine.start, dLine.end);
    
    glColor4ub(255, 0, 0, 255);
    glLineWidth(2);
    ccDrawLine(dLine.start, dLine.end);
}
@end
