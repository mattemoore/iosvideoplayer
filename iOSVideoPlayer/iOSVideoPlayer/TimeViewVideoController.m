//
//  TimeViewVideoController.m
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-11-25.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import "TimeViewVideoController.h"

@implementation TimeViewVideoController

@synthesize webView, youtubeId, embedHTML;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.embedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
    ;: #333333;\
    }\
    #video {margin:0; padding:0;}\
    </style>\
    </head><body style=\"margin:0; padding:0\">\
    <div id=\"video\">\
    <iframe id=\"player\" width=\"%0.0f\" height=\"%0.0f\" src=\"http://www.youtube.com/embed/%@?rel=0&amp;hd=1 frameborder=\"0\"></iframe>\
    </div>\
    </body></html>";  
}

-(void)showVideoWithYoutubeId:(NSString*)youtubeVideoId;
{       
    self.youtubeId = [youtubeVideoId copy];
    [self loadVideo];
}

-(void)loadVideo
{
    NSString* html = [NSString stringWithFormat:embedHTML, self.webView.bounds.size.width, self.webView.bounds.size.height, self.youtubeId];  
    [self.webView loadHTMLString:html baseURL:nil];
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


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation 
{
    [self loadVideo];
}

@end
