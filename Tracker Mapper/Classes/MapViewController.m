//
//  MapViewController.m
//  Tracker Mapper
//
//  Created by Alex Zavatone on 8/17/17.
//  Copyright © 2017 Alex Zavatone. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _geoLocationManager = [GeoLocationManager sharedInstance];
    // Do any additional setup after loading the view.
    
    [self updateUI];
}

- (void)updateUI
{
    self.start.enabled = !self.geoLocationManager.isUpdatingLocation;
    self.stop.enabled = self.geoLocationManager.isUpdatingLocation;
    
    self.start.alpha =  1 - (self.geoLocationManager.isUpdatingLocation / 2.0);
    self.stop.alpha =  .5 + (self.geoLocationManager.isUpdatingLocation / 2.0);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)start:(id)sender
{
    [self.geoLocationManager start];
    [self startObserving];
    [self updateUI];
}

- (IBAction)stop:(id)sender
{
    [self.geoLocationManager stop];
    [self stopObserving];
    [self updateUI];
}

- (void)startObserving
{
    [self.geoLocationManager observationInfo];
    if(![self.geoLocationManager observationInfo])
    {
    [self.geoLocationManager addObserver:self forKeyPath:@"latestCoordString" options:NSKeyValueObservingOptionNew context:nil];
    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self.geoLocationManager.latestCoordString
//                                             selector:@selector(updateCoordReadout)
//                                                 name:@"updateCrewReadout"
//                                               object:nil];
    
  //  [self.myObject addObserver:self forKeyPath:@"data" options:NSKeyValueObservingOptionNew context:nil];
    
}

// This will break if the screen is navigated away from.
// Move to the data object
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self updateCoordReadout];
}


- (void)stopObserving
{
     if(![self.geoLocationManager observationInfo])
     {
         [self.geoLocationManager removeObserver:self forKeyPath:@"latestCoordString"];
     }
}

- (void)updateCoordReadout
{
    self.textOutput.text = self.geoLocationManager.latestCoordString;
}

@end
