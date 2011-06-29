//
//  VideoDetailViewController.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-28.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewView.h"

@interface VideoDetailViewController : UIViewController

-(void)zoomVideoThumbnail: (ViewView *)thumbnailView;
-(void)addVideoThumbnailToQueue: (ViewView*)thumbnailView;


@end
