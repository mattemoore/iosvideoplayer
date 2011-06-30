//
//  VideoThumbnailView.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-28.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "VideoView.h"

@implementation VideoView

@synthesize titleLabel = __titleLabel;
@synthesize summaryLabel = __summaryLabel;
@synthesize videoScreenshot = __thumbnailImage;
@synthesize playButtonOverlayImage = __playButtonOverlayImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * 0.1)];
        self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        self.videoScreenshot = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), frame.size.width, frame.size.height * 0.7)];
        
        self.playButtonOverlayImage = [[UIImageView alloc] initWithFrame:self.videoScreenshot.frame];
        self.playButtonOverlayImage.alpha = 0.75;
        
        self.summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.videoScreenshot.frame), frame.size.width, frame.size.height * 0.2)];
        self.summaryLabel.lineBreakMode = UILineBreakModeTailTruncation;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.videoScreenshot];
        [self addSubview:self.playButtonOverlayImage];
        [self addSubview:self.summaryLabel];
    }
    return self;
}

//TODO: handle resizing and rotating (only show long description above certain size?)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
