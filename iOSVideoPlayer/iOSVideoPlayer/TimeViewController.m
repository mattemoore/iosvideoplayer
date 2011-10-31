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
    
    //TODO: load scroll dynamically rather than from TimeViewController.xib
    NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:@"TimeView" owner:self options:nil];
    TimeView *timeView;
    for (id object in bundle)
    {
        if ([object isKindOfClass:[TimeView class]])
            timeView = (TimeView*)object;
    }
    [timeScrollView setTimeView:timeView];
    timeScrollView.contentSize = timeView.frame.size;
    timeScrollView.currentDetailLevel = 0;
    timeScrollView.maxDetailLevel = 3;
    
    timeScrollView.delegate = timeScrollView;
    timeScrollView.scrollEnabled = YES;
    timeScrollView.bouncesZoom = YES;
    
    //max ZOOM OUT is show full width of view regardless of orientation
    //TODO: change to height so as to show all all root nodes instead of all children of
    //visible root nodes?
    float factor = timeScrollView.frame.size.width / timeView.frame.size.width;
    timeScrollView.minimumZoomScale = factor;
    timeScrollView.zoomScale = factor;
    
    [self setScrollViewMaxZoom];
    
}

//called to set initial max zoom as well as after rotations
- (void)setScrollViewMaxZoom
{
    //max ZOOM IN is show frame of node, dependant on orientation
    float scrollViewSizeConstraint;
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait ||
        self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        scrollViewSizeConstraint = timeScrollView.bounds.size.width;
    else
        scrollViewSizeConstraint = timeScrollView.bounds.size.height;
    
    CGSize nodeSize = CGSizeMake(300,300);  
    float factor = scrollViewSizeConstraint / nodeSize.width;
    timeScrollView.maximumZoomScale = factor;
    
    timeScrollView.detailZoomStep = (timeScrollView.maximumZoomScale - timeScrollView.minimumZoomScale)  / (timeScrollView.maxDetailLevel);
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


// Notifies when rotation begins, reaches halfway point and ends.
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    timeScrollView.contentSize = [timeScrollView timeView].frame.size;
    [self setScrollViewMaxZoom];
}

@end
