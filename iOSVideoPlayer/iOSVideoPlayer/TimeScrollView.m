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

#define NODE_WIDTH 300

@implementation TimeScrollView
    
@synthesize maxDetailLevel, currentDetailLevel, detailZoomStep;
@synthesize maxZoomScalePortrait, maxZoomScaleLandscape;


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
    self.maxDetailLevel = 2; //TODO: maxDetailLevel belong to TimeView
    self.delegate = self;
    self.scrollEnabled = YES;
    self.bouncesZoom = YES;
    
    //TODO:below won't work if setTimeView is called at zoomScale other than 1.0 as frame size won't be correct
    
    //max ZOOM OUT is show full WIDTH of view 
    self.minimumZoomScale = self.frame.size.width / timeView.frame.size.width;
    
    //TODO: calc min zoom for landscape too
    //      we don't zoom out for landscape change unless,
    //      current zoomScale is minPortraitZoom scale as that means
    //      we started app in landscape or have rotated when zoomed fully out
    
    //max ZOOM IN is limited to frame size of a node
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        maxZoomScalePortrait = self.frame.size.width / NODE_WIDTH;
        maxZoomScaleLandscape = (self.frame.size.width - 20.0) / NODE_WIDTH; //status bar
        self.maximumZoomScale = maxZoomScalePortrait;
    }
    else
    {
        maxZoomScaleLandscape = self.frame.size.height / NODE_WIDTH; 
        maxZoomScalePortrait = (self.frame.size.height + 20) / NODE_WIDTH;
        self.maximumZoomScale = maxZoomScaleLandscape;
    }
    
    //start fully zoomed out
    self.zoomScale = self.minimumZoomScale;
    
    //set max zoom scale and detail zoom step
    [self setMaxZoomScaleForOrientation:orientation];  
    
    //select level of detail with which to render nodes
    [self updateCurrentDetailLevel];
}

- (void)setMaxZoomScaleForOrientation:(UIInterfaceOrientation)orientation
{
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        self.maximumZoomScale = maxZoomScalePortrait;
    else
        self.maximumZoomScale = maxZoomScaleLandscape;
    
    //detail zoom step is amount of zoom required before changing detail levels, value changes based on orientation
    self.detailZoomStep = (self.maximumZoomScale - self.minimumZoomScale)  / (self.maxDetailLevel);
}

//TODO: currently only can switch LoD based on zooming, may need overload of this method with parameter
//      to directly set LoD without zooming
- (void)updateCurrentDetailLevel
{
    
    //TODO: Is zoomScale linear??
    //      i.e. is is same amount of "zoom" to get to detail level 1
    //      as it is to get to from detail level n-1 to n?  
    //      Doesn't "feel" that way in the simulator; device?
    
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
    
    int newDetailLevel = ([self zoomScale] - [self minimumZoomScale]) / detailZoomStep;
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
    [self setMaxZoomScaleForOrientation:orientation];
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
