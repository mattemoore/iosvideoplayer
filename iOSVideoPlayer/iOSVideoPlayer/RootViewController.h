//
//  iOSVideoPlayerViewController.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-22.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIScrollViewDelegate>
{
    unsigned numMasterPages;
    unsigned numDetailPages;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UIScrollView *masterScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *detailScrollView;
@property (strong, nonatomic) NSMutableArray *detailViewControllers;
@property (strong, nonatomic) IBOutlet UIPageControl *masterPageControl;
@property (strong, nonatomic) IBOutlet UIPageControl *detailPageControl;
@property (strong, nonatomic) IBOutlet UIView *masterPageControlView;
@property (strong, nonatomic) IBOutlet UIView *detailPageControlView;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSArray *videos; //array of video array that index to categories array

-(void)loadVideoPage:(int)pageNumber;
-(NSArray*)loadVideoEntities;
-(void)loadTestData;

@end
