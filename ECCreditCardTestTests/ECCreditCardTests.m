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

@property ECCreditCard *cc;

@end

@implementation ECCreditCardTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.cc = [[ECCreditCard alloc] initWithCreditCardAccountNumber:@"1234567812345678"];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.cc = nil;
    [super tearDown];
}

- (void)testCnCreateECCreditCardClass {
    
    XCTAssertNotNil(self.cc, @"Should be able to create Credit Card");
}

- (void)testCanGiveECCreditCardACardNumber {
    
    XCTAssertEqualObjects(self.cc.accountNumber, @"1234567812345678", @"Should be able to set Credit Card Number");
}

- (void)testForNilParameter {
    
    XCTAssertThrows([[ECCreditCard alloc] initWithCreditCardAccountNumber:nil], @"Should not pass a nil card number");
}

- (void)testCanReadCardIssuerNameForValidAmericanExpress {
    
    ECCreditCard *validAmex = [[ECCreditCard alloc] initWithCreditCardAccountNumber:@"378282246310005"];
    ECCreditCard *validAmex2 = [[ECCreditCard alloc] initWithCreditCardAccountNumber:@"348282246310005"];
    
    XCTAssertEqualObjects(validAmex.issuerName, @"American Express", @"Sould be able to retireve card issuer name for valid AMEX");
    XCTAssertEqualObjects(validAmex2.issuerName, @"American Express", @"Sould be able to retireve card issuer name for valid AMEX");
}

- (void)testUnknownReturnedForInvalidAmexID {
    
    ECCreditCard *unknownAmex = [[ECCreditCard alloc] initWithCreditCardAccountNumber:@"358282246310005"];
    
    XCTAssertEqualObjects(unknownAmex.issuerName, @"Unknown", @"Should return 'Unknown' for invalid issuer");
}


- (void)testCanReadCardIssuerNameForValidDicoverCard {
    
    ECCreditCard *validDiscoverCard = [[ECCreditCard alloc] initWithCreditCardAccountNumber:@"6011000990139424"];
    ECCreditCard *validDiscoverCard2 = [[ECCreditCard alloc] initWithCreditCardAccountNumber:@"6221260990139424"];
    ECCreditCard *validDiscoverCard3 = [[ECCreditCard alloc] initWithCreditCardAccountNumber:@"6451000990139424"];
    
    XCTAssertEqualObjects(validDiscoverCard.issuerName, @"Discover Card",@"Should be able to retrieve card issuer name for valid Discover");
    XCTAssertEqualObjects(validDiscoverCard2.issuerName, @"Discover Card",@"Should be able to retrieve card issuer name for valid Discover");
    XCTAssertEqualObjects(validDiscoverCard3.issuerName, @"Discover Card",@"Should be able to retrieve card issuer name for valid Discover");
}

- (void)testUnknownReturnedForInvalidDiscoverID {
    
    ECCreditCard *unknownDiscover = [[ECCreditCard alloc] initWithCreditCardAccountNumber:@"6012000990139424"];
    
    XCTAssertEqualObjects(unknownDiscover.issuerName, @"Unknown", @"Should return 'Unknown' for invalid issuer");
}


- (void)testCanReadCardIssuerNameForValidMasterCard {
    
    ECCreditCard *validMasterCard = [[ECCreditCard alloc] initWithCreditCardAccountNumber:@"5555555555554444"];
    ECCreditCard *validMasterCard2 = [[ECCreditCard alloc] initWithCreditCardAccountNumber:@"2221555555554444"];
    
    XCTAssertEqualObjects(validMasterCard.issuerName, @"MasterCard", @"Should be able to retrieve card issuer name for valid MasterCard");
    XCTAssertEqualObjects(validMasterCard2.issuerName, @"MasterCard", @"Should be able to retrieve card issuer name for valid MasterCard");
}

- (void)testUnknownReturnedForInvalidMasterCardID {
    
    ECCreditCard *unknownMasterCard = [[ECCreditCard alloc] initWithCreditCardAccountNumber:@"2220555555554444"];
    
    XCTAssertEqualObjects(unknownMasterCard.issuerName, @"Unknown", @"Should return 'Unknown' for invalid issuer");
}


- (void)testCanReadCardissuerNameForValidVisaCard {
    
    ECCreditCard *validVisaCard = [[ECCreditCard alloc] initWithCreditCardAccountNumber:@"4012888888881881"];
    
    XCTAssertEqualObjects(validVisaCard.issuerName, @"Visa", @"Should be able to retrieve card issuer name for valid visa card");
}

- (void)testForUnknownIssuerName {
    
    XCTAssertEqualObjects(self.cc.issuerName, @"Unknown", @"Should return 'Unknown' for invalid issuer");
    
}

@end
