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

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *youtubeId;
@property (nonatomic, strong) NSString *embedHTML;

-(void)showVideoWithYoutubeId:(NSString*)youtubeId;
-(void)loadVideo;

@end
