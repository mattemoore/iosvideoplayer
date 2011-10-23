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
    //TODO: delegate is self to handle zoom
    //TODO: contain instace of TimeView
    //TODO: hook up TimeView as viewForZooming
    //TODO: handle zooming 
    //TODO: handle layoutSubviews to remove views to add view
    //TODO: handle 'rezolution' changes where content of TimeView is changed
    
    TimeView *timeView;
    
}

@property (nonatomic, assign) TimeView *timeView;


@end
