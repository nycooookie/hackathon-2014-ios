//
//  MapViewController.m
//  Hackathon2014
//
//  Created by Swiss App Innovation on 23.08.14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import "MapViewController.h"
#import "MathController.h"

@interface MapViewController ()

- (void)initializeMap;
- (void)getPins;
- (NSInteger)checkTaskNo;
- (void)getRouteForTask:(NSInteger)task;
- (void)checkDestinationforTask:(NSInteger)task;

@end

@implementation MapViewController
@synthesize mapView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Debug
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"currentLocation"];
    self.locations = [NSMutableArray array];
    self.mapView.delegate = self;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    [self getPins];
    [self getRouteForTask:[self checkTaskNo]];
}
- (void)initializeMap {
    
}
- (void)checkDestinationforTask:(NSInteger)task {
    for (Adress *adress in self.locations) {
        if (adress.taskNo == task) {
            CLLocationCoordinate2D coord1 = self.mapView.userLocation.location.coordinate;
            
            CLLocation *P1 = [[CLLocation alloc] initWithLatitude:coord1.latitude longitude:coord1.longitude];
            CLLocation *P2 = [[CLLocation alloc] initWithLatitude:adress.laengengrad longitude:adress.breitengrad];
            CLLocationDistance  distance = [P1 distanceFromLocation:P2];
            
            if (distance < 10) {
                // Close enough
                NSLog(@"Nah Genug");
                self.startRaetselButton.tintColor = [UIColor blueColor];
            } else {
                // Too fare away
                NSLog(@"Nicht Nah genug");
                self.startRaetselButton.tintColor = [UIColor grayColor];
            }

        }
    }
    
}
- (void)getPins {
    if (self.locations.count == 0) {
        [self.locations addObject:[[Adress alloc] initWithTaskNo:0 laengengrad:47.140405 undbreitengrad:9.519163]]; // Rathaus Vaduz;
        [self.locations addObject:[[Adress alloc] initWithTaskNo:1 laengengrad:47.139439 undbreitengrad:9.521888]]; // Kunstmuseum Vaduz;
        [self.locations addObject:[[Adress alloc] initWithTaskNo:2 laengengrad:47.139702 undbreitengrad:9.522768]]; // Kathedrale St. Florin
    }
    for (Adress * adress in self.locations) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(adress.laengengrad, adress.breitengrad);
        MKPlacemark *placeM = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
        [self.mapView addAnnotation:placeM];
    }
}
- (NSInteger)checkTaskNo {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"currentLocation"];
}
- (void)getRouteForTask:(NSInteger)task {
    for (Adress *adress in self.locations) {
        if (adress.taskNo == task) {
            
            MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
            request.source = [MKMapItem mapItemForCurrentLocation];
            request.requestsAlternateRoutes = NO;
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(adress.laengengrad, adress.breitengrad);
            MKPlacemark *sourcePlacemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
            MKMapItem *adress = [[MKMapItem alloc] initWithPlacemark:sourcePlacemark];
            
            request.destination = adress;
            MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
            [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                if (error) {
                    NSLog(@"Error");
                } else {
                    [self showRoute:response];
                    [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"currentLocation"] +1 forKey:@"currentLocation"];
                    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"currentLocation"] > 2) {
                        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"currentLocation"];
                    }
                }
            }];
        }
    }
    
}
- (void)showRoute:(MKDirectionsResponse *)response {
    for (MKRoute *route in response.routes) {
        [self.mapView removeOverlays:self.mapView.overlays];
        [self.mapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
    }
}
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *route = overlay;
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:route];
        routeRenderer.strokeColor = [UIColor blueColor];
        return routeRenderer;
    }
    else return nil;
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self checkDestinationforTask:[self checkTaskNo]];
}
- (IBAction)selfAction:(id)sender {
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}

- (IBAction)nextAction:(id)sender {
    [self getRouteForTask:[self checkTaskNo]];
}

- (IBAction)startRaetsel:(id)sender {
    
}
@end
