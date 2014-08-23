//
//  MapViewController.h
//  Hackathon2014
//
//  Created by Swiss App Innovation on 23.08.14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Adress.h"

@interface MapViewController : UIViewController <UIActionSheetDelegate, CLLocationManagerDelegate, MKMapViewDelegate>


@property int seconds;
@property float distance;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) NSTimer *timer;
- (IBAction)selfAction:(id)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)startRaetsel:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *startRaetselButton;

@end
