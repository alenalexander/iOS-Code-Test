//
//  EQListViewController.m
//  EarthQuakeGuide
//
//  Created by Alen Alexander on 08/08/19.
//  Copyright © 2019 Alen Alexander. All rights reserved.
//

#import "EQListViewController.h"

@interface EQListViewController ()

@end

@implementation EQListViewController

@synthesize eqListingTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    
}

- (void)setUpTableView{
//    self.eqListingTableView.estimatedRowHeight = 100;
//    self.eqListingTableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma- TABLEVIEW HANDLERS

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return EQCELLHEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EQListingTableCell *cell = (EQListingTableCell*)[tableView dequeueReusableCellWithIdentifier:EQLISTINGCELL];
    return cell;
}

@end
