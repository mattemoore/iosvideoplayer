//
//  TimeViewController.m
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-22.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import "TimeViewController.h"
#import "TimeView.h"

@implementation TimeViewController

@synthesize timeScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    
    NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:@"TimeView" owner:self options:nil];
    TimeView *timeView;
    for (id object in bundle)
    {
        if ([object isKindOfClass:[TimeView class]])
            timeView = (TimeView*)object;
    }
    [timeScrollView setTimeView:timeView];
    timeScrollView.delegate = timeScrollView;
    timeScrollView.contentSize = timeView.frame.size;
    timeScrollView.scrollEnabled = YES;
    timeScrollView.bouncesZoom = YES;
    
    //TODO: set initial zoom to show all of timeView, 
    //this should be minimum zoom scale too
    
    //TODO: max scale should be set that max zoom is where a a node fills screen
    
    timeScrollView.zoomScale = 1.0f;
    timeScrollView.maximumZoomScale = 5.0f;
    timeScrollView.minimumZoomScale = 0.5f;
    
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
