//
//  FBGPhotoBrowserViewController.m
//  FB Gallery
//
//  Created by Philip Yu on 5/3/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import "FBGPhotoBrowserViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kAnimationDuration 0.2
#define kBGpushBackRatio 0.92
#define tagScreenshot 1000

@interface FBGPhotoBrowserViewController ()

@end

@implementation FBGPhotoBrowserViewController
@synthesize scrollView = _scrollView;
@synthesize screenshot, currentPhoto, timelinePhoto;

// TODO: Multiple photos, photo zooming, photo description, support for different kind of image

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
	  
    [_scrollView addSubview:screenshot];
    [_scrollView addSubview:currentPhoto];
    
    currentPhoto.originalFrame = currentPhoto.frame;
    
    // Offset for screenshot without status bar
    CGRect screenshotFrame = screenshot.frame;
    screenshotFrame.origin.y += 20;
    [screenshot setTag:tagScreenshot];
    [screenshot setFrame:screenshotFrame];
    
    // Current photo configuration
    [currentPhoto setUserInteractionEnabled:YES];
    [currentPhoto setContentMode:UIViewContentModeScaleAspectFill];
    
    [self startAnimation];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // TODO: handle orientation
}

- (void) startAnimation
{
    float scaleRatio = self.view.frame.size.width / currentPhoto.image.size.width;
    float newHeight = scaleRatio * currentPhoto.image.size.height;
    float originCenterY = currentPhoto.center.y;
        
    [UIView animateWithDuration:kAnimationDuration*2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        screenshot.alpha = 0.0;
        [self pushDownBgView:YES];
        [currentPhoto setFrame:CGRectMake(0, (self.view.frame.size.height + 20) / 2 - newHeight / 2, self.view.frame.size.width, newHeight)];
    } completion:^(BOOL finished) {
        [self boundCurrentPhoto:originCenterY - currentPhoto.center.y];        
    }];
}





- (void) exitBrowserView
{    
    [CATransaction begin];
    [CATransaction setAnimationDuration:kAnimationDuration];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [CATransaction setCompletionBlock:^{
        // Back to timeline view when animation ended
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
    [self pushDownBgView:NO];
    
    [CATransaction commit];
}

#pragma marks - Animations

- (void) pushDownBgView:(bool)push
{
    CABasicAnimation *animation;
    animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.delegate = self;
    animation.duration = kAnimationDuration;
    animation.repeatCount = 0;
    animation.removedOnCompletion = FALSE;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = push ? [NSNumber numberWithFloat:1] : [NSNumber numberWithFloat:kBGpushBackRatio];
    animation.toValue = push ? [NSNumber numberWithFloat:kBGpushBackRatio] : [NSNumber numberWithFloat:1.0];
    
    [screenshot.layer addAnimation:animation forKey:nil];
}

- (void) boundCurrentPhoto:(float)distance
{
    // Bound photo based on distance
    CABasicAnimation *animation;
    animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.delegate = self;
    animation.duration = kAnimationDuration / 2  ;
    animation.repeatCount = 0;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:distance * -0.05];
    
    [currentPhoto.layer addAnimation:animation forKey:@"transform.translation.y"];
}

@end
