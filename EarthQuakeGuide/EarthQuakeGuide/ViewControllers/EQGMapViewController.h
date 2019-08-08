//
//  EQGMapViewController.h
//  EarthQuakeGuide
//
//  Created by Alen Alexander on 08/08/19.
//  Copyright © 2019 Alen Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GenericConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface EQGMapViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *calamityMapView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loaderIndicator;
@property (weak, nonatomic)  NSDictionary *calamityDetails;

-(void)loadCalamityAreaOnMap;

@end

NS_ASSUME_NONNULL_END
