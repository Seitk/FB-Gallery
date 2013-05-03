//
//  FBGPhotoBrowserViewController.h
//  FB Gallery
//
//  Created by Philip Yu on 5/3/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBGBrowsePhotoView.h"

@interface FBGPhotoBrowserViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *screenshot;

@property (nonatomic,strong) UIImageView *timelinePhoto;
@property (nonatomic,strong) FBGBrowsePhotoView *currentPhoto;

@end
