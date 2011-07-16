//
//  VideoThumbnailView.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-06-28.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "VideoView.h"
#import <QuartzCore/QuartzCore.h>

@implementation VideoView

@synthesize titleLabel = __titleLabel;
@synthesize summaryLabel = __summaryLabel;
@synthesize videoScreenshot = __thumbnailImage;
@synthesize playButtonOverlayImage = __playButtonOverlayImage;
@synthesize newVideoImage = __newVideoImage;
@synthesize watchedVideoImage = __watchedVideoImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
    //init sections of view
    
    int horizontalPadding = self.frame.size.width * 0.02;
    int verticalPadding = self.frame.size.height * 0.05;
    
    int stateFrameHeight = self.frame.size.height * 0.05;
    int stateFrameWidth = self.frame.size.width;
    CGRect stateFrame = CGRectMake(0, 0, stateFrameWidth, stateFrameHeight);
    int stateImageWidth = stateFrame.size.width * 0.1;
    
    int titleFrameHeight = self.frame.size.height * 0.1;
    CGRect titleFrame = CGRectMake(horizontalPadding, CGRectGetMaxY(stateFrame) + verticalPadding, self.frame.size.width - 2 * horizontalPadding, titleFrameHeight);
    
    int videoFrameHeight = self.frame.size.height * 0.45;
    CGRect videoFrame = CGRectMake(0, CGRectGetMaxY(titleFrame) + verticalPadding, self.frame.size.width, videoFrameHeight);
    
    int summaryFrameHeight = self.frame.size.height * 0.25;
    CGRect summaryFrame = CGRectMake(horizontalPadding, CGRectGetMaxY(videoFrame) + verticalPadding, self.frame.size.width - 2 * horizontalPadding, summaryFrameHeight);
    
    //populate sections of view
    
    CGRect newVideoImageFrame = CGRectMake(stateFrame.size.width - stateImageWidth * 2, 0, stateImageWidth, stateFrame.size.height);  
    self.newVideoImage = [[UIImageView alloc] initWithFrame:newVideoImageFrame];
    
    CGRect watchedVideoImageFrame = CGRectMake(stateFrame.size.width - stateImageWidth * 1, 0, stateImageWidth, stateFrame.size.height);  
    self.watchedVideoImage = [[UIImageView alloc] initWithFrame:watchedVideoImageFrame];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    self.titleLabel.backgroundColor = [UIColor blackColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = UITextAlignmentCenter;
    
    self.videoScreenshot = [[UIImageView alloc] initWithFrame:videoFrame];
    UIImage *screenshot = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"videoBackgroundPlaceholder" ofType:@"png"]];
    self.videoScreenshot.image = screenshot;
    
    self.playButtonOverlayImage = [[UIImageView alloc] initWithFrame:videoFrame];
    self.playButtonOverlayImage.alpha = 0.60;
    self.playButtonOverlayImage.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *play = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"videoPlayPlaceholder" ofType:@"png"]];
    self.playButtonOverlayImage.image = play;
    
    self.summaryLabel = [[UILabel alloc] initWithFrame:summaryFrame];
    self.summaryLabel.lineBreakMode = UILineBreakModeTailTruncation;
    self.summaryLabel.backgroundColor = [UIColor blackColor];
    self.summaryLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.newVideoImage];
    [self addSubview:self.watchedVideoImage];
    [self addSubview:self.videoScreenshot];
    [self addSubview:self.playButtonOverlayImage];
    [self addSubview:self.summaryLabel];
    
#ifdef DEBUG
    [self drawBorders];
#endif
    
}

- (void)drawBorders {
    self.newVideoImage.layer.borderColor = [UIColor yellowColor].CGColor;
    self.newVideoImage.layer.borderWidth = 1.0;
    self.titleLabel.layer.borderColor = [UIColor redColor].CGColor;
    self.titleLabel.layer.borderWidth = 1.0;
    self.summaryLabel.layer.borderColor = [UIColor purpleColor].CGColor;
    self.summaryLabel.layer.borderWidth = 1.0;
    self.videoScreenshot.layer.borderColor = [UIColor grayColor].CGColor;
    self.videoScreenshot.layer.borderWidth = 1.0;
    self.watchedVideoImage.layer.borderColor = [UIColor brownColor].CGColor;
    self.watchedVideoImage.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
