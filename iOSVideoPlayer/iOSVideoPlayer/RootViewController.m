//
//  iOSVideoPlayerViewController.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-22.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"

@implementation RootViewController

@synthesize managedObjectContext = __managedObjectContext;
@synthesize masterScrollView = __masterScrollView;
@synthesize detailScrollView = __detailScrollView;
@synthesize detailViewControllers = __detailViewControllers;
@synthesize masterPageControl = __masterPageControl;
@synthesize detailPageControl = __detailPageControl;
@synthesize masterPageControlView = __masterPageControlView;
@synthesize detailPageControlView = __detailPageControlView;

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
    
    //TODO: singleton settings class that loads from .plist
    
    //TODO: load data from last viewing so user can use app right away
    //          add new stuff, remove old stuff, change updated stuff
    //              fill in text data, load thumbnails async
    //
    
    
    //TODO: create uiview in nib for queue, non-scrollable
    
    
    numMasterPages = 5;
    //TODO: fill array of videopageview controllers (null to start)
        //load them when needed and pass in data from model to videodetail
    
    //TODO: factor out the resetting of detail view controller array and detailviewscrollview
    //          so that it may be called in init as well as a masterscrollview event
    
    self.detailViewControllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < numMasterPages; i++) {
        [self.detailViewControllers addObject:[NSNull null]];
    }
    
    
    self.masterPageControl.numberOfPages = numMasterPages;
    self.masterPageControl.currentPage = 0;
    self.detailPageControl.numberOfPages = numDetailPages;
    self.detailPageControl.currentPage = 0;
    
    self.masterScrollView.contentSize = CGSizeMake(numMasterPages * self.masterScrollView.frame.size.width, self.masterScrollView.frame.size.height);
    self.masterScrollView.scrollsToTop = NO;
    
    self.detailScrollView.contentSize = CGSizeMake(numDetailPages * self.detailScrollView.frame.size.width, self.detailScrollView.frame.size.height);
    self.detailScrollView.scrollsToTop = NO;
    
    //TODO: load page 1 and page 2
    //[self.loadVideoPage:...
    
    testDetailPages = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:4],[NSNumber numberWithInt:5],nil];
    
    numDetailPages = [[testDetailPages objectAtIndex:0] integerValue];
    
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


#pragma mark - Orientation Handling

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


#pragma mark - Scroll View Handling

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.masterScrollView.frame.size.width;
    int pageNum = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if ([sender isEqual:self.masterScrollView])
    {
        self.masterPageControl.currentPage = pageNum;
        numDetailPages = [[testDetailPages objectAtIndex:pageNum] integerValue];
        self.detailPageControl.numberOfPages = numDetailPages;
        self.detailPageControl.currentPage = 0;
        self.detailScrollView.contentSize = CGSizeMake(numDetailPages * self.detailScrollView.frame.size.width, self.detailScrollView.frame.size.height);
        self.detailScrollView.contentOffset = CGPointMake(0,0);
    }
    else 
        self.detailPageControl.currentPage = pageNum;
    
    //TODO: load -1 and +1 pages
}

-(void)loadVideoPage:(NSArray *)videos
{
    
    
}


@end
