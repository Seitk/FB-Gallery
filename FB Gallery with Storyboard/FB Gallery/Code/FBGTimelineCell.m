//
//  FBGTimelineCell.m
//  FB Gallery
//
//  Created by Philip Yu on 5/3/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import "FBGTimelineCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation FBGTimelineCell
@synthesize cellContentView, photoView;

- (void) initTimelineCell
{
    cellContentView.layer.cornerRadius = 2;
    cellContentView.layer.masksToBounds = NO;
    
    [photoView initTimelinePhoto];
    
    configured = YES;
}

- (bool) configured
{
    return configured;
}

@end
