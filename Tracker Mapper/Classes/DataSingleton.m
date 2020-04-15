//
//  DataSingleton.m
//  Tracker Mapper
//
//  Created by Alex Zavatone on 8/17/17.
//  Copyright © 2017 Alex Zavatone. All rights reserved.
//

#import "DataSingleton.h"

@implementation DataSingleton

+ (instancetype)sharedInstance
{
    static DataSingleton *instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    if (self = [super init]) {
        
        [self initData];
    }
    return self;
}

- (void)initData
{
    [self initMainMenu];
}

- (void)initMainMenu
{
    NSString *mainMenuFilePath = [[NSBundle mainBundle] pathForResource:@"Main Menu Items" ofType:@"plist"];
    
    //  [[[BundleFileUtils thisBundle] pathForResource:fileName ofType:fileType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *temporaryMenuItemsArray = [NSArray arrayWithContentsOfFile:mainMenuFilePath];
    NSMutableArray *temporaryMainMenuText = [NSMutableArray array];
    _mainMenuItemData = [NSMutableArray array];
    _mainMenuItems = [NSArray array];
    
    // Build the master menu from the set of visible items in the array
    for (NSMutableDictionary *myMenuItemObject in temporaryMenuItemsArray) {
        
        // Make a mutable copy and iterate on that.
        NSMutableDictionary *mutableCopyOfMenuItemObject = [myMenuItemObject mutableCopy];
        
        // if the object is visible
        if ([[mutableCopyOfMenuItemObject objectForKey:@"visible"] boolValue ] ) {
            [_mainMenuItemData addObject:mutableCopyOfMenuItemObject];
            [temporaryMainMenuText addObject:[mutableCopyOfMenuItemObject objectForKey:@"title"]];
        }
    }
    
    _mainMenuItems = [temporaryMainMenuText copy];
}

- (NSAttributedString *)menuItemForIndexPath:(NSIndexPath *)indexPath
{
    NSString *myMenuText = [_mainMenuItems objectAtIndex:indexPath.row];
    
    // #define HelveticaNeueBold(s)            [UIFont fontWithName:@"HelveticaNeue-Bold" size:s]
    UIFont *thickFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
    UIColor *myBlue = [UIColor colorWithRed:.02 green:.48 blue:.66 alpha:1.0];
    
    // Define attributes dictionary for bold text.
    NSDictionary *boldAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    thickFont, NSFontAttributeName,
                                    myBlue, NSForegroundColorAttributeName,
                                    nil];

    // Create attributed string using an attributes dictionary of that font
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:myMenuText
                                                                                         attributes:boldAttributes];
    
    return attributedString;
    
}

- (void)startRecordingLocationUpdates
{
    
}

- (void)stopRecordingLocationUpdates
{
    
}

@end
