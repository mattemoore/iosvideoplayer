//
//  NodeView.h
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-26.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NodeView.h"

@interface NodeView : UIView
{}

@property (nonatomic, assign) int maxDetailLevel;
@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) UIImageView *screenshot;
@property (nonatomic, strong) UIImageView *playButton;

-(void)displayDetailLevel:(int)detailLevel;
-(void)showScreenshot;
-(void)showThumbnail;

@end
