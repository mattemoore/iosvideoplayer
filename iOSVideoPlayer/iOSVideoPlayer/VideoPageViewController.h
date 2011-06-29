//
//  VideoDetailViewController.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-28.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoView.h"

@interface VideoPageViewController : UIViewController

-(void)zoomVideo: (VideoView *)videoView;
-(void)addVideoToQueue: (VideoView*)videoView;
-(void)playVideo: (VideoView*)videoView;


@end
