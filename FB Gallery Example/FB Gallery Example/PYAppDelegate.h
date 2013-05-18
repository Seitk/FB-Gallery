//
//  PYAppDelegate.h
//  FB Gallery Example
//
//  Created by Philip Yu on 5/18/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PYTimelineViewController;

@interface PYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PYTimelineViewController *viewController;

@end
