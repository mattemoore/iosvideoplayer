//
//  TimeViewController.m
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-22.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import "TimeViewController.h"
#import "TimeView.h"
#import "VideoViewController.h"
#import "HelpViewController.h"

@implementation TimeViewController

@synthesize timeScrollView, titleLabel, helpButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:@"TimeView" owner:self options:nil];
    TimeView *timeView;
    for (id object in bundle)
    {
        if ([object isKindOfClass:[TimeView class]])
            timeView = (TimeView*)object;
    }
    timeView.delegate = self;
    self.titleLabel.text = timeView.title;
    [timeScrollView setTimeView:timeView forOrientation:self.interfaceOrientation];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    timeScrollView.centerPreRotate = CGPointMake(timeScrollView.contentOffset.x + timeScrollView.bounds.size.width/2, timeScrollView.contentOffset.y + timeScrollView.bounds.size.height/2);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation 
{
    [timeScrollView handleRotation:self.interfaceOrientation];
}

-(IBAction)showHelp:(id)sender
{
    HelpViewController *helpViewController = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:[NSBundle mainBundle]];
    helpViewController.view.frame = self.view.frame;
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentModalViewController:helpViewController animated:YES];
}

//TimeView delegate methods

- (void)showVideoWithYoutubeId:(NSString*)youtubeId
{
    VideoViewController *videoViewController = [[VideoViewController alloc] initWithNibName:@"VideoViewController" bundle:[NSBundle mainBundle]];
    videoViewController.view.frame = self.view.frame;
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentModalViewController:videoViewController animated:YES];
    [videoViewController showVideoWithYoutubeId:youtubeId];
}
@end
