//
//  NodeView.m
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-26.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import "NodeView.h"

@implementation NodeView

@synthesize maxDetailLevel, webView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//TODO: More than 1 type of node then make this class base class
//      different sub-nodes could have different detail levels...
- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    //TODO: get TimeView parent from here, plist of videos should be loaded there
    //      also maxDetailLevel should be gotten from TimeView parent
    maxDetailLevel = 1;  
    self.webView = [[UIWebView alloc] initWithFrame:self.bounds];
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


-(void)showVideo
{
    //TODO: don't load embed code if already had been loaded before (i.e. show it)
    //load via JS here:http://code.google.com/apis/youtube/iframe_api_reference.html
    //then stop function will work
    self.webView.hidden = NO;
    
    if (self.webView.request == nil) 
    {
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
    
        //TODO: when zoom out video doesn't stop
        //      this example code should auto-stop after 6 seconds but doesn't
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
            events: {\
                'onReady': onPlayerReady,\
                'onStateChange': onPlayerStateChange\
            }\
            });\
        }\
        function onPlayerReady(event) {\
            event.target.playVideo();\
        }\
        var done = false;\
        function onPlayerStateChange(event) {\
            if (event.data == YT.PlayerState.PLAYING && !done) {\
                setTimeout(stopVideo, 6000);\
                done = true;\
            }\
        }\
        function stopVideo() {\
            player.stopVideo();\
        }\
        </script>\
        </body>\
        </html>";
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TimeViewData" ofType:@"plist"];  
        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:filePath];
        NSArray *videos = [plist objectForKey:@"Videos"];
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
