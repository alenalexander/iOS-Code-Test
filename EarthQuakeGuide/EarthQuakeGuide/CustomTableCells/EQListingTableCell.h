//
//  EQListingTableCell.h
//  EarthQuakeGuide
//
//  Created by Alen Alexander on 08/08/19.
//  Copyright © 2019 Alen Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EQListingTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *eqPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *calamityTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *calamityTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *calamityStrengthLabel;


@end

NS_ASSUME_NONNULL_END
