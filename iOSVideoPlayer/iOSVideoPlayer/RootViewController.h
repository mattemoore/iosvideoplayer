//
//  iOSVideoPlayerViewController.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-22.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserUploadsFetcher.h"

@interface RootViewController : UIViewController <UIScrollViewDelegate, UserUploadsFetcherDelegate>
{
    unsigned numMasterPages;
    unsigned numDetailPages;
    unsigned currentMasterPageNum;
    unsigned currentDetailPageNum;
    bool isManualScroll;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UIScrollView *masterScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *detailScrollView;
@property (strong, nonatomic) NSArray *masterViewControllers;
@property (strong, nonatomic) NSMutableArray *detailViewControllers;

@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSArray *savedVideos;
@property (strong, nonatomic) NSArray *videos; //array of video array that index to categories array

@property (strong, nonatomic) IBOutlet UIPageControl *masterPageControl;
@property (strong, nonatomic) IBOutlet UIPageControl *detailPageControl;
@property (strong, nonatomic) IBOutlet UIView *masterPageControlView;
@property (strong, nonatomic) IBOutlet UIView *detailPageControlView;

-(void)initScrollViews;
-(void)initDetailScrollView;
-(void)initMasterScrollView;
-(void)handleRotate;

-(NSMutableArray *)loadMasterViewControllers;

-(int)getNumberOfDetailPages; 
-(void)setDetailPageToZero;
-(void)loadDetailPageNumber:(int)detailPageNum;

-(NSArray*)loadSavedVideos;
-(void)mergeVideos:(NSArray*)newVideos:(NSArray*)savedVideos;

-(void)loadTestData;



@end
