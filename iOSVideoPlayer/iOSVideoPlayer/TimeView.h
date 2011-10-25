//
//  TimeView.h
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-22.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeView : UIView <UIGestureRecognizerDelegate>
{
    
}

- (void) initGestureRecognizers;
- (void)handleTap:(UITapGestureRecognizer *)sender;

@end
