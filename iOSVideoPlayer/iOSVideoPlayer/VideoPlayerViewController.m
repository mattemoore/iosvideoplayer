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
@synthesize rootViewController = __rootViewController;

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
    [super viewDidLoad];
    
    self.titleLabel.text = self.video.Title;
    self.summaryLabel.text = self.video.Description;
    [self embedYouTube:self.video.URL];
}

- (void)embedYouTube:(NSString*)url {  
    NSString* embedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
    background-color: transparent;\
    color: black;\
    }\
    </style>\
    </head><body style=\"margin:0\">\
    <iframe width=\"%0.0f\" height=\"%0.0f\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>\
    </body></html>";  
   NSString* html = [NSString stringWithFormat:embedHTML, self.videoWebView.frame.size.width, self.videoWebView.frame.size.height,url];  
    [self.videoWebView loadHTMLString:html baseURL:nil];  
    
    
}  

- (IBAction)closePlayer:(id)sender
{
    [self.rootViewController dismissViewControllerAnimated:YES completion:NULL];
    [self.rootViewController handleRotate];
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


-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
}

@end
