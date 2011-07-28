//
//  YoutubeBridge.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-07-26.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YoutubeBridge.h"

#define kApiKey AI39si6AIfVaikIH6D3Yw_TX2rFNzPEsuMb1yvWefpPGghgLB4h2EciSsV1qPP_SntqkUfg9pAN3bpGrq8rUWpwF2dphr3EvKQ

@implementation YoutubeBridge

@synthesize parser = __parser;
@synthesize currentVideo = __currentVideo;
@synthesize currentString = __currentString;
@synthesize videos = __videos;

- (id)initWithURL: (NSURL*)url
{
    self = [super init];
    if (self) {
        
        self.parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        [self.parser parse];
    }
    
    return self;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser;
{
    
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser;
{
    parseSuccess = YES;
    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    
}

- (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString;
{
    
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError;
{
    parseSuccess = NO;
}


@end
