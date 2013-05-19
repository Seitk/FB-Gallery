//
//  UIView+viewController.m
//  FB Gallery
//
//  Created by Philip Yu on 5/3/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import "UIView+viewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (viewController)

- (UIViewController *) firstAvailableUIViewController {
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

- (float) traverseViewChainForView:(UIView *)view toViewClass:(Class)class offset:(float)offset
{    
    if ([view.superview isKindOfClass:class])
    {
        return view.superview.frame.origin.y + offset;
    } else if ([view.superview isKindOfClass:[UIView class]]) {
        return [self traverseViewChainForView:view.superview toViewClass:class offset:view.superview.frame.origin.y + offset];
    } else {
        return offset;
    }
}

- (float) findViewOffsetToSuperviewClass:(Class)class
{
    return [self traverseViewChainForView:self toViewClass:class offset:0];
}

- (void) shiftViewPositionY:(float)offset
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y += offset;
    [self setFrame:tempFrame];
}

+ (UIImageView*)screenshotForScreen{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [[UIScreen mainScreen] scale]);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGFloat barHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    if ([UIApplication sharedApplication].statusBarHidden == NO) {
        
        CGFloat scale = [[UIScreen mainScreen] scale];
        CGRect rect = CGRectMake(0, barHeight * scale, view.bounds.size.width * scale, (view.bounds.size.height - barHeight) * scale);
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
        image = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    }
    
	UIImageView* screenshot = [[UIImageView alloc] initWithImage:image];
    screenshot.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height - barHeight);
    
    return screenshot;
}

+ (UIImageView*)screenshotForView:(UIView*) view {
    
    bool viewHidden = 0;
    
    if (view.hidden == YES) {
        viewHidden = 1;
        [view setHidden:NO];
    }
    
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [[UIScreen mainScreen] scale]);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //    if ([UIApplication sharedApplication].statusBarHidden == NO) {
    //        CGFloat barHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //        CGFloat scale = [[UIScreen mainScreen] scale];
    //        CGRect rect = CGRectMake(0, barHeight * scale, view.bounds.size.width * scale, (view.bounds.size.height - barHeight) * scale);
    //        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    //        image = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    //    }
    
	UIImageView* screenshot = [[UIImageView alloc] initWithImage:image];
    screenshot.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
    
    if (viewHidden) [view setHidden:YES];
    
    return screenshot;
}

@end
