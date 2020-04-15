//
//  GeoLocationManager.h
//  Tracker Mapper
//
//  Created by Alex Zavatone on 8/17/17.
//  Copyright © 2017 Alex Zavatone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "DataSingleton.h"
#import "GeoLocation.h"

@interface GeoLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) DataSingleton *dataStorage;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isUpdatingLocation;

@property (nonatomic, strong) NSMutableArray *currentJourney;

@property (nonatomic, strong) NSString *latestCoordString; // For observing
@property (nonatomic, strong) NSDictionary *latestCoordDict; // For observing

+ (instancetype)sharedInstance;
- (void)start;
- (void)stop;

@end
