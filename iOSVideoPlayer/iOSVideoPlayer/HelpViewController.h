//
//  HelpViewController.h
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-12-11.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, strong) IBOutlet UIToolbar *toolBar;

-(IBAction)close:(id)sender;

@end
