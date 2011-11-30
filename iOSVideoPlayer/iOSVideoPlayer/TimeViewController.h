//
//  TimeViewController.h
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-22.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeView.h"
#import "TimeScrollView.h"

@interface TimeViewController : UIViewController <TimeViewDelegate>
{}

@property (strong, nonatomic) IBOutlet TimeScrollView *timeScrollView;



@end
