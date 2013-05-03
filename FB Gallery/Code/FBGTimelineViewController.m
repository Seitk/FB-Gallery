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

#import "UIView+viewController.h"

@interface FBGTimelineViewController ()

@end

@implementation FBGTimelineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"browsePhoto"])
    {
        FBGPhotoBrowserViewController *pbVC = [segue destinationViewController];
        pbVC.screenshot = [UIView screenshotForScreen];
        pbVC.currentPhoto = [[FBGBrowsePhotoView alloc] initWithFrame: [(UIImageView *)sender frame]];
        pbVC.currentPhoto.image = [(UIImageView *)sender image];
        pbVC.currentPhoto.timelineFrame = [(UIImageView *)sender frame];
    }
}

- (void) browsePhoto:(id)photo
{    
    [self performSegueWithIdentifier:@"browsePhoto" sender:photo];
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
    return 340;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"timelineCell";
    FBGTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (![cell configured])
    {
        [cell initTimelineCell];
    }
    
    cell.photoView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", indexPath.row]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
