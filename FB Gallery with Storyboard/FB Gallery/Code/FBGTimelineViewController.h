//
//  FBGTimelineViewController.h
//  FB Gallery
//
//  Created by Philip Yu on 5/3/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "MWPhoto.h"

@interface FBGTimelineViewController : UITableViewController<MWPhotoBrowserDelegate>

@property (nonatomic,strong) NSArray *tempAry;
@property (nonatomic,strong) NSArray *photos;
@property (nonatomic, strong) NSArray *timelinePhotos;

@end
