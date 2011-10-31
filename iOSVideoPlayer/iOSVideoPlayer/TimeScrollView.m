//
//  TimeScrollView.m
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-23.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import "TimeScrollView.h"
#import "TimeView.h"
#import "NodeView.h"

@implementation TimeScrollView
    
@dynamic timeView;
@synthesize maxDetailLevel, currentDetailLevel, detailZoomStep;


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return timeView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    [self updateCurrentDetailLevel];
}

- (void)updateCurrentDetailLevel
{
    
    //TODO: is zoomScale linear, i.e. is is same amount of "zoom" to get to detail level 1
    //as it is to get to from detail level n-1 to n?  Doesn't "feel" that way in the simulator
    currentDetailLevel = (([self zoomScale] - [self minimumZoomScale]) / detailZoomStep);
    NSLog(@"Zoom Scale = %f", [self zoomScale]);
    NSLog(@"Zoom Min   = %f", [self minimumZoomScale]);
    NSLog(@"Z delta min= %f", [self zoomScale] - [self minimumZoomScale]);
    NSLog(@"Zoom Max   = %f", [self maximumZoomScale]);
    NSLog(@"Num steps  = %d", self.maxDetailLevel + 1);
    NSLog(@"Zoom Step  = %f", detailZoomStep);
    NSLog(@"Detail Lvl = %d", currentDetailLevel);
    NSLog(@"------------------------------------");
    
    for (id view in timeView.subviews)
    {
        if ([view isKindOfClass:[NodeView class]])
           [(NodeView*)view displayDetailLevel:currentDetailLevel];
    }
}

- (void) setTimeView:(TimeView*)theTimeView
{
    timeView = theTimeView;
    [self addSubview:timeView];
    [timeView initGestureRecognizers];
}

- (TimeView *) timeView
{
    return timeView;
}

@end
