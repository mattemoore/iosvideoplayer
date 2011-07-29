//
//  YoutubeBridge.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-07-26.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Video.h"

@interface YoutubeBridge : NSObject <NSXMLParserDelegate>
{
}

@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSMutableArray *videos;
@property (nonatomic, strong) Video *currentVideo;
@property (nonatomic, strong) NSString *currentString;
@property (nonatomic, strong) NSError *parseError;
@property BOOL parseSuccess;

- (id)initWithURL: (NSURL*)url;
- (void)requestAndParse;

@end
