//
//  HelloWorldLayer.m
//  FlightPath
//
//  Created by AppleUser on 08/03/2012.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

@synthesize callbackComplete;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        
        //Create the dummy callback class
        callbackComplete = [[CallBackComplete alloc]init];
        
        callbackComplete.count = 10;
        
        
		// create and initialize a Label
        CCSprite* sprite = [CCSprite spriteWithFile:@"icon-Small.png"];
        sprite.tag = 3;
        
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
        CCLOG(@"width %f",size.width);
		sprite.position =  ccp( size.width+100 , size.height/2 );
		// add the label as a child to this Layer
		[self addChild: sprite];
        
        [sprite runAction:[[FlightPaths instance]getSequence:callbackComplete selectedPattern:ZOOM movementModifer:0.0f withTag:sprite.tag currentPos:sprite.position ]];
	}
	return self;
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[callbackComplete release];
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
