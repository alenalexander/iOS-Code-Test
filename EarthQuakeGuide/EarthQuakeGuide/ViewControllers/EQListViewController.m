//
//  EQListViewController.m
//  EarthQuakeGuide
//
//  Created by Alen Alexander on 08/08/19.
//  Copyright © 2019 Alen Alexander. All rights reserved.
//

#import "EQListViewController.h"

@interface EQListViewController ()
{
    NSDictionary *selectedCalamityDetails;
}
@end

@implementation EQListViewController

@synthesize eqListingTableView;
@synthesize infoLabel;
@synthesize loaderIndicator;
@synthesize calamityDetailsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calamityDetailsArray = [[NSArray alloc]init];
    self.eqListingTableView.delegate = self;
    self.eqListingTableView.dataSource = self;
    [self loadListView];
}

#pragma mark - HELPER METHODS

/**
 Load UI
 **/
-(void)loadListView{
    [self setUIStates];
    [self fetchCalamityDetails:^(NSDictionary *result) {
        self.calamityDetailsArray = [[NSArray alloc]initWithArray:[result valueForKey:EQFEATURES]];
        [self handleResult];
    } failure:^(NSError *error) {
        [self handleErrorScenario];
    }];
    
}

- (void)setUIStates{
    [self.eqListingTableView setHidden:true];
    [infoLabel setHidden:true];
    [loaderIndicator setHidden:false];
    [loaderIndicator startAnimating];
}

- (void)handleResult{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.eqListingTableView setHidden:false];
        [self.eqListingTableView reloadData];
        [self.loaderIndicator setHidden:true];
        [self.loaderIndicator stopAnimating];
    });
    
}

- (void)handleErrorScenario{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.infoLabel setHidden:false];
        [self.loaderIndicator setHidden:true];
        [self.loaderIndicator stopAnimating];
    });
}

/**
 Retrieve details of calamities
 @param success A block that handles result when the task finishes successfully.
 @param failure A block that handles the scenario when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data.
 **/
-(void)fetchCalamityDetails:(void (^)(NSDictionary* result))success failure:(void (^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:GETCALAMITYDETAILSURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(nil);
    }];
}


#pragma mark - TABLEVIEW HANDLERS

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.calamityDetailsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return EQCELLHEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EQListingTableCell *cell = (EQListingTableCell*)[tableView dequeueReusableCellWithIdentifier:EQLISTINGCELL];
    
    cell.eqPlaceLabel.text = [[[calamityDetailsArray objectAtIndex:indexPath.row] valueForKey:EQPROPERTIES] valueForKey:EQPLACE];
    cell.calamityTypeLabel.text = [[[calamityDetailsArray objectAtIndex:indexPath.row] valueForKey:EQPROPERTIES] valueForKey:EQTYPE];
    NSString * strength = [[[[calamityDetailsArray objectAtIndex:indexPath.row] valueForKey:EQPROPERTIES] valueForKey:EQMAGNITUDE] stringValue];
    cell.calamityStrengthLabel.text = [self returnMagnitudeString:strength];
    double time = [[[[calamityDetailsArray objectAtIndex:indexPath.row] valueForKey:EQPROPERTIES] valueForKey:EQTIME] doubleValue];
    cell.calamityTimeLabel.text = [self formatTime:time];
    
    return cell;
}

-(NSString *)returnMagnitudeString:(NSString *)magString{
    if ([magString isKindOfClass:[NSString class]] && magString.length > 0) {
        NSRange stringRange = {0, MIN([magString length], 4)};
        stringRange = [magString rangeOfComposedCharacterSequencesForRange:stringRange];
        NSString *shortStrength= [magString substringWithRange:stringRange];
        return  [NSString stringWithFormat:@"%@ : %@",EQMAGNITUDEFULL, shortStrength];
    } else{
        return [NSString stringWithFormat:@"%@ : Unknown",EQMAGNITUDEFULL];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    selectedCalamityDetails = [calamityDetailsArray objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:EQMAPLOADER sender:indexPath];
}

#pragma mark - Navigation Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:EQMAPLOADER])
    {
        EQGMapViewController *mapVC = (EQGMapViewController*)segue.destinationViewController;
        mapVC.calamityDetails =  selectedCalamityDetails;
    }
}

#pragma mark - Utility Methods
/**
 Format time from timestamp
 @param timeStamp timestamp in millisecond.
 @return date in string format.
 **/
-(NSString*)formatTime:(double)timeStamp
{
    NSTimeInterval timeInterval = timeStamp/1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:EQDATEFORMAT];
    return [dateformatter stringFromDate:date];
}

@end
