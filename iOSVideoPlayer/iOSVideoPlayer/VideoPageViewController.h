//
//  VideoDetailViewController.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-28.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoThumbnailView.h"

@interface VideoPageViewController : UIViewController

@property (nonatomic, strong) NSArray* videos;
@property (nonatomic, strong) IBOutlet VideoThumbnailView* videoView1;
@property (nonatomic, strong) IBOutlet VideoThumbnailView* videoView2;
@property (nonatomic, strong) IBOutlet VideoThumbnailView* videoView3;
@property (nonatomic, strong) IBOutlet VideoThumbnailView* videoView4;


-(id)initWithVideos:(NSArray*)videos;
-(void)zoomVideo: (VideoThumbnailView *)videoView;
-(void)addVideoToQueue: (VideoThumbnailView*)videoView;
-(void)playVideo: (VideoThumbnailView*)videoView;


@end
