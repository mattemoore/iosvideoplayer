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
        
    }
    return self;
}

//TODO: implement a vertical connector
- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self.backgroundColor = [UIColor clearColor];
    switch (self.tag) {
        case 0:
            self.connectLineType = LineTypeStraight;
            break;
        case 1:
            self.connectLineType = LineTypeUp;
            break;
        case 2:
            self.connectLineType = LineTypeDown;
            break;
        default:
            self.connectLineType = LineTypeStraight;
            break;
    }
    return self;
}

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
    CGContextSetRGBStrokeColor(ctx, 1,1,1,1);   
    CGContextSetLineWidth(ctx, 5.0);
    CGContextMoveToPoint(ctx, startPointX, startPointY);
    CGContextAddLineToPoint(ctx, endPointX, endPointY);
    CGContextStrokePath(ctx);
}


@end
