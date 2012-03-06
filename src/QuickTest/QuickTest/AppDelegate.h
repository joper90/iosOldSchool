//
//  AppDelegate.h
//  QuickTest
//
//  Created by Joe Humphries on 06/03/2012.
//  Copyright funkvoodoo 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
