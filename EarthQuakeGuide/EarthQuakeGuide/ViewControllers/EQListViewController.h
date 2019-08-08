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

@interface EQListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *eqListingTableView;


@end

