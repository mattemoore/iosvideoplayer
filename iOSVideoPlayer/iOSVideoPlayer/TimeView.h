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
@property (nonatomic, assign) int maxDetailLevel;
@property (nonatomic, assign) int currentDetailLevel;
@property (nonatomic, strong) NSArray *videos;

- (void) initGestureRecognizers;
- (void)handleTap:(UITapGestureRecognizer *)sender;
- (void)updateCurrentDetailLevel:(int)newDetailLevel;

@end
