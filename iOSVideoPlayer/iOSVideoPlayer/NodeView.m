//
//  NodeView.m
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-26.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import "NodeView.h"
#import "TimeView.h"
#import <QuartzCore/QuartzCore.h>

#define BORDER_WIDTH 1.0

@implementation NodeView

@synthesize maxDetailLevel, thumbnail, screenshot, playButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self.maxDetailLevel = 1; 
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    return self;
}

-(void)displayDetailLevel:(int)detailLevel
{
    
    if (self.thumbnail == nil)
    {
        NSArray *nodeInfo = [((TimeView*)self.superview).videos objectAtIndex:self.tag];
        NSString *thumbnailImage =  [nodeInfo objectAtIndex:1];
        NSString *screenshotImage = [nodeInfo objectAtIndex:2];
        self.thumbnail = [[UIImageView alloc] initWithImage:[UIImage imageNamed:thumbnailImage]];  
        self.screenshot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:screenshotImage]];
        self.playButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"playbutton.png"]];
        self.playButton.frame = CGRectMake(self.frame.size.width/2 - self.playButton.frame.size.width/2, self.frame.size.height/2 - self.playButton.frame.size.height/2, self.playButton.frame.size.width, self.playButton.frame.size.height);
        [self addSubview:thumbnail];
        [self addSubview:screenshot];
        [self.screenshot addSubview:self.playButton];
    }
    
    if (detailLevel > maxDetailLevel) return;
    
    if (detailLevel == 0)
        [self showThumbnail];
    else if (detailLevel == 1)
        [self showScreenshot];
    /*
    if (detailLevel == 0)
        self.backgroundColor = [UIColor yellowColor];
    else if (detailLevel == 1)
        self.backgroundColor = [UIColor greenColor];
    else if (detailLevel == 2)
        self.backgroundColor = [UIColor whiteColor];
    else if (detailLevel == 3)
        self.backgroundColor = [UIColor purpleColor];
    else if (detailLevel == 4)
        self.backgroundColor = [UIColor grayColor];
    else if (detailLevel == 5)
        self.backgroundColor = [UIColor brownColor];
     */
}

-(void)showThumbnail
{
    self.layer.borderWidth = 0;
    [UIView animateWithDuration:1.0 animations:^{
        self.thumbnail.alpha = 1.0;
        self.screenshot.alpha = 0.0;
    }];
}

-(void)showScreenshot
{
    self.layer.borderWidth = BORDER_WIDTH;
    [UIView animateWithDuration:1.0 animations:^{
        self.thumbnail.alpha = 0.0;
        self.screenshot.alpha = 1.0;
    }];
}

-(void)playMovie //TODO: hit detector for TimeViewViewController 
{
    
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
