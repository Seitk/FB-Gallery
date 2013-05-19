//
//  UIImageViewTap.m
//  Momento
//
//  Created by Michael Waterfall on 04/11/2009.
//  Copyright 2009 d3i. All rights reserved.
//

#import "MWTapDetectingImageView.h"
#import "MWPhotoBrowser.h"
#import "MWZoomingScrollView.h"
#import "UIView+viewController.h"

#define tagScreenshot 1000

@implementation MWTapDetectingImageView

@synthesize tapDelegate;

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.userInteractionEnabled = YES;
	}
	return self;
}

- (id)initWithImage:(UIImage *)image {
	if ((self = [super initWithImage:image])) {
		self.userInteractionEnabled = YES;
	}
	return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
	if ((self = [super initWithImage:image highlightedImage:highlightedImage])) {
		self.userInteractionEnabled = YES;
	}
	return self;
}

- (UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    
    return nil;
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    // Retrieve the touch point as image start location;
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    startLocation = pt;
    
    // Get image start origin
    imageStartOrigin = self.frame.origin;
    dragging = YES;
    
    // Disable scrollview
    if ([[self firstAvailableUIViewController] isKindOfClass:[MWPhotoBrowser class]])
    {
        [[(MWPhotoBrowser *)[self firstAvailableUIViewController] getPagingScrollView] setScrollEnabled:NO];
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
    
    [(MWPhotoBrowser *)[self firstAvailableUIViewController] setTransparentForScreenshot:newAlpha - 0.2];
    
    // Get new location to image
    frame.origin.y = newY;
    [self setFrame:frame];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    NSUInteger tapCount = touch.tapCount;
    
    // If touch event is ended dragging
    if (dragging)
    {
        dragging = NO;
        
        // Enable scrollview
        if ([[self firstAvailableUIViewController] isKindOfClass:[MWPhotoBrowser class]])
        {
            [[(MWPhotoBrowser *)[self firstAvailableUIViewController] getPagingScrollView] setScrollEnabled:YES];
        }
        
        // Calculate end point location
        CGPoint pt = [[touches anyObject] locationInView:self.superview];
        CGRect newFrame = [self frame];
        newFrame.origin.y = imageStartOrigin.y;
        
        float newY = imageStartOrigin.y - ((float)startLocation.y - (float)pt.y);
        float dY = newY - imageStartOrigin.y;
        
        // Action based on drag distance
        if (fabsf(dY) > self.frame.size.height / 3)
        {
            // Reset photo to timeline position and exit from browser view
            [[self firstAvailableUIViewController] performSelector:@selector(exitBrowserView:) withObject:self];
        } else
        {
            // Reset photo to center of scrollview
            [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 [self setFrame:newFrame];
                                 [[(MWPhotoBrowser *)[self firstAvailableUIViewController] screenshot] setAlpha:0.0];
                             }
                             completion:^(BOOL finished) {
                                 
                             }
             ];
        }
        
    }
    
	switch (tapCount) {
		case 1:
			[self handleSingleTap:touch];
			break;
		case 2:
			[self handleDoubleTap:touch];
			break;
		case 3:
			[self handleTripleTap:touch];
			break;
		default:
			break;
	}
	[[self nextResponder] touchesEnded:touches withEvent:event];
}

- (void)handleSingleTap:(UITouch *)touch {
	if ([tapDelegate respondsToSelector:@selector(imageView:singleTapDetected:)])
		[tapDelegate imageView:self singleTapDetected:touch];
}

- (void)handleDoubleTap:(UITouch *)touch {
	if ([tapDelegate respondsToSelector:@selector(imageView:doubleTapDetected:)])
		[tapDelegate imageView:self doubleTapDetected:touch];
}

- (void)handleTripleTap:(UITouch *)touch {
	if ([tapDelegate respondsToSelector:@selector(imageView:tripleTapDetected:)])
		[tapDelegate imageView:self tripleTapDetected:touch];
}

@end
