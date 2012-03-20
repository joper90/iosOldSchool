//
//  MainFGLayer.h
//  blastGame
//
//  Created by AppleUser on 19/03/2012.
//  Copyright (c) 2012 funkvoodoo.com. All rights reserved.
//

#import "cocos2d.h"
#import "BlastedEngine.h"
#import "CoreImports.h"

@interface MainFGLayer : CCLayer
{
    CCLabelTTF* scoreLabel;
    NSString* scoreString;
    
    CCLabelTTF* percentCompleteLabel;
    NSString* percentCompleteString;

    CCLabelTTF* multiplierLabel;
    NSString* multiplierString;
}

-(void)callBackPokeUpdate;

@end
