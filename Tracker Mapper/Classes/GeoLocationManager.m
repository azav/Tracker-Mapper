//
//  GeoLocationManager.m
//  Tracker Mapper
//
//  Created by Alex Zavatone on 8/17/17.
//  Copyright © 2017 Alex Zavatone. All rights reserved.
//

#import "GeoLocationManager.h"

@interface GeoLocationManager () <CLLocationManagerDelegate>

@end

@implementation GeoLocationManager

+ (instancetype)sharedInstance
{
    static GeoLocationManager *instance;
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
    _dataStorage = [DataSingleton sharedInstance];
    
    [self initLocationManager];
    [self initLocationManagerRegistration];
}

- (void)initLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    self.locationManager.distanceFilter = 0; // 1 meter
    self.locationManager.pausesLocationUpdatesAutomatically = YES;
    
}

- (void)initLocationManagerRegistration
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
    }
}

- (void)start
{
    _currentJourney = [NSMutableArray array];
    [self.locationManager startUpdatingLocation];
    _isUpdatingLocation = YES;
}

- (void)stop
{
     [self.locationManager stopUpdatingLocation];
    _isUpdatingLocation = NO;
}

#pragma mark - Methods Related to Being Able to Use Location Access
// This method only returns if location access is disabled and does nothing else
- (BOOL)isLocationAccessDisabled
{
    return NO;
}

#pragma mark - Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    NSDate *now = [NSDate date];
    NSLog(@"%@", now);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle]; // Set date and time styles
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateString = [dateFormatter stringFromDate:now];
    NSLog(@"Position updated at: %@", dateString);
    
    CLLocation *currentLocation = [locations firstObject];
    
    CLLocationCoordinate2D coordinate = currentLocation.coordinate;
    CLLocationDegrees latitude = coordinate.latitude;
    CLLocationDegrees longitude = coordinate.longitude;
    NSString *coords = [[NSString alloc] initWithFormat:@"%@%f%@%f", @"GPS Coords: ", latitude, @", ", longitude];
    NSLog(@"%@", coords);
    NSLog(@"horizontal accuracy: %f", [currentLocation horizontalAccuracy]);
    NSLog(@"vertical accuracy: %f", [currentLocation verticalAccuracy]);
    NSLog(@"distanceFilter: %f", [self.locationManager distanceFilter]);
    NSLog(@"desiredAccuracy in meters: %f", (CLLocationAccuracy)[self.locationManager desiredAccuracy]);
    NSLog(@"timestamp: %@", [currentLocation timestamp]);
    NSLog(@"altitude: %f", [currentLocation altitude]);
    if (currentLocation.course >= 0) {
        NSLog(@"Heading: %f", currentLocation.course);
    }
    if (currentLocation.speed >= 0) {
        NSLog(@"Speed: %f", currentLocation.course);
    }
    
}
@end
