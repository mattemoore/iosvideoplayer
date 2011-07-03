//
//  VideoDetailViewController.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-28.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "VideoPageViewController.h"

@implementation VideoPageViewController

- (id)initWithVideos:(NSArray*)videos
{
    self = [super initWithNibName:@"VideoPageViewController" bundle:nil];
    if (self) {
        
        //TODO: init with video entity array passed in to create VideoViews...
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
