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
    
    self.backgroundColor = [UIColor clearColor];
    
    int horizontalPadding = self.frame.size.width * 0.02;
    int verticalPadding = self.frame.size.height * 0.05;
    
    CGRect titleFrame = CGRectMake(horizontalPadding, 0, self.frame.size.width - 2 * horizontalPadding, self.frame.size.height * 0.1);
    self.titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    self.titleLabel.backgroundColor = [UIColor blackColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = UITextAlignmentCenter;
    //self.titleLabel.layer.borderColor = [UIColor redColor].CGColor;
    //self.titleLabel.layer.borderWidth = 3.0;
    
    CGRect videoFrame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + verticalPadding, self.frame.size.width, self.frame.size.height * 0.5);
    self.videoScreenshot = [[UIImageView alloc] initWithFrame:videoFrame];
    UIImage *screenshot = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"videoBackgroundPlaceholder" ofType:@"png"]];
    self.videoScreenshot.image = screenshot;
    //self.videoScreenshot.layer.borderColor = [UIColor grayColor].CGColor;
    //self.videoScreenshot.layer.borderWidth = 1.0;
    
    self.playButtonOverlayImage = [[UIImageView alloc] initWithFrame:videoFrame];
    self.playButtonOverlayImage.alpha = 0.7;
    self.playButtonOverlayImage.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *play = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"videoPlayPlaceholder" ofType:@"png"]];
    self.playButtonOverlayImage.image = play;
    
    CGRect summaryFrame = CGRectMake(horizontalPadding, CGRectGetMaxY(self.videoScreenshot.frame) + verticalPadding, self.frame.size.width - 2 * horizontalPadding, self.frame.size.height * 0.3);
    self.summaryLabel = [[UILabel alloc] initWithFrame:summaryFrame];
    self.summaryLabel.lineBreakMode = UILineBreakModeTailTruncation;
    self.summaryLabel.backgroundColor = [UIColor blackColor];
    self.summaryLabel.textColor = [UIColor whiteColor];
    //self.summaryLabel.layer.borderColor = [UIColor purpleColor].CGColor;
    //self.summaryLabel.layer.borderWidth = 3.0;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.videoScreenshot];
    [self addSubview:self.playButtonOverlayImage];
    [self addSubview:self.summaryLabel];

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
