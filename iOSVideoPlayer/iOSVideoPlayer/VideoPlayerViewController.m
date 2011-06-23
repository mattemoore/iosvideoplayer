//
//  iOSVideoPlayerViewController.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-22.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "AppDelegate.h"

@implementation VideoPlayerViewController

@synthesize managedObjectContext = __managedObjectContext;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    
    //TODO: save data model
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
    
    //TODO: load data from last viewing so user can use app right away
    //          add new stuff, remove old stuff, change updated stuff
    //              fill in text data, load thumbnails async
    //
    
    //TODO: set two ui scroll views' content width to scroll view bounds width * num pages
    //          setup slave ui view to reload when master scroll view scrolls
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
