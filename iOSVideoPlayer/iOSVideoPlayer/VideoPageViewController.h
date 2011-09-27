//
//  VideoDetailViewController.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-28.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoThumbnailView.h"
#import "RootViewController.h"
#import "HttpFetcher.h"

@interface VideoPageViewController : UIViewController <HttpFetcherDelegate>

@property (nonatomic, strong) NSArray* videos;
@property (nonatomic, strong) IBOutlet VideoThumbnailView* videoView1;
@property (nonatomic, strong) IBOutlet VideoThumbnailView* videoView2;
@property (nonatomic, strong) IBOutlet VideoThumbnailView* videoView3;
@property (nonatomic, strong) IBOutlet VideoThumbnailView* videoView4;
@property (nonatomic, strong) UITapGestureRecognizer* tapGestureRecognizer;
@property (nonatomic, strong) RootViewController* rootViewController;

-(id)initWithVideos:(NSArray*)videos;
-(IBAction)hanldeTapGesture:(UITapGestureRecognizer *)sender;


@end
