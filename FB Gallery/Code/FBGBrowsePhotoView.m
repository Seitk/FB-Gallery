//
//  FBGBrowsePhotoView.m
//  FB Gallery
//
//  Created by Philip Yu on 5/3/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import "FBGBrowsePhotoView.h"
#import "UIView+viewController.h"

#define tagScreenshot 1000

@implementation FBGBrowsePhotoView

@synthesize originalFrame, timelineFrame;

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    // Retrieve the touch point as image start location;
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    startLocation = pt;
    
    // Get image start origin
    imageStartOrigin = self.frame.origin;
    dragging = YES;
    
    // Disable scrollview
    if ([self.superview isKindOfClass:[UIScrollView class]])
    {
        [(UIScrollView *)self.superview setScrollEnabled:NO];
    }
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    // Move relative to the original touch point
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    CGRect frame = [self frame];
    
    // Calculate the drag distance
    float newY = imageStartOrigin.y - ((float)startLocation.y - (float)pt.y);
    float dY = newY - imageStartOrigin.y;
    
    // Bound drag distance and change alpha of background
    if (fabsf(dY) > self.frame.size.height / 4)
    {
        dY = self.frame.size.height / 4;
    }
    
    float newAlpha = fabsf(dY) / (self.frame.size.height / 2);
    [[self.superview viewWithTag:tagScreenshot] setAlpha:newAlpha - 0.1];

    // Get new location to image
    frame.origin.y = newY;
    [self setFrame:frame];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    
    // If touch event is ended dragging
    if (dragging)
    {
        // Enable scrollview
        if ([self.superview isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)self.superview setScrollEnabled:YES];
        }
        
        dragging = NO;
        
        // Calculate end point location
        CGPoint pt = [[touches anyObject] locationInView:self.superview];
        CGRect newFrame = [self frame];
        newFrame.origin.y = imageStartOrigin.y;
        
        float newY = imageStartOrigin.y - ((float)startLocation.y - (float)pt.y);
        float dY = newY - imageStartOrigin.y;
        
        // Action based on drag distance
        if (fabsf(dY) > self.frame.size.height / 4)
        {
            newFrame = timelineFrame;
            newFrame.origin.y += 20;
            
            // Reset photo to timeline position and exit from browser view
            [self setContentMode:UIViewContentModeScaleToFill];
            
            [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear
                 animations:^{
                     [self setFrame:newFrame];
                     [[self.superview viewWithTag:tagScreenshot] setAlpha:1.0];
                     [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
                     
                     [[self firstAvailableUIViewController] performSelector:@selector(exitBrowserView)];
                 }
                 completion:^(BOOL finished) {
                     
                 }
             ];
        } else
        {
            // Reset photo to center of scrollview
            [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear
                 animations:^{
                     [self setFrame:newFrame];
                     [[self.superview viewWithTag:tagScreenshot] setAlpha:0.0];
                 }
                 completion:^(BOOL finished) {
                     
                 }
            ];
        }        
        
    }
    
	NSUInteger tapCount = touch.tapCount;
	switch (tapCount) {
		case 1:
//			[self handleSingleTap:touch];
			break;
		case 2:
//			[self handleDoubleTap:touch];
			break;
		case 3:
//			[self handleTripleTap:touch];
			break;
		default:
			break;
	}
	[[self nextResponder] touchesEnded:touches withEvent:event];
}




@end
