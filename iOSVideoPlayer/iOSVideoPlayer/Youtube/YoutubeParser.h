//
//  YoutubeBridge.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-07-26.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YoutubeParser : NSObject <NSXMLParserDelegate>
{
}

@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSMutableArray *parsedVideos;
@property (nonatomic, strong) NSMutableDictionary *currentVideo;
@property (nonatomic, strong) NSString *currentString;
@property (nonatomic, strong) NSError *error;
@property BOOL isSuccess;

- (id)initWithURL: (NSURL*)url;
- (void)requestAndParse;

@end
