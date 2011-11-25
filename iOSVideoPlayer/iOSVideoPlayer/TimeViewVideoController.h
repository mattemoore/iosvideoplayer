//
//  TimeViewVideoController.h
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-11-25.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeViewVideoController : UIViewController
{}

@property (nonatomic, strong) UIWebView *webView;

-(void)playVideo:(NSString*)youtubeId;

@end
