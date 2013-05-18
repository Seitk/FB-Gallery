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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        cellContentView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, 300, 440)];
        cellContentView.backgroundColor = [UIColor whiteColor];
        
        photoView = [[FBGTimelinePhotoView alloc] initWithFrame:CGRectMake(5, 102, 310, 310)];
        photoView.backgroundColor = [UIColor darkGrayColor];
        [photoView setUserInteractionEnabled:YES];
        
        UIView *profilePic = [[UIView alloc] initWithFrame:CGRectMake(9, 9, 30, 30)];
        profilePic.backgroundColor = [UIColor darkGrayColor];
        
        UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 9, 222, 18)];
        usernameLabel.font = [UIFont systemFontOfSize:14.0];
        usernameLabel.text = @"Username";
        
        UILabel *timestampLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 25, 222, 17)];
        timestampLabel.font = [UIFont systemFontOfSize:12.0];
        timestampLabel.text = @"3 hours ago";
        timestampLabel.textColor = [UIColor lightGrayColor];
        
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 50, 283, 41)];
        statusLabel.font = [UIFont systemFontOfSize:15.0];
        statusLabel.text = @"Status..status..status..status..status..status..status..status..status..status..status..status..status..status..status..";
        statusLabel.numberOfLines = 2;
        statusLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        UILabel *likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 413, 32, 21)];
        likeLabel.font = [UIFont systemFontOfSize:13.0];
        likeLabel.text = @"Like";
        
        UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(113, 413, 74, 21)];
        commentLabel.font = [UIFont systemFontOfSize:13.0];
        commentLabel.text = @"Comment";
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(246, 413, 46, 21)];
        shareLabel.font = [UIFont systemFontOfSize:13.0];
        shareLabel.text = @"Share";
        
        [self addSubview:cellContentView];
        [self addSubview:photoView];
        [cellContentView addSubview:profilePic];
        [cellContentView addSubview:usernameLabel];
        [cellContentView addSubview:timestampLabel];
        [cellContentView addSubview:statusLabel];
        [cellContentView addSubview:likeLabel];
        [cellContentView addSubview:commentLabel];
        [cellContentView addSubview:shareLabel];
        
        
    }
    return self;
}

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
