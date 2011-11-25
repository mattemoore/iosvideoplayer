//
//  TimeViewVideoController.m
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-11-25.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import "TimeViewVideoController.h"

@implementation TimeViewVideoController

@synthesize webView;

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
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:webView];
}

-(void)playVideo:(NSString*)youtubeId
{
    NSString *embedHTML = @"\
    <html>\
    <body style=\"margin:0; padding:0\">\
    <!-- 1. The <div> tag will contain the <iframe> (and video player) -->\
    <div id=\"player\"></div>\
    <script>\
    var tag = document.createElement('script');\
    tag.src = \"http://www.youtube.com/player_api\";\
    var firstScriptTag = document.getElementsByTagName('script')[0];\
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\
    var player;\
    function onYouTubePlayerAPIReady() {\
    player = new YT.Player('player', {\
    height: '%0.0f',\
    width: '%0.0f',\
    videoId: '%@',\
    events: {'onReady':onPlayerReady,'onStateChange':onPlayerStateChange,'onError': onPlayerError }\
    });\
    }\
    function onPlayerReady(event) {\
    }\
    function onPlayerStateChange(event) {\
    }\
    function onPlayerError(event) { \
    }\
    function stopVideo() {\
    player.stopVideo();\
    }\
    </script>\
    </body>\
    </html>";
    
    /*
     NSString* embedHTML = @"\
     <html><head>\
     <style type=\"text/css\">\
     body {\
     background-color: transparent;\
     color: black;\
     }\
     #video {\
     margin:1px;\
     }\
     </style>\
     </head><body style=\"margin:0; padding:0\">\
     <div id=\"video\">\
     <iframe id=\"player\" width=\"%0.0f\" height=\"%0.0f\" src=\"http://www.youtube.com/embed/%@?rel=0&amp;hd=1 frameborder=\"0\" allowfullscreen enablejsapi></iframe>\
     </div>\
     </body></html>";  
     */
    
   NSString* html = [NSString stringWithFormat:embedHTML, self.view.frame.size.width, self.view.frame.size.height, youtubeId];  
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

@end
