//
//  PYTimelineViewController.h
//  FB Gallery Example
//
//  Created by Philip Yu on 5/18/13.
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
