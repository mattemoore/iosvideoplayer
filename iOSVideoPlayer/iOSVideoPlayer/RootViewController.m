//
//  RootViewController.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-22.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>

#import "AppDelegate.h"
#import "VideoPageViewController.h"
#import "CategoryViewController.h"
#import "VideoPlayerViewController.h"
#import "RootViewController.h"

#import "Video.h"
#import "VideoCategory.h"

#import "YoutubeConnection.h"

#define kNumberOfVideosPerPage 4
#define kNumberOfTestCategories 3

@implementation RootViewController

@synthesize managedObjectContext = __managedObjectContext;
@synthesize masterScrollView = __masterScrollView;
@synthesize detailScrollView = __detailScrollView;
@synthesize masterViewControllers = __masterViewControllers;
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
    self.detailScrollView.scrollsToTop = NO; 
    self.masterScrollView.scrollsToTop = NO;
    
    //TODO: load old videos from store
    //          get updated list from network
    //              compare two lists, add (set isNew) and remove as necessary, update exisiting (keep isRead)
    //do fetch requests to get all categories and put in categories array
    //do fetch request for all videos in each category and put in each index of videos array
    //NSArray *savedVideos = [self loadVideoEntities];
    //[self loadTestData];
    [self loadYoutubeVideos];
    
    //setup master scroll view, content fully preloaded as master view pages are not complex
    numMasterPages = self.categories.count;
    currentMasterPageNum = 0;
    self.masterPageControl.numberOfPages = numMasterPages;
    self.masterPageControl.currentPage = 0;
    self.masterViewControllers = [self loadMasterViewControllers];  
    [self initMasterScrollView];
    
    //setup detail scroll view, lazy loading after each page turn
    self.detailViewControllers = [[NSMutableArray alloc] init];
    numDetailPages = [self getNumberOfDetailPages];
    [self setDetailPageToZero];
    
    isManualScroll = YES;
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

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self handleRotate];
}

#pragma mark - Scroll View Handling

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    //TODO: there is a bug when you switch from portrait to landscape on the last masterpage
    //      seems that a call gets in here before didRotate... thus isManualScroll is YES
    //      pageWidth is 1024 but the contentOffset.x is from the portrait setup so pageNum is set wrong
    //      e.g. (from 2 to 1 if numMasterPages is 2)
    //      probably due to stretching horizontally the master scroll view when it is at 'last page'
    //      need to trap this occurence and break out of this method
    
    if (!isManualScroll) return;
    
    CGFloat pageWidth = self.masterScrollView.frame.size.width;
    int pageNum = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if ([sender isEqual:self.masterScrollView])
    {
        currentMasterPageNum = pageNum;
        self.masterPageControl.currentPage = pageNum;
        numDetailPages = [self getNumberOfDetailPages];
        [self setDetailPageToZero];
    }
    else 
    {
        currentDetailPageNum = pageNum;
        self.detailPageControl.currentPage = pageNum;
        [self loadDetailPageNumber:pageNum+1];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    isManualScroll = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    isManualScroll = YES;
}

- (void)handleRotate
{
    isManualScroll = NO;  
    [self initMasterScrollView];
    [self initDetailScrollView];
    [self loadDetailPageNumber:currentDetailPageNum];
    [self loadDetailPageNumber:currentDetailPageNum + 1];
    [self loadDetailPageNumber:currentDetailPageNum - 1];
}

- (void)setDetailPageToZero
{
    self.detailPageControl.currentPage = 0;
    self.detailPageControl.numberOfPages = numDetailPages;
    currentDetailPageNum = 0;
    [self initDetailScrollView];  
    [self loadDetailPageNumber:0];
    [self loadDetailPageNumber:1];
}

- (int)getNumberOfDetailPages 
{
    return ceil((float)[[self.videos objectAtIndex:currentMasterPageNum] count] / (float)kNumberOfVideosPerPage);
}

//init categories and then call this to load categories into master view controllers
- (NSMutableArray *)loadMasterViewControllers {
    
    NSMutableArray *categoryViewControllers = [[NSMutableArray alloc] init];
    
    for (int i=0; i < self.categories.count ; i++) 
    {   
        VideoCategory *category = (VideoCategory*)[self.categories objectAtIndex:i];
        NSString *currentLabel = category.Name;
        
        NSString *previousLabel = nil;
        if (i > 0) 
        {
            VideoCategory *previousCategory = [self.categories objectAtIndex:i - 1];
            previousLabel = previousCategory.Name;
        }        
        
        NSString *nextLabel = nil;
        if (i < self.categories.count - 1)
        {
            VideoCategory *nextCategory = [self.categories objectAtIndex:i + 1];
            nextLabel = nextCategory.Name;
        }
        
        CategoryViewController *categoryViewController = [[CategoryViewController alloc] initWithCategory:currentLabel nextCategory:nextLabel previousCategory:previousLabel];
        [categoryViewControllers addObject:categoryViewController];
    }
    
    return categoryViewControllers;
}

