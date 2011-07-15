//
//  VideoThumbnailView.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-28.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoView : UIView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *summaryLabel;
@property (strong, nonatomic) UIImageView *videoScreenshot;
@property (strong, nonatomic) UIImageView *playButtonOverlayImage;
@property (strong, nonatomic, getter = getNewVideoImage) UIImageView *newVideoImage;
@property (strong, nonatomic) UIImageView *watchedVideoImage;

- (void)drawBorders;

@end
