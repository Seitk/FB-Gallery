//
//  FBGTimelineViewController.m
//  FB Gallery
//
//  Created by Philip Yu on 5/3/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import "FBGTimelineViewController.h"
#import "FBGTimelineCell.h"
#import "FBGBrowsePhotoView.h"
#import "FBGPhotoBrowserViewController.h"

#import "MWPhotoBrowser.h"
#import "MWTapDetectingImageView.h"

#import "UIView+viewController.h"

@interface FBGTimelineViewController ()

@end

@implementation FBGTimelineViewController

@synthesize photos = _photos;
@synthesize timelinePhotos;
@synthesize tempAry;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) browsePhoto:(id)photo
{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    
    [photos addObject:[MWPhoto photoWithImage:[(UIImageView *)photo image]]];
    
    self.photos = photos;
    
	// Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    [browser setInitialPageIndex:0];
    browser.displayActionButton = YES;
    browser.screenshot = [UIView screenshotForScreen];
    
    UIImageView *tempImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [(UIImageView *)photo frame].size.width, [(UIImageView *)photo frame].size.height)];
    tempImg.contentMode = UIViewContentModeScaleAspectFill;
    [tempImg setImage:[(UIImageView *)photo image]];
    browser.entranceImg = tempImg;
    browser.entranceImg.clipsToBounds = YES;

    [browser.entranceImg setFrame:[(UIImageView *)photo frame]];
    
    [self presentViewController:browser animated:NO completion:nil];

}

-(BOOL)shouldAutorotate
{
    return NO;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"timelineCell";
    FBGTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (![cell configured])
    {
        [cell initTimelineCell];
    }
    
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", indexPath.row]];
    cell.photoView.image = img;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}


@end
