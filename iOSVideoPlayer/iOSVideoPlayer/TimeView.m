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

@synthesize maxDetailLevel, currentDetailLevel, videos, delegate;

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
    for (id view in self.subviews)
    {
        if ([view isKindOfClass:[NodeView class]])
        {
            UITapGestureRecognizer *oneFingerTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOneFingerTap:)];
            [(UIView*) view addGestureRecognizer:oneFingerTapGestureRecognizer];
            
            UITapGestureRecognizer *twoFingerTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
            twoFingerTapGestureRecognizer.numberOfTouchesRequired = 2;
            [(UIView*) view addGestureRecognizer:twoFingerTapGestureRecognizer];
        }
    }
}

- (void)handleOneFingerTap:(UITapGestureRecognizer *)sender 
{     
    if (sender.state == UIGestureRecognizerStateEnded)     
    {   
        CGPoint pointOfTap = [sender locationInView:self];
        UIView *viewThatWasTapped = [self hitTest:pointOfTap withEvent:nil];
        
        //play or zoom
        if ([viewThatWasTapped isKindOfClass:[NodeView class]])
        {
            NodeView *nodeView = (NodeView*)viewThatWasTapped;
            CGPoint pointOfTapInNodeView = [self convertPoint:pointOfTap toView:nodeView];
            CGRect rectOfTapInNodeView = CGRectMake(pointOfTapInNodeView.x, pointOfTapInNodeView.y,1,1);
            
            //TODO:refactor each of these blocks into functions
            if (self.maxDetailLevel == self.currentDetailLevel)
            {   
                if (CGRectIntersectsRect(nodeView.playButton.frame, rectOfTapInNodeView))            
                {
                    NSString *youtubeId = [[self.videos objectAtIndex:nodeView.tag] objectAtIndex:0];
                    [delegate showVideoWithYoutubeId:youtubeId];
                }
                else
                {
                    //TODO: this should be done by delegate, lazy
                     TimeScrollView *timeScrollView = (TimeScrollView*)self.superview;
                    [timeScrollView setZoomScale:timeScrollView.zoomScale/2 animated:YES]; 
                }
                
            }
            else
            {
                //TODO: this should be done by delegate, lazy
                [(TimeScrollView*)self.superview zoomToRect:viewThatWasTapped.frame animated:YES]; 
            }
        }
            
    } 
}

-(void)handleTwoFingerTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)     
    {   
        CGPoint pointOfTap = [sender locationInView:self];
        UIView *viewThatWasTapped = [self hitTest:pointOfTap withEvent:nil];
        
        //play or zoom
        if ([viewThatWasTapped isKindOfClass:[NodeView class]]  && self.maxDetailLevel == self.currentDetailLevel)
        {
            //TODO: this should be done by delegate, lazy
            TimeScrollView *timeScrollView = (TimeScrollView*)self.superview;
            NodeView *nextView = nil;
            for (UIView *view in self.subviews)
            {
                if ([view isKindOfClass:[NodeView class]] && (view.tag == viewThatWasTapped.tag + 1))
                    nextView = (NodeView*)view;
            }
            if (nextView == nil)
            {
                for (UIView *view in self.subviews)
                {
                    if ([view isKindOfClass:[NodeView class]] && (view.tag == 0))
                        nextView = (NodeView*)view;
                }
            }
            if (nextView != nil)
                [timeScrollView zoomToRect:nextView.frame animated:YES];
        }
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
