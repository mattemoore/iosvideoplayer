//
//  NodeView.m
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-26.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import "NodeView.h"
#import "TimeView.h"

@implementation NodeView

@synthesize maxDetailLevel, webView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self.maxDetailLevel = 1; 
    self.webView = [[UIWebView alloc] initWithFrame:self.bounds];
    self.webView.mediaPlaybackRequiresUserAction = NO;
    [self addSubview:self.webView];
    self.backgroundColor = [UIColor whiteColor];  //TODO:thumbnail instead
    return self;
}

-(void)displayDetailLevel:(int)detailLevel
{
    if (detailLevel > maxDetailLevel) return;
    
    //TODO: fade in and out type of animation so not so jarring
    if (detailLevel == 0)
        [self showThumbnail];
    else if (detailLevel == 1)
        [self showVideo];
    /*
    if (detailLevel == 0)
        self.backgroundColor = [UIColor yellowColor];
    else if (detailLevel == 1)
        self.backgroundColor = [UIColor greenColor];
    else if (detailLevel == 2)
        self.backgroundColor = [UIColor whiteColor];
    else if (detailLevel == 3)
        self.backgroundColor = [UIColor purpleColor];
    else if (detailLevel == 4)
        self.backgroundColor = [UIColor grayColor];
    else if (detailLevel == 5)
        self.backgroundColor = [UIColor brownColor];
     */
}

//TODO: -try this instead of Youtube Video
//      -zoom from top level detail to second level detail which is thumbnail 
//      and play button, thumbnail doesn't necessarily have to be fetched from     youtube
//      -pipe to MPMovie Player

-(void)showVideo
{
    self.webView.hidden = NO;
    if (self.webView.request == nil) 
    {
        //TODO: Youtube iFrame API bug or Apple won't allow events to fire
        //      add border around frame here
        
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
        
        TimeView* timeView = (TimeView*)self.superview;
        NSArray *videos = timeView.videos;
        NSString *youtubeId = [videos objectAtIndex:self.tag];
        NSString* html = [NSString stringWithFormat:embedHTML, self.frame.size.width, self.frame.size.height, youtubeId];  
        [self.webView loadHTMLString:html baseURL:nil]; 
    }
}

-(void)showThumbnail
{
    self.webView.hidden = YES;
    [self.webView stringByEvaluatingJavaScriptFromString:@"stopVideo();"];  
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
