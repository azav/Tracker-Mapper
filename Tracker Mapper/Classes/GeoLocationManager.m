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
    
    // Start recording.
   // [self.dataStorage ];
}

- (void)stop
{
    [self.locationManager stopUpdatingLocation];
    _isUpdatingLocation = NO;
    
    //Stop recording location data and tell data object to stop recording and serialize to Docs folder.
   // [self.dataStorage ];
    
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
    NSLog(@"––––––––––––");
    NSLog(@"Position updated at: %@", dateString);
    
    CLLocation *currentLocation = [locations firstObject];
    
    CLLocationCoordinate2D coordinate = currentLocation.coordinate;
    CLLocationDegrees latitude = coordinate.latitude;
    CLLocationDegrees longitude = coordinate.longitude;
    NSString *coords = [[NSString alloc] initWithFormat:@"%@%f%@%f", @"GPS Coords: ", latitude, @", ", longitude];
    NSDictionary *latLong = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithDouble:latitude], @"latitude",
                             [NSNumber numberWithDouble:latitude], @"longitude",                                    nil];
    
    NSLog(@"%@", coords);
    NSLog(@"horizontal accuracy: %f", [currentLocation horizontalAccuracy]);
    NSLog(@"vertical accuracy: %f", [currentLocation verticalAccuracy]);
    NSLog(@"distanceFilter: %f", [self.locationManager distanceFilter]);
    NSLog(@"desiredAccuracy: %f", (CLLocationAccuracy)[self.locationManager desiredAccuracy]);
    NSLog(@"timestamp: %@", [currentLocation timestamp]);
    NSLog(@"altitude: %f", [currentLocation altitude]);
    if (currentLocation.course >= 0) {
        NSLog(@"Heading: %f", currentLocation.course);
    }
    if (currentLocation.speed >= 0) {
        NSLog(@"Speed: %f", currentLocation.speed);
    }
    
    // Store formatted string for all that.
    // Add this to a block and dispatch if too slow.
    NSMutableString *latestCoordAsString;
  
    latestCoordAsString = [NSMutableString stringWithFormat:@"%@%@\r%@%@\r%@\%f\r%@\%f\r%@\%f\r%@\%f\r%@\%@\r%@\%f\r",
                           @"Position updated at: ", dateString,
                           @"", coords,
                           @"Horizontal accuracy: ", [currentLocation horizontalAccuracy],
                           @"Vertical accuracy: ", [currentLocation verticalAccuracy],
                           @"DistanceFilter: ", [self.locationManager distanceFilter],
                           @"DesiredAccuracy: ", (CLLocationAccuracy)[self.locationManager desiredAccuracy],
                           @"Timestamp: ", [currentLocation timestamp],
                           @"Altitude: ", [currentLocation altitude]];

    if (currentLocation.course >= 0) {
        [latestCoordAsString appendFormat:@"%@\%f\r", @"Heading: ", currentLocation.course ];
    }
    if (currentLocation.speed >= 0) {
         [latestCoordAsString appendFormat:@"%@\%f\r", @"Speed: ", currentLocation.speed ];
    }
    self.latestCoordString = [latestCoordAsString copy];
    
    // Build coord dictionary
    NSMutableDictionary *coordEvent = [NSMutableDictionary dictionary];
    [coordEvent setObject:dateString forKey:@"formatted timestamp"];
    [coordEvent setObject:dateString forKey:[currentLocation timestamp]];
    [coordEvent setObject:latLong forKey:@"coords"];
    [coordEvent setObject: [NSNumber numberWithDouble:[currentLocation horizontalAccuracy]] forKey:@"horizontal accuracy"];
    [coordEvent setObject: [NSNumber numberWithDouble:[currentLocation verticalAccuracy]] forKey:@"vertical accuracy"];
    [coordEvent setObject: [NSNumber numberWithDouble:[self.locationManager distanceFilter]] forKey:@"distance filter"];
    [coordEvent setObject: [NSNumber numberWithDouble:[self.locationManager desiredAccuracy]] forKey:@"desiredAccuracy"];
    [coordEvent setObject: [NSNumber numberWithDouble:[currentLocation altitude]] forKey:@"altitude in meters"];
    [coordEvent setObject: [NSNumber numberWithDouble:[currentLocation altitude]] forKey:@"altitude in meters"];
    if (currentLocation.course >= 0) {
        [coordEvent setObject: [NSNumber numberWithDouble:[currentLocation course]] forKey:@"heading"];
    }
    if (currentLocation.speed >= 0) {
        [coordEvent setObject: [NSNumber numberWithDouble:[currentLocation speed]] forKey:@"speed in m/s"];
    }
    
    // return this so that it can be added
    self.latestCoordDict = [coordEvent copy];
    nil;
    
    
}
@end
