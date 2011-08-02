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
@synthesize parseError = __parseError;
@synthesize parseSuccess = __parseSuccess;

- (id)initWithURL: (NSURL*)url
{
    self = [super init];
    if (self) {
        self.videos = [[NSMutableArray alloc] init];
        self.parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        self.parser.delegate = self;    
    }
    
    return self;
}

- (void)requestAndParse
{   
    [self.parser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser;
{
        
}

- (void)parserDidEndDocument:(NSXMLParser *)parser;
{
    self.parseSuccess = YES;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    self.currentString = @"";
    
    if ([elementName isEqualToString:@"entry"])
    {
        self.currentVideo = [[NSMutableDictionary alloc] init];
    }
    
    if ([elementName isEqualToString:@"media:player"])
    {
        [self.currentVideo setValue:[attributeDict objectForKey:@"url"] forKey:@"url"];
    } 
    
    if (([elementName isEqualToString:@"media:thumbnail"]) )
    {
        if ([[attributeDict objectForKey:@"width"]isEqualToString:@"320"])
            [self.currentVideo setValue:[attributeDict objectForKey:@"url"] forKey:@"thumbnailurl"];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    if ([elementName isEqualToString:@"entry"])
    {
        [self.videos addObject:self.currentVideo];
    }
    
    if ([elementName isEqualToString:@"title"])
    {
        [self.currentVideo setValue:self.currentString forKey:@"title"];
    }
    
    if ([elementName isEqualToString:@"media:description"])
    {
        [self.currentVideo setValue:[self.currentString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"summary"];
    }
    
    if ([elementName isEqualToString:@"yt:videoid"])
    {
        [self.currentVideo setValue:self.currentString forKey:@"id"];
    } 
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    self.currentString  = [string stringByAppendingString:self.currentString];
}

- (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString;
{
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError;
{
    self.parseSuccess = NO;
    self.parseError = parseError;
}

@end
