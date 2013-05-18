//
//  PYTimelineViewController.h
//  FB Gallery Example with Storyboard
//
//  Created by Philip Yu on 5/19/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "MWPhoto.h"
#import "FBGTimelineCell.h"
#import "FBGTimelinePhotoView.h"

@interface PYTimelineViewController : UITableViewController<MWPhotoBrowserDelegate>

@property (nonatomic,strong) NSArray *photos;

@end