//set numberOfMasterPages first and then call this to reset master scroll
-(void) initMasterScrollView 
{
    self.masterScrollView.contentSize = CGSizeMake(numMasterPages * self.masterScrollView.frame.size.width, self.masterScrollView.frame.size.height);
   
    for (int i = 0; i < numMasterPages; i++) {
        CGRect frame = self.masterScrollView.frame;
        frame.origin.x = frame.size.width * i;
        frame.origin.y = 0;
        self.masterScrollView.contentOffset = CGPointMake(frame.size.width * currentMasterPageNum, 0);
        CategoryViewController *categoryViewController = [self.masterViewControllers objectAtIndex:i];
        categoryViewController.view.frame = frame;
        [self.masterScrollView addSubview:categoryViewController.view];
    }
}

//set currentMasterPageNum and numDetailPages first and then call this to reset detail scroll view
- (void)initDetailScrollView
{
    self.detailViewControllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < numDetailPages; i++) {
        [self.detailViewControllers addObject:[NSNull null]];
    }
    
    self.detailScrollView.contentSize = CGSizeMake(numDetailPages * self.detailScrollView.frame.size.width, self.detailScrollView.frame.size.height);
    self.detailScrollView.contentOffset = CGPointMake(self.detailScrollView.frame.size.width * currentDetailPageNum,0);
}


//set currentMasterPageNum and numDetailPages first and then call this to load a detail page
-(void)loadDetailPageNumber:(int)detailPageNum 
{
    if (detailPageNum < 0)
        return;
    if (detailPageNum >= numDetailPages)
        return;
    
    VideoPageViewController *videoPage = [self.detailViewControllers objectAtIndex:detailPageNum];
    
    if ((NSNull *)videoPage == [NSNull null])
    {
        NSArray *videosForCurrentMasterPage = [self.videos objectAtIndex:currentMasterPageNum];
        int numVideosForCurrentMasterPage = [videosForCurrentMasterPage count];
        
        NSInteger lengthOfRange = MIN(kNumberOfVideosPerPage, numVideosForCurrentMasterPage - (detailPageNum * kNumberOfVideosPerPage));
        NSRange rangeOfVideos = NSMakeRange(detailPageNum * kNumberOfVideosPerPage, lengthOfRange);
        NSIndexSet *videosToInit = [NSIndexSet indexSetWithIndexesInRange:rangeOfVideos];
        
        videoPage = [[VideoPageViewController alloc] initWithVideos:[videosForCurrentMasterPage objectsAtIndexes:videosToInit]];
        videoPage.rootViewController = self;
        [self.detailViewControllers replaceObjectAtIndex:detailPageNum withObject:videoPage];
    }

    if (videoPage.view.superview == nil)
    {
        CGRect frame = self.detailScrollView.frame;
        frame.origin.x = frame.size.width * detailPageNum;
        frame.origin.y = 0;
        videoPage.view.frame = frame;
        [self.detailScrollView addSubview:videoPage.view];
    }
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
        //TODO: show error actions sheet
    
    return results;
}

-(NSArray*)loadYoutubeVideos
{
    YoutubeConnection *yconn = [[YoutubeConnection alloc] init];
    
    
    /*
    YoutubeFetcher *fetcher = [[YoutubeFetcher alloc] init];
    [fetcher fetch]
    
    if (!fetcher.isSuccess)
    {
        //TODO: show error actions sheet
        NSLog(@"%@", fetcher.error.description);
    }
    else
    {
        return fetcher.videos;
    }
     */
    return nil;
}

//TODO: write method that invokes YoutubeBridge to get list of current videos

//TODO: write method that compares saved list of vids to newly retrieved list of vids to mark
//      which ones are new, watched etc.

-(void)loadTestData
{
    NSMutableArray *testCategories = [[NSMutableArray alloc] init];
    NSMutableArray *testVideos = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < kNumberOfTestCategories; i++) 
    {   
        NSString *categoryTitle = [NSString stringWithFormat:@"Category%d",i];
        VideoCategory *videoCategory = [NSEntityDescription insertNewObjectForEntityForName:@"VideoCategory" inManagedObjectContext:self.managedObjectContext];
        videoCategory.Name = categoryTitle;
        [testCategories addObject:videoCategory];
        
        NSMutableArray *testVideosForThisCategory = [[NSMutableArray alloc] init];
        for(int y=0; y < (i + 1) * 3; y++)
        {
            Video *testVideo = (Video*)[NSEntityDescription insertNewObjectForEntityForName:@"Video" inManagedObjectContext:self.managedObjectContext];
            testVideo.Title = [NSString stringWithFormat:@"T%d-%@", y, categoryTitle];
            testVideo.Description = @"Test description..."; 
            [testVideosForThisCategory addObject:testVideo];
        }     
        [testVideos addObject:testVideosForThisCategory];
    }
    
    self.categories = [[NSArray alloc] initWithArray:testCategories];
    self.videos = [[NSArray alloc] initWithArray:testVideos];
}

@end
