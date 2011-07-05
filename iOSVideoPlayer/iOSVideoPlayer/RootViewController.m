//
//  RootViewController.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-22.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Video.h"
#import "VideoCategory.h"
#import "VideoPageViewController.h"

#define kNumberOfVideosPerPage 1

@implementation RootViewController

@synthesize managedObjectContext = __managedObjectContext;
@synthesize masterScrollView = __masterScrollView;
@synthesize detailScrollView = __detailScrollView;
@synthesize detailViewControllers = __detailViewControllers;
@synthesize masterPageControl = __masterPageControl;
@synthesize detailPageControl = __detailPageControl;
@synthesize masterPageControlView = __masterPageControlView;
@synthesize detailPageControlView = __detailPageControlView;
@synthesize categories = __categories;
@synthesize videos = __videos;

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
    
    
    //TODO: load old videos from store
    //          get updated list from network
    //              compare two lists, add (set isNew) and remove as necessary, update exisiting (keep isRead)
    //do fetch requests to get all categories and put in categories array
    //do fetch request for all videos in each category and put in each index of videos array
    
    NSArray *savedVideos = [self loadVideoEntities];
    
    [self loadTestData];
    
    numMasterPages = self.categories.count;
    
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
    
    [self loadVideoPage:0];
    [self loadVideoPage:1];
    numDetailPages = [[self.videos objectAtIndex:0] count] / kNumberOfVideosPerPage;
    
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
        numDetailPages = [[self.videos objectAtIndex:pageNum] count] / kNumberOfVideosPerPage;;
        self.detailPageControl.numberOfPages = numDetailPages;
        self.detailPageControl.currentPage = 0;
        self.detailScrollView.contentSize = CGSizeMake(numDetailPages * self.detailScrollView.frame.size.width, self.detailScrollView.frame.size.height);
        self.detailScrollView.contentOffset = CGPointMake(0,0);
    }
    else 
        self.detailPageControl.currentPage = pageNum;
    
    [self loadVideoPage:pageNum + 1];
}

-(void)loadVideoPage:(int)pageNumber
{
    VideoPageViewController *videoPage = [self.detailViewControllers objectAtIndex:pageNumber];
    if (videoPage == nil)
    {
        videoPage = [[VideoPageViewController alloc] initWithVideos:[self.videos objectAtIndex:pageNumber]];
        [self.detailViewControllers replaceObjectAtIndex:pageNumber withObject:videoPage];
    }

    //if (videoPage.view.superview == nil)
    //{
        CGRect frame = self.detailScrollView.frame;
        frame.origin.x = frame.size.width * pageNumber;
        frame.origin.y = 0;
        videoPage.view.frame = frame;
        [self.detailScrollView addSubview:videoPage.view];
    //}
}

#pragma mark - Core Data Calls

-(NSArray*)loadVideoEntities {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Video" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entityDescription;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Title like[cd] '*'"];
    fetchRequest.predicate = predicate;
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (results == nil)
        NSLog(@"%@", error.description);
    return results;
}

-(void)loadTestData
{
    self.categories = [[NSArray alloc] initWithObjects:@"Category1", @"Category2", @"Category3", nil];
    
    Video *testVideo = (Video*)[NSEntityDescription insertNewObjectForEntityForName:@"Video" inManagedObjectContext:self.managedObjectContext];
    testVideo.Title = @"Test Title";
    testVideo.Description = @"Test description...";
    NSArray *category1videos = [[NSArray alloc] initWithObjects:testVideo, nil];
    NSArray *category2videos = [[NSArray alloc] initWithObjects:testVideo, testVideo, nil];
    NSArray *category3videos = [[NSArray alloc] initWithObjects:testVideo, testVideo, testVideo, nil];
    self.videos = [[NSArray alloc] initWithObjects:category1videos, category2videos, category3videos, nil];
}

@end
