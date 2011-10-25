//
//  TimeView.m
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-22.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import "TimeView.h"
#import "TimeScrollView.h"

@implementation TimeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) initGestureRecognizers
{
        
    for (id view in self.subviews)
    {
        //TODO: only hook up node views for clicks
        //if ([view isKindOfClass:[NodeView class]])
        //{
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];

        [(UIView*) view addGestureRecognizer:tapGestureRecognizer];
        //}
    }
}

- (void)handleTap:(UITapGestureRecognizer *)sender 
{     
    if (sender.state == UIGestureRecognizerStateEnded)     
    {         // handling code     
        CGPoint pointInTimeView = [sender locationInView:self];
        UIView *viewThatWasTapped = [self hitTest:pointInTimeView withEvent:nil];
        //TODO: node views only
        //if ([viewThatWasTapped isKindOfClass:[UIView class]])
        //{
        [(TimeScrollView*)self.superview zoomToRect:viewThatWasTapped.frame animated:YES];
        //}
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
