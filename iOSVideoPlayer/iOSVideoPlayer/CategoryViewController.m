//
//  CategoryViewController.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-07-07.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "CategoryViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation CategoryViewController

@synthesize previousCategoryLabel = __previousCategoryLabel;
@synthesize currentCategoryLabel = __currentCategoryLabel;
@synthesize nextCategoryLabel = __nextCategoryLabel;
@synthesize nextCategoryName = __nextCategoryName;
@synthesize currentCategoryName = __currentCategoryName;
@synthesize previousCategoryName = __previousCategoryName;

- (id)initWithCategory: (NSString*)categoryName nextCategory:(NSString*)nextCategoryName previousCategory:(NSString*)previousCategoryName
{
    self = [super initWithNibName:@"CategoryViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        self.currentCategoryName = categoryName;
        self.nextCategoryName = nextCategoryName;
        self.previousCategoryName = previousCategoryName;
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
    
    self.view.layer.borderColor = [UIColor greenColor].CGColor;
    self.view.layer.borderWidth = 3.0;
    
    self.currentCategoryLabel.text = self.currentCategoryName;
    self.nextCategoryLabel.text = self.nextCategoryName;
    self.previousCategoryLabel.text = self.previousCategoryName;
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

@end
