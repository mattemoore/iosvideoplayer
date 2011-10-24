//
//  TimeScrollView.m
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-23.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import "TimeScrollView.h"
#import "TimeView.h"

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
    currentDetailLevel = ([self zoomScale] / detailZoomStep) - 1;
    
    //TODO: to be done by node view
    for (id view in timeView.subviews)
    {
        UIView *theView = (UIView*)view;
        
        if (currentDetailLevel == 0)
            theView.backgroundColor = [UIColor blackColor];
        else if (currentDetailLevel == 1)
            theView.backgroundColor = [UIColor greenColor];
        else if (currentDetailLevel == 2)
            theView.backgroundColor = [UIColor redColor];
        else if (currentDetailLevel == 3)
            theView.backgroundColor = [UIColor purpleColor];
        else if (currentDetailLevel == 4)
            theView.backgroundColor = [UIColor blueColor];
    }
}

- (void) setTimeView:(TimeView*)theTimeView
{
    timeView = theTimeView;
    [self addSubview:timeView];
}

- (TimeView *) timeView
{
    return timeView;
}

@end
