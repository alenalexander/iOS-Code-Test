//
//  EarthQuakeGuideUITests.m
//  EarthQuakeGuideUITests
//
//  Created by Alen Alexander on 08/08/19.
//  Copyright © 2019 Alen Alexander. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EQListViewController.h"
#import "EQListingTableCell.h"

@interface EarthQuakeGuideUITests : XCTestCase

@property XCUIApplication *app;

@end

@implementation EarthQuakeGuideUITests

- (void)setUp {
    self.continueAfterFailure = NO;
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
}

- (void)tearDown {
    self.app = nil;
}

- (void)testEQTableRowSelectionShowsMap {
    XCUIElementQuery *tablesQuery = self.app.tables;
    XCUIElementQuery *cellQuery = [tablesQuery.cells containingType:XCUIElementTypeStaticText
                                                         identifier:@"Magnitude"];
    XCUIElementQuery* cell = [cellQuery childrenMatchingType:XCUIElementTypeStaticText];
    XCUIElement* cellElement = cell.element;
    [cellElement.firstMatch tap];
    XCTAssertNotNil([self.app.maps element]);
}

@end
