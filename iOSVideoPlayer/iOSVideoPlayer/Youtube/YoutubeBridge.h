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
    BOOL parseSuccess;
}

@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSMutableArray *videos;
@property (nonatomic, strong) Video *currentVideo;
@property (nonatomic, strong) NSString *currentString;

- (id)initWithURL: (NSURL*)url;

@end
