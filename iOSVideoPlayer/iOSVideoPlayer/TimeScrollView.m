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
#import "Math.h"

#define NODE_WIDTH 300
#define NODE_HEIGHT 300

@implementation TimeScrollView
    
@synthesize maxDetailLevel, currentDetailLevel, detailZoomStep;
@synthesize maxZoomScalePortrait, maxZoomScaleLandscape, minZoomScalePortrait, minZoomScaleLandscape, centerPreRotate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void) setTimeView:(TimeView*)theTimeView forOrientation:(UIInterfaceOrientation)orientation
{
    timeView = theTimeView;
    [self addSubview:timeView];
    self.contentSize = timeView.frame.size;
    self.currentDetailLevel = -1; 
    self.maxDetailLevel = 2; //TODO: maxDetailLevel belongs to TimeView
    self.delegate = self;
    self.scrollEnabled = YES;
    self.bouncesZoom = YES;
    
    //set min and max zoom levels
    [self setZoomExtentsForOrientation:orientation];  
    
    //start fully zoomed out
    self.zoomScale = self.minimumZoomScale;
    
    //select level of detail with which to render nodes
    [self updateCurrentDetailLevel];
}

- (void)setZoomExtentsForOrientation:(UIInterfaceOrientation)orientation
{
    self.minimumZoomScale = fminf(self.bounds.size.width / timeView.bounds.size.width, self.bounds.size.height / timeView.bounds.size.height);
    
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        self.maximumZoomScale = self.bounds.size.width / NODE_WIDTH;
    else
        self.maximumZoomScale = self.bounds.size.height / NODE_HEIGHT;
    
    //detail zoom step is amount of zoom required before changing detail levels
    self.detailZoomStep = (self.maximumZoomScale - self.minimumZoomScale)  / (self.maxDetailLevel);
}

//TODO: currently only can switch LoD based on zooming, may need overload of this method with parameter
//      to directly set LoD without zooming
- (void)updateCurrentDetailLevel
{
    
    //TODO: Is zoomScale linear??
    //      i.e. is is same amount of "zoom" to get to detail level 1
    //      as it is to get to from detail level n-1 to n?  
    //      Doesn't "feel" that way in the simulator; device same?
    
    /*
    NSLog(@"Zoom Scale = %f", [self zoomScale]);
    NSLog(@"Zoom Min   = %f", [self minimumZoomScale]);
    NSLog(@"Z delta min= %f", [self zoomScale] - [self minimumZoomScale]);
    NSLog(@"Zoom Max   = %f", [self maximumZoomScale]);
    NSLog(@"Num steps  = %d", self.maxDetailLevel + 1);
    NSLog(@"Zoom Step  = %f", detailZoomStep);
    NSLog(@"Detail Lvl = %d", currentDetailLevel);
    NSLog(@"------------------------------------");
    */
    
    int newDetailLevel = (self.zoomScale - self.minimumZoomScale) / detailZoomStep;
    if (newDetailLevel != currentDetailLevel)
    {
        currentDetailLevel = newDetailLevel;
        for (id view in timeView.subviews)
        {
            if ([view isKindOfClass:[NodeView class]])
                [(NodeView*)view displayDetailLevel:currentDetailLevel];
        }
    }
}

- (void)handleRotation:(UIInterfaceOrientation)orientation
{
    self.contentSize = timeView.frame.size;
    bool isFullyZoomedOut = (self.zoomScale == self.minimumZoomScale);
    bool isFullyZoomedIn = (self.zoomScale == self.maximumZoomScale);
    [self setZoomExtentsForOrientation:orientation];
  
    //TODO: this doesn't work right when started in upside down portrait mode?????
    if (isFullyZoomedOut)
        [self zoomToRect:timeView.bounds animated:YES];
    else
    {
        //TODO: if fully zoomed in, need to go to max zoom if max zoom of new orientation
        //is more than old orientation and vice versa
        CGPoint newOrigin = CGPointMake(centerPreRotate.x - (self.frame.size.width/2), centerPreRotate.y - (self.frame.size.height/2));
        [self setContentOffset:newOrigin animated:YES];
    }
   
    
}
    

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return timeView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    [self updateCurrentDetailLevel];
}

@end
