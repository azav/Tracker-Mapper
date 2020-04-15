//
//  MapViewController.h
//  Tracker Mapper
//
//  Created by Alex Zavatone on 8/17/17.
//  Copyright © 2017 Alex Zavatone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GeoLocationManager.h"

@interface MapViewController : UIViewController

@property (nonatomic, strong) GeoLocationManager *geoLocationManager;

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UITextView *textOutput;
@property (nonatomic, weak) IBOutlet UIButton *start;
@property (nonatomic, weak) IBOutlet UIButton *stop;

- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;

- (void)updateUI;



@end
