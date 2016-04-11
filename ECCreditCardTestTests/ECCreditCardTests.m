//
//  ECCreditCardTests.m
//  ECCreditCardTest
//
//  Created by Trevor Doodes on 11/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ECCreditCard.h"
@interface ECCreditCardTests : XCTestCase

@end

@implementation ECCreditCardTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCnCreateECCreditCardClass {
    
    ECCreditCard *cc = [[ECCreditCard alloc] init];
    
    XCTAssertNotNil(cc, @"Should be able to create Credit Card");
}


@end
