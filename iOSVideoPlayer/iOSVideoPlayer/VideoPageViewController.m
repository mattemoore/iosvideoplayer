//
//  VideoDetailViewController.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-28.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "VideoPageViewController.h"
#import "RootViewController.h"
#import "VideoView.h"
#import "Video.h"

#define kNumberOfVideosPerPage 4

@implementation VideoPageViewController

@synthesize videos = __videos;
@synthesize videoView1 = __videoView1;
@synthesize videoView2 = __videoVIew2;
@synthesize videoView3 = __videoView3;
@synthesize videoView4 = __videoVIew4;

- (id)initWithVideos:(NSArray*)videos
{
    self = [super initWithNibName:@"VideoPageViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.videos = videos;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    for (int i = 0; i < kNumberOfVideosPerPage; i++)
    {
        VideoView *videoView = [self valueForKey:[NSString stringWithFormat:@"videoView%d", i+1]];
        if (i < self.videos.count)
        {
            Video *video = (Video*)[self.videos objectAtIndex:i];
            videoView.titleLabel.text = video.Title;
            videoView.summaryLabel.text = video.Description;
        }
        else
        {
            [videoView removeFromSuperview];
        }
        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
