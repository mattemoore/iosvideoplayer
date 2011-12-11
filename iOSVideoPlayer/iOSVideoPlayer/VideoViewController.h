//
//  TimeViewVideoController.h
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-11-25.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoViewController : UIViewController <UIWebViewDelegate>
{}

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *youtubeId;
@property (nonatomic, strong) NSString *embedHTML;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, strong) IBOutlet UIToolbar *toolBar;

-(void)showVideoWithYoutubeId:(NSString*)youtubeId;
-(IBAction)close:(id)sender;
@end
