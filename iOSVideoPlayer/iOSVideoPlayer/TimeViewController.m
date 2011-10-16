//
//  TimeViewController.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-10-16.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "TimeViewController.h"

#define nodeWidth 300
#define nodeHeight 300


@implementation TimeViewController

@synthesize scrollView;


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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [self initScrollview];
    NSArray *testData = [self loadTestData];
    [self printTestData:testData];
        
    //async call to fetch vids
    
    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
/*
 - (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	if (interfaceOrientation == UIInterfaceOrientationPortrait) 
        return NO;
    else
        return YES;
}

#pragma mark - Layout/init timeline view

- (void) initScrollview
{
    self.view = [[UIView alloc] init];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = self.view.frame;
    self.scrollView.bounces = YES;
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.maximumZoomScale = 4;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
}


//build initial layout of nodes, zoom, size of content, 
//data structure
- (void) drawNodes:(NSArray*)nodes
{
    
    
    //most nodes at particular 'column' sets height of content
    
    //number of columns sets width of content
    
    
}

-(NSArray*) loadTestData
{
    NSMutableArray *testNodes = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++)
    {
        NSMutableArray *rootNode = [[NSMutableArray alloc] init];
        [self addChildNodesToNode:rootNode numberOfChildNodes:i];
        [testNodes addObject: rootNode];
    }
    return testNodes;
}

-(void) addChildNodesToNode:(NSMutableArray*)node numberOfChildNodes:(int)numChildNodes
{
    for (int i = 0; i < numChildNodes; i ++)
    {
        NSMutableArray *childNode = [[NSMutableArray alloc] init];
        [node addObject:childNode];
        [self addChildNodesToNode:childNode numberOfChildNodes:i];
    }
}
                             
-(void) printTestData:(NSArray*)testData
{
    for (int i=0; i < [testData count]; i++)
    {
        NSArray *node = (NSArray*)[testData objectAtIndex:i];
        NSLog(@"Node %d count %d", i, node.count);
        [self printTestData:node];
    }
}
                         
                         

//take thumbnails from vids and make stylized background
- (void) initBackgound 
{
    
}


@end