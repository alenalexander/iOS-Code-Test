//
//  EQListViewController.h
//  EarthQuakeGuide
//
//  Created by Alen Alexander on 08/08/19.
//  Copyright © 2019 Alen Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericConstants.h"
#import "EQListingTableCell.h"
#import "AFHTTPSessionManager.h"
#import "EQGMapViewController.h"

@interface EQListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *eqListingTableView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loaderIndicator;
@property (strong, nonatomic) NSArray* calamityDetailsArray;

-(void)loadListView;
-(NSString*)formatTime:(double)timeStamp;


@end

