//
//  MainTableViewController.h
//  Tracker Mapper
//
//  Created by Alex Zavatone on 8/17/17.
//  Copyright © 2017 Alex Zavatone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSingleton.h"

@interface MainTableViewController : UITableViewController

@property (nonatomic, strong) DataSingleton *dataStorage;

@end
