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
    
@synthesize detailZoomStep, centerPreRotate;

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
    self.detailZoomStep = (self.maximumZoomScale - self.minimumZoomScale)  / (timeView.maxDetailLevel + 1);
    
    //remove '+1' from denominator to 'snap' switching to maxDetailLevel at maxZoomScale
}

//after zooming is done check if we need to change detail level
- (void)updateCurrentDetailLevel
{   
    int newDetailLevel = ((self.zoomScale - self.minimumZoomScale) / detailZoomStep);
    if (newDetailLevel > timeView.maxDetailLevel) newDetailLevel = timeView.maxDetailLevel; 
    if (newDetailLevel != timeView.currentDetailLevel)
    {
        [timeView updateCurrentDetailLevel:newDetailLevel];
    }
    
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

}

- (void)handleRotation:(UIInterfaceOrientation)orientation
{
    self.contentSize = timeView.frame.size;
    
    bool wasFullyZoomedOut = (self.zoomScale == self.minimumZoomScale);
    bool wasFullyZoomedIn = (self.zoomScale == self.maximumZoomScale);
    
    [self setZoomExtentsForOrientation:orientation];
    
    if (wasFullyZoomedOut)
    {
        self.zoomScale = self.minimumZoomScale;
        [self setContentOffset:CGPointMake(0,0) animated:YES];
    }
    else
    {
        CGPoint newOrigin = CGPointMake(centerPreRotate.x - (self.frame.size.width/2), centerPreRotate.y - (self.frame.size.height/2));
        [self setContentOffset:newOrigin animated:YES];
        
        if (wasFullyZoomedIn)
            self.zoomScale = self.maximumZoomScale;
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
