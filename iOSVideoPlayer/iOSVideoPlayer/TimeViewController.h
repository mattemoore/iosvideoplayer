//
//  TimeViewController.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-10-16.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeViewController : UIViewController

{
    
}

@property (strong, nonatomic) UIScrollView* scrollView;


-(void)initScrollview;


-(NSArray*) loadTestData;
-(void) addChildNodesToNode:(NSMutableArray*)node numberOfChildNodes:(int)numChildNodes;
-(void) printTestData:(NSArray*)testData;

@end
