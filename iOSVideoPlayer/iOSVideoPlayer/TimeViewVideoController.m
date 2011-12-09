//
//  TimeViewVideoController.m
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-11-25.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import "TimeViewVideoController.h"
#import "DSActivityView.h"

#define IFRAME_PAD 3.0

@implementation TimeViewVideoController

@synthesize webView, youtubeId, embedHTML, doneButton, toolBar;

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
    
    
    //self.webView.allowsInlineMediaPlayback = NO;
    self.webView.mediaPlaybackRequiresUserAction = NO;
   
    //ios5
    if ([UIWebView respondsToSelector:@selector(setMediaPlaybackAllowsAirPlay:)])
    {
        self.webView.mediaPlaybackAllowsAirPlay = YES;
        self.webView.scrollView.scrollEnabled = NO;
    }
    
    self.webView.delegate = self;
    self.toolBar.barStyle = UIBarStyleBlack;
    self.toolBar.translucent = YES;
    self.doneButton.style = UIBarButtonItemStyleDone;
    
    self.embedHTML = @"\
    <html><head>\
    <style type='text/css'>\
    body {background: #000000;margin:0;padding:0;}\
    </style>\
    </head><body>\
    <iframe id='player' type='text/html' width='%0.0f' height='%0.0f' src='http://www.youtube.com/embed/%@?rel=0&amp;autoplay=1' frameborder='0' allowFullScreen></iframe>\
    </body></html>";  
}

-(void)showVideoWithYoutubeId:(NSString*)youtubeVideoId
{       
    [DSBezelActivityView newActivityViewForView:self.view withLabel:@"Loading video..."];
    
    self.youtubeId = [youtubeVideoId copy];
    NSString* html = [NSString stringWithFormat:embedHTML, self.webView.bounds.size.width - IFRAME_PAD, self.webView.bounds.size.height - IFRAME_PAD, self.youtubeId]; 
    [self.webView loadHTMLString:html baseURL:nil];
   
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
   [DSBezelActivityView removeViewAnimated:YES];
}

-(IBAction)close:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
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
    NSString *script = [NSString stringWithFormat:@"var player=document.getElementById('player');player.width='%0.0f'; player.height='%0.0f';", self.webView.bounds.size.width- IFRAME_PAD, self.webView.bounds.size.height- IFRAME_PAD];
    [self.webView stringByEvaluatingJavaScriptFromString:script];
    //self.webView.scrollView.contentSize = self.webView.bounds.size;
}

@end
