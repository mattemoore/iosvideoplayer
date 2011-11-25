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

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self.backgroundColor = [UIColor clearColor];
    switch (self.tag) {
        case 0:
            self.connectLineType = Horizontal;
            break;
        case 1:
            self.connectLineType = Vertical;
            break;
        case 2:
            self.connectLineType = AngleUp;
            break;
        case 3:
            self.connectLineType = AngleDown;
            break;
        default:
            self.connectLineType = Horizontal;
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
        case AngleUp:
            startPointY = self.frame.size.height;
            endPointY = 0;
            break;
        case AngleDown:
            startPointY = 0;
            endPointY = self.frame.size.height;
            break;
        case Vertical:
            startPointX = self.frame.size.width / 2;
            endPointX = self.frame.size.width / 2;
            startPointY = 0;
            endPointY = self.frame.size.height;
            break;
        default: //Horizontal
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
