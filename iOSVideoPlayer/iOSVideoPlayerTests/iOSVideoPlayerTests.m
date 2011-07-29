//
//  iOSVideoPlayerTests.m
//  iOSVideoPlayerTests
//
//  Created by Matthew Moore on 11-06-22.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "iOSVideoPlayerTests.h"
#import "YoutubeBridge.h"

@implementation iOSVideoPlayerTests

@synthesize bridge = __bridge;

- (void)setUp
{
    [super setUp];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [mainBundle pathForResource:@"TestYouTubeFeed" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.bridge = [[YoutubeBridge alloc] initWithURL:url];
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testParseAuthor
{
    [self.bridge requestAndParse];
    assert(self.bridge.parseSuccess);
}

@end
