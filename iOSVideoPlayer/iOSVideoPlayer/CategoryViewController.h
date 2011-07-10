//
//  CategoryViewController.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-07-07.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *previousCategoryLabel;
@property (nonatomic, strong) IBOutlet UILabel *currentCategoryLabel;
@property (nonatomic, strong) IBOutlet UILabel *nextCategoryLabel;
@property (nonatomic, strong) NSString *previousCategoryName;
@property (nonatomic, strong) NSString *currentCategoryName;
@property (nonatomic, strong) NSString *nextCategoryName;

- (id)initWithCategory: (NSString*)categoryName nextCategory:(NSString*)nextCategoryName previousCategory:(NSString*)previousCategoryName;

@end
