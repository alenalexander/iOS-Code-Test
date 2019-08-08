//
//  EQGMapViewController.m
//  EarthQuakeGuide
//
//  Created by Alen Alexander on 08/08/19.
//  Copyright © 2019 Alen Alexander. All rights reserved.
//

#import "EQGMapViewController.h"

@interface EQGMapViewController ()

@end

@implementation EQGMapViewController

@synthesize loaderIndicator;
@synthesize calamityMapView;
@synthesize calamityDetails;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadCalamityAreaOnMap];
}

/**
 Load the map with provided location details.
 **/
-(void)loadCalamityAreaOnMap{
    [self.loaderIndicator setHidden:false];
    [self.loaderIndicator startAnimating];
    
    self.calamityMapView.delegate = self;
    [self setPropertiesOfMap];
}

-(void)setPropertiesOfMap{
    NSString* place = [[self.calamityDetails valueForKey:EQPROPERTIES] valueForKey:EQPLACE];
    NSArray* coordiante = [[self.calamityDetails valueForKey:EQGEOMETRY] valueForKey:EQCOORDINATE];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.5;
    span.longitudeDelta = 0.5;
    CLLocationCoordinate2D location;
    location.latitude = [[coordiante objectAtIndex:1] doubleValue];
    location.longitude= [[coordiante objectAtIndex:0]doubleValue];
    region.span = span;
    region.center = location;
    [self.calamityMapView setRegion:region animated:YES];
    calamityMapView.showsUserLocation = YES;
    calamityMapView.mapType = MKMapTypeStandard;
    // Add an annotation on the MKMapView with the selected place's cordinates.
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    point.title = place;
    [calamityMapView addAnnotation:point];
}

#pragma mark - MAPVIEW DELEGATE METHODS

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    [self.loaderIndicator stopAnimating];
    [self.loaderIndicator setHidden:true];
}

-(void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [self.loaderIndicator stopAnimating];
    [self.loaderIndicator setHidden:true];
}

@end
