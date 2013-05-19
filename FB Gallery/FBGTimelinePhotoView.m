//
//  FBGPhotoView.m
//  FB Gallery
//
//  Created by Philip Yu on 5/3/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import "FBGTimelinePhotoView.h"
#import "UIView+viewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation FBGTimelinePhotoView

- (void) initTimelinePhoto
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 2.0;
    self.clipsToBounds = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    
	NSUInteger tapCount = touch.tapCount;
	switch (tapCount) {
		case 1:
            [self singleTapHandler];
            break;
		default:
			break;
	}

	[[self nextResponder] touchesEnded:touches withEvent:event];
}

- (void) singleTapHandler {
    // Offset in cell + cell offset in tableview
    CGRect cellFrame = self.superview.superview.frame;
    
    float imgX = self.frame.origin.x + cellFrame.origin.x;
    float imgY = self.frame.origin.y + [self findViewOffsetToSuperviewClass:[UITableView class]];
    
    float positionYatModal = imgY - [(UIScrollView *)[self firstAvailableUIViewController].view contentOffset].y;
    
    UIImageView *selfCloneImg = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, positionYatModal, self.frame.size.width, self.frame.size.height)];
    selfCloneImg.image = self.image;
    
    NSArray *tempContainer = [NSArray arrayWithObjects:self, selfCloneImg, nil];
    [[self firstAvailableUIViewController] performSelector:@selector(browsePhoto:) withObject:tempContainer];
}


@end
