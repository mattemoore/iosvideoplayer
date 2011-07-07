//
//  CategoryViewController.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-07-07.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UIViewController
{
    UILabel *previousCategoryLabel;
    UILabel *currentCategoryLabel;
    UILabel *nextCategoryLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *previousCategoryLabel;
@property (nonatomic, retain) IBOutlet UILabel *currentCategoryLabel;
@property (nonatomic, retain) IBOutlet UILabel *nextCategoryLabel;
@property (nonatomic, strong) NSString *previousCategoryName;
@property (nonatomic, strong) NSString *currentCategoryName;
@property (nonatomic, strong) NSString *nextCategoryName;

- (id)initWithCategory: (NSString*)categoryName nextCategory:(NSString*)nextCategoryName previousCategory:(NSString*)previousCategoryName;

@end
