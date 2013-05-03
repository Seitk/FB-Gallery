//
//  UIView+viewController.h
//  FB Gallery
//
//  Created by Philip Yu on 5/3/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (viewController)

- (UIViewController *) firstAvailableUIViewController;
- (id) traverseResponderChainForUIViewController;
+ (UIImageView*)screenshotForScreen;
+ (UIImageView*)screenshotForView:(UIView*) view;

@end
