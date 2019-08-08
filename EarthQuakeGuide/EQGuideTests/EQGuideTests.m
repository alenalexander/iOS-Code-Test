//
//  EQGuideTests.m
//  EQGuideTests
//
//  Created by Alen Alexander on 08/08/19.
//  Copyright © 2019 Alen Alexander. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../EarthQuakeGuide/ViewControllers/EQListViewController.h"

@interface EQGuideTests : XCTestCase{
    EQListViewController *listVC;

}
@end

@implementation EQGuideTests

- (void)setUp {
    listVC = [[EQListViewController alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    listVC = nil;
}
#pragma mark - EQListViewController Test cases
- (void)testMagnitudeStringFormationSuccessCase{
    NSString *expectedMagnitude = @"Magnitude : 1.17";
    NSString *inputMagString = @"1.17";
    NSString *outputMagString = [listVC returnMagnitudeString:inputMagString];
    NSLog(@"%@      %@",expectedMagnitude,outputMagString);
    XCTAssertEqualObjects(expectedMagnitude, outputMagString,@"Testing magnitude string");
}

- (void)testMagnitudeStringFormationFailureCase{
    NSString *expectedMagnitude = @"Magnitude : 1.11";
    NSString *inputMagString = @"1.17";
    NSString *outputMagString = [listVC returnMagnitudeString:inputMagString];
    NSLog(@"%@      %@",expectedMagnitude,outputMagString);
    XCTAssertNotEqualObjects(expectedMagnitude, outputMagString,@"Testing magnitude string");
}

- (void)testDateFormattingSuccessCase{
    NSString *expectedDateString = @"08/08/2019 06:31 PM";
    double inputTimeStamp = 1565269288730;
    NSString *outputDateString = [listVC formatTime:inputTimeStamp];
    NSLog(@"%@      %@",expectedDateString,outputDateString);
    XCTAssertEqualObjects(expectedDateString, outputDateString,@"Testing Date Formatting");
}

- (void)testDateFormattingFailureCase{
    NSString *expectedDateString = @"08/08/2019 11:31 PM";
    double inputTimeStamp = 1565269288730;
    NSString *outputDateString = [listVC formatTime:inputTimeStamp];
    NSLog(@"%@      %@",expectedDateString,outputDateString);
    XCTAssertNotEqualObjects(expectedDateString, outputDateString,@"Testing Date Formatting");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
