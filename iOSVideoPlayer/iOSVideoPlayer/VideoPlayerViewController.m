//
//  VideoPlayerViewController.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-07-21.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "Video.h"

@implementation VideoPlayerViewController

@synthesize titleLabel = __titleLabel;
@synthesize summaryLabel = __summaryLabel;
@synthesize videoWebView = __videoWebView;
@synthesize video = __video;

//TODO: put in a close button in nib 

- (id)initWithVideo: (Video*)video
{
    self = [super initWithNibName:@"VideoPlayerViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.video = video;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.titleLabel.text = self.video.Title;
    self.summaryLabel.text = self.video.Description;
    [self embedYouTube:self.video.URL];
    
     [super viewDidLoad];
}

- (void)embedYouTube:(NSString*)url {  
    NSString* embedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
    background-color: transparent;\
    color: white;\
    }\
    </style>\
    </head><body style=\"margin:0\">\
    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
    width=\"%0.0f\" height=\"%0.0f\"></embed>\
    </body></html>";  
    NSString* html = [NSString stringWithFormat:embedHTML, url, self.videoWebView.frame.size.width, self.videoWebView.frame.size.height];  
    [self.videoWebView loadHTMLString:html baseURL:nil];  
    
    /*
    NSString *htmlString = @"<html><head>
    <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 212\"/></head><body style=\"background:#F00;margin-top:0px;margin-left:0px\"><div><object width=\"212\" height=\"172\"><param name=\"movie\" value=\"http://www.youtube.com/v/oHg5SJYRHA0&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\"http://www.youtube.com/v/oHg5SJYRHA0&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM\"type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"212\" height=\"172\"></embed></object></div></body></html>";
    */
}  

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
