//
//  VideoThumbnailView.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-28.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewView : UIView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *summaryLabel;
@property (strong, nonatomic) UIImageView *thumbnailImage;
@property (strong, nonatomic) UIImageView *playButtonOverlayImage;

@end
