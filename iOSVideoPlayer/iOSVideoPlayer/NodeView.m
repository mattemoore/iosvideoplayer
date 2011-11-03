//
//  NodeView.m
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-26.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import "NodeView.h"

@implementation NodeView

@synthesize maxDetailLevel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//TODO: More than 1 type of node then make this class base class
//      different sub-nodes could have different detail levels...
- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    maxDetailLevel = 2;  
    return self;
}


-(void)displayDetailLevel:(int)detailLevel
{
    if (detailLevel > maxDetailLevel) return;
    
    if (detailLevel == 0)
        self.backgroundColor = [UIColor yellowColor];
    else if (detailLevel == 1)
        self.backgroundColor = [UIColor greenColor];
    else if (detailLevel == 2)
        self.backgroundColor = [UIColor redColor];
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
