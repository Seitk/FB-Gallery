//
//  FBGBrowsePhotoView.h
//  FB Gallery
//
//  Created by Philip Yu on 5/3/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBGBrowsePhotoView : UIImageView
{
    CGPoint startLocation;
    CGPoint imageStartOrigin;
    float lastDragPt;
    
    bool dragging;
}

@property (nonatomic) CGRect timelineFrame;
@property (nonatomic) CGRect originalFrame;

@end
