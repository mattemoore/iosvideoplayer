//
//  TimeView.m
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-22.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import "TimeView.h"
#import "TimeScrollView.h"
#import "NodeView.h"

@implementation TimeView

@synthesize maxDetailLevel, currentDetailLevel, videos;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    [self initGestureRecognizers];
    self.maxDetailLevel = 1;
    self.currentDetailLevel = -1; 
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TimeViewData" ofType:@"plist"];  
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSDictionary *videoDictionary = [plist objectForKey:@"Videos"];
    self.videos = [videoDictionary objectForKey:@"FN11"];
    return self;
}

- (void) initGestureRecognizers
{       
    //TODO: tapping a node when the video is showing doesn't register
    //TODO: pinching doesn't work when 
    for (id view in self.subviews)
    {
        if ([view isKindOfClass:[NodeView class]])
        {
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];

            [(UIView*) view addGestureRecognizer:tapGestureRecognizer];
        }
    }
}

- (void)handleTap:(UITapGestureRecognizer *)sender 
{     
    if (sender.state == UIGestureRecognizerStateEnded)     
    {   
        CGPoint pointInTimeView = [sender locationInView:self];
        UIView *viewThatWasTapped = [self hitTest:pointInTimeView withEvent:nil];
        if ([viewThatWasTapped isKindOfClass:[NodeView class]])
            [(TimeScrollView*)self.superview zoomToRect:viewThatWasTapped.frame animated:YES];
    } 
}

- (void)updateCurrentDetailLevel:(int)newDetailLevel
{   
    currentDetailLevel = newDetailLevel;
    for (id view in self.subviews)
    {
        if ([view isKindOfClass:[NodeView class]])
            [(NodeView*)view displayDetailLevel:currentDetailLevel];
    }  
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
