//
//  DataSingleton.h
//  Tracker Mapper
//
//  Created by Alex Zavatone on 8/17/17.
//  Copyright © 2017 Alex Zavatone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UITableView.h> // https://stackoverflow.com/a/36090550 There is an extension section at the bottom of UITableView.h which adds row and section properties for NSIndexPaths that are used in UITableViews.
#import <UIKit/NSAttributedString.h>

@interface DataSingleton : NSObject

@property (nonatomic, strong) NSMutableArray *mainMenuItemData;
@property (nonatomic, strong) NSArray *mainMenuItems;

+ (instancetype)sharedInstance;
- (NSAttributedString *)menuItemForIndexPath:(NSIndexPath *)indexPath;
@end
