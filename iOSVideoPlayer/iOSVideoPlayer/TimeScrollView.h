//
//  TimeScrollView.h
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-23.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeView.h"

@interface TimeScrollView : UIScrollView <UIScrollViewDelegate>
{
    TimeView *timeView;
}

@property (nonatomic, assign) TimeView *timeView;
@property (nonatomic, assign) int maxDetailLevel;
@property (nonatomic, assign) int currentDetailLevel;
@property (nonatomic, assign) float detailZoomStep;


- (void)updateCurrentDetailLevel;



@end
