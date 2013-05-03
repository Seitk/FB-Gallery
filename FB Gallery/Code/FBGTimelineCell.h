//
//  FBGTimelineCell.h
//  FB Gallery
//
//  Created by Philip Yu on 5/3/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBGTimelinePhotoView.h"

@interface FBGTimelineCell : UITableViewCell
{
    bool configured;
}

@property (nonatomic,strong) IBOutlet UIView *cellContentView;
@property (nonatomic,strong) IBOutlet FBGTimelinePhotoView *photoView;

- (void) initTimelineCell;
- (bool) configured;

@end
