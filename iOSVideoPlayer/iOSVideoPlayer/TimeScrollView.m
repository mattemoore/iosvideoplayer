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



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return timeView;
}

- (void) setTimeView:(TimeView*)theTimeView
{
    timeView = theTimeView;
    [self addSubview:timeView];
}

@end
