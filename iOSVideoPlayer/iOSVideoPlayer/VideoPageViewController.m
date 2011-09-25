//
//  VideoDetailViewController.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-28.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "VideoPageViewController.h"
#import "RootViewController.h"
#import "VideoThumbnailView.h"
#import "Video.h"
#import "VideoPlayerViewController.h"

#define kNumberOfVideosPerPage 4

@implementation VideoPageViewController

@synthesize videos = __videos;
@synthesize videoView1 = __videoView1;
@synthesize videoView2 = __videoView2;
@synthesize videoView3 = __videoView3;
@synthesize videoView4 = __videoView4;
@synthesize tapGestureRecognizer = __tapGestureRecognizer;
@synthesize rootViewController = __rootViewController;

- (id)initWithVideos:(NSArray*)videos
{
    self = [super initWithNibName:@"VideoPageViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.videos = videos;
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self.view addGestureRecognizer:self.tapGestureRecognizer];
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
        VideoThumbnailView *videoView = [self valueForKey:[NSString stringWithFormat:@"videoView%d", i+1]];
         
        if (i < self.videos.count)
        {
            Video *video = (Video*)[self.videos objectAtIndex:i];
            videoView.titleLabel.text = video.Title;
            videoView.summaryLabel.text = video.Description;
            
            NSMutableDictionary *customData = [[NSMutableDictionary alloc] init];
            [customData setObject:videoView forKey:@"view"];
            HttpFetcher *httpFetcher = [[HttpFetcher alloc] initWithUrl:video.ThumbnailURL userObject:customData];
            httpFetcher.delegate = self;
            [httpFetcher fetch];
        }
        else
        {
            [videoView removeFromSuperview];
        }
    }
}

- (IBAction)handleTapGesture:(UIGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)  
    { 
        for (int i = 0; i < self.videos.count; i++)
        {
            VideoThumbnailView *videoView = [self valueForKey:[NSString stringWithFormat:@"videoView%d", i+1]];
            CGPoint tapLocation = [sender locationInView:self.view];
            if (CGRectIntersectsRect(videoView.frame, CGRectMake(tapLocation.x, tapLocation.y, 1, 1)))
            {
                VideoPlayerViewController *player = [[VideoPlayerViewController alloc] initWithVideo:[self.videos objectAtIndex:i]];
                player.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                player.modalPresentationStyle = UIModalPresentationCurrentContext;
                player.rootViewController = self.rootViewController;
                [player.rootViewController presentViewController:player animated:YES completion:NULL];
            }
        }
    }
    
}

-(void)finishedFetcher:(NSData*)data userObject:(NSDictionary*)userObject withError:(NSError*)error
{
    if (error)
    {
        //TODO: display error message
    }
    else
    {
        VideoThumbnailView *videoView = [userObject objectForKey:@"view"];
        videoView.videoScreenshot.image = [[UIImage alloc] initWithData:data];
        videoView.titleLabel.text = @"foo";
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
