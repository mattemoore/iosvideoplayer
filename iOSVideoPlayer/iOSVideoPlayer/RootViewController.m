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
#import "UserUploadsFetcher.h"

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
@synthesize savedVideos = __savedVideos;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate saveContext];
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
    self.savedVideos = [self loadSavedVideos];
    
    //TODO:show loading screen until fetcher is done (this page)
    //TODO:show loading screen until video is loaded (VideoPlayerViewController)
    //TODO:fade in vid screenshot, check if screenshots are being async fetched
    //TODO:screenshot shouldn't be stretched in vertical mode?
    //TODO:rotate whilst video playing is not right, sized based on portrait, should resize on rotate
    
    UserUploadsFetcher *youtubeFetcher = [[UserUploadsFetcher alloc] init];
    youtubeFetcher.delegate = self;
    [youtubeFetcher connectAndParse];
    
    //[self loadTestData];
    //[self initScrollViews];
    
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

- (void)initScrollViews
{
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


//init categories and then call this to load categories into master view controllers
- (NSMutableArray *)loadMasterViewControllers {
    
    NSMutableArray *categoryViewControllers = [[NSMutableArray alloc] init];
    
    for (int i=0; i < self.categories.count ; i++) 
    {   
        NSString *currentLabel = (NSString*)[self.categories objectAtIndex:i];        
        NSString *previousLabel = nil;
        if (i > 0) 
        {
            previousLabel = (NSString*)[self.categories objectAtIndex:i - 1];
        }        
        
        NSString *nextLabel = nil;
        if (i < self.categories.count - 1)
        {
            nextLabel = (NSString*)[self.categories objectAtIndex:i + 1];        
        }
        
        CategoryViewController *categoryViewController = [[CategoryViewController alloc] initWithCategory:currentLabel nextCategory:nextLabel previousCategory:previousLabel];
        [categoryViewControllers addObject:categoryViewController];
    }
    
    return categoryViewControllers;
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

#pragma mark - Loading, Merging, Categorizing Videos...


-(void)finishedConnectAndParse:(NSArray*)rawVideos withError:(NSError*)error
{
    if (error)
    {
        NSLog(@"%@", error.description);
        return;     //TODO: show error actions sheet
    }
    
    if (rawVideos.count == 0) 
    {
        return;     //TODO: action sheet saying no videos available
    }
    
    //convert video in xml to managed objects
    NSMutableArray *managedVideos = [[NSMutableArray alloc] init];
    for(int i = 0; i < rawVideos.count; i++)
    {   
        NSDictionary *rawVideo = (NSDictionary*)[rawVideos objectAtIndex:i];
        
        Video *managedVideo = (Video*)[NSEntityDescription insertNewObjectForEntityForName:@"Video" inManagedObjectContext:self.managedObjectContext];
      
        managedVideo.Title = [rawVideo objectForKey:@"title"];
        managedVideo.Description = [rawVideo objectForKey:@"summary"];
        managedVideo.PublicID = [rawVideo objectForKey:@"id"];
        managedVideo.URL = [rawVideo objectForKey:@"url"];
        managedVideo.ThumbnailURL = [rawVideo objectForKey:@"thumbnailurl"];
        managedVideo.Categories = [rawVideo objectForKey:@"keywords"];
        [managedVideos addObject:managedVideo];
    }
    
    [self mergeVideos:managedVideos:[self loadSavedVideos]];    
    
    [self initScrollViews];
}

-(void)mergeVideos:(NSArray*) newVideos:(NSMutableArray*) savedVideos
{
    //merge
    for (int i = 0; i < newVideos.count; i++)
    {
        BOOL isDupe = false;
        Video *newVideo = (Video*)[newVideos objectAtIndex:i];
        for (int y = 0; y < savedVideos.count; y++)
        {
            Video *savedVideo = (Video*)[savedVideos objectAtIndex:y];
            if (newVideo.PublicID == savedVideo.PublicID) 
                isDupe = true;
        }
        
        if (!isDupe)
        {
            newVideo.IsNew = [NSNumber numberWithInt:1];
            newVideo.IsWatched = [NSNumber numberWithInt:0];
            [savedVideos addObject:newVideo];
        }
    }
    
    //build category list
    NSString *categoriesString = @"";
    for (int i=0; i < savedVideos.count; i++)
    {
        NSString *category = ((Video*)[savedVideos objectAtIndex:i]).Categories;
        if (!(category == @"")) 
            categoriesString = [categoriesString stringByAppendingString:category];
    }
    
    NSArray *splitCategories = [categoriesString componentsSeparatedByString:@","];
    NSMutableArray *trimmedCategories = [[NSMutableArray alloc] init];
    for (int j=0; j < splitCategories.count; j++)
    {
        [trimmedCategories addObject:[[splitCategories objectAtIndex:j] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    }
    self.categories = trimmedCategories;
    
    //build video array 
    NSMutableArray *videos = [[NSMutableArray alloc] init];
    for (int y=0; y < self.categories.count; y++)
    {
        NSString *categoryName = [self.categories objectAtIndex:y];
        NSMutableArray *videosForThisCategory = [[NSMutableArray alloc] init];
        for(int z=0; z < savedVideos.count; z++)
        {
            Video *video = [savedVideos objectAtIndex:z];
            if (!
                NSEqualRanges([video.Categories rangeOfString:categoryName], NSMakeRange(NSNotFound, 0)))
                [videosForThisCategory addObject:video];
        }
        [videos addObject:videosForThisCategory];
    }
    self.videos = videos;
    
}

-(NSArray*)loadSavedVideos {
    
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

-(void)loadTestData
{
    //TODO: put in fake url of video so we can test playing
    
    NSMutableArray *testCategories = [[NSMutableArray alloc] init];
    NSMutableArray *testVideos = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < kNumberOfTestCategories; i++) 
    {   
        NSString *categoryTitle = [NSString stringWithFormat:@"Category%d",i];
        [testCategories addObject:categoryTitle];
        
        NSMutableArray *testVideosForThisCategory = [[NSMutableArray alloc] init];
        for(int y=0; y < (i + 1) * 3; y++)
        {
            Video *testVideo = (Video*)[NSEntityDescription insertNewObjectForEntityForName:@"Video" inManagedObjectContext:self.managedObjectContext];
            testVideo.Title = [NSString stringWithFormat:@"T%d-%@", y, categoryTitle];
            testVideo.Description = @"Test description..."; 
            testVideo.ThumbnailURL = @"http://www.google.ca/images/srpr/logo3w.png";
            testVideo.PublicID = @"1HkWTfc4nFs";
            testVideo.IsNew = [NSNumber numberWithInt:1];
            testVideo.IsWatched = [NSNumber numberWithInt:1];
            [testVideosForThisCategory addObject:testVideo];
        }     
        [testVideos addObject:testVideosForThisCategory];
    }
    
    self.categories = [[NSArray alloc] initWithArray:testCategories];
    self.videos = [[NSArray alloc] initWithArray:testVideos];
}

@end
