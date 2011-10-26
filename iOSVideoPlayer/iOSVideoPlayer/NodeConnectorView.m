//
//  NodeConnectorView.m
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-26.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import "NodeConnectorView.h"

@implementation NodeConnectorView

@synthesize connectLineType;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.connectLineType = LineTypeDown;
    }
    return self;
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self.backgroundColor = [UIColor clearColor];
    self.connectLineType = LineTypeDown;
    return self;
}

//TODO: override drawing, context, currentpoint, line, fill line
//      then make this view into a plugin so that you can use in custom object in IB
//      be great if it actually drew itself in IB too!


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    int startPointX = 0;
    int endPointX = self.frame.size.width;
    int startPointY, endPointY;
    
    switch (self.connectLineType) {
        case LineTypeUp:
            startPointY = self.frame.size.height;
            endPointY = 0;
            break;
        case LineTypeDown:
            startPointY = 0;
            endPointY = self.frame.size.height;
            break;
            
        default: //LineTypeStraight
            startPointY = self.frame.size.height / 2;
            endPointY = self.frame.size.height / 2;
            break;
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 0,0,0,1);   
    CGContextSetLineWidth(ctx, 5.0);
    CGContextMoveToPoint(ctx, startPointX, startPointY);
    CGContextAddLineToPoint(ctx, endPointX, endPointY);
    CGContextStrokePath(ctx);
}


@end
