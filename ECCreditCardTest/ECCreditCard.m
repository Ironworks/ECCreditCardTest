//
//  ECCreditCard.m
//  ECCreditCardTest
//
//  Created by Trevor Doodes on 11/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "ECCreditCard.h"

/**
 *  Credit Card Issuer names
 */
typedef NS_ENUM(NSUInteger, ECCreditCardIssuer) {
    /**
     *  American Express
     */
    ECCreditCardIssuerAmericanExpress = 3,
    /**
     *  Discover
     */
    ECCreditCardIssuerDiscoverCard = 6,
    /**
     *  MasterCard
     */
    ECCreditCardIssuerMasterCard = 2,
    /*
     *  MasterCardType2
     */
    ECCreditCardIssuerMasterCardType2 = 5,
    /**
     *  Visa
     */
    ECCreditCardIssuerVisa = 4,
    /**
     *  Unknown
     */
    ECCreditCardIssuerUnknown = 0
};



@interface ECCreditCard ()

@property (nonatomic, assign) ECCreditCardIssuer issuer;

@end

@implementation ECCreditCard


#pragma mark - Private Methods
- (NSUInteger) issuerNumberFirstNumberOfDigits:(NSUInteger)digits {
    
    NSString *issuerPrefix = [self.accountNumber substringWithRange:NSMakeRange(0, digits)];
    return [issuerPrefix intValue];
}


- (BOOL)isAmericanExpress {
    
    if ([self issuerNumberFirstNumberOfDigits:2] == 34 ||
        [self issuerNumberFirstNumberOfDigits:2] == 37) {
        return YES;
    }
    
    return NO;
    
}

- (BOOL)isDiscoverCard {
    
    //Test for 4 digit identifier
    //then 6 digit identifier
    //then 3 digit identifier
    //and finally 65
    if ([self issuerNumberFirstNumberOfDigits:4] == 6011) {
        return YES;
    } else if  ([self issuerNumberFirstNumberOfDigits:6] >= 622126 &&
                [self issuerNumberFirstNumberOfDigits:6] <= 622925) {
        return YES;
    } else if ([self issuerNumberFirstNumberOfDigits:3] >= 644 &&
               [self issuerNumberFirstNumberOfDigits:3] <= 649) {
        return YES;
    } else {
        return [self issuerNumberFirstNumberOfDigits:2] == 65;
    }
    
}

- (BOOL)isMasterCard {
    
    //Test for 4 digit identifier, then for 2 digit identifier
    if ([self issuerNumberFirstNumberOfDigits:4] >= 2221 &&
        [self issuerNumberFirstNumberOfDigits:4] <= 2720) {
        return YES;
    } else {
        return ([self issuerNumberFirstNumberOfDigits:2] >= 51 &&
                [self issuerNumberFirstNumberOfDigits:2] <=55);
    }
    
}


- (BOOL)isVisa {
    
    //First digit is 4
    if ([self issuerNumberFirstNumberOfDigits:1] == 4) {
        return YES;
    } else {
        return NO;
    }
}

- (ECCreditCardIssuer)deriveIssuerType {
    
    NSUInteger prefixDigit = [[self.accountNumber substringWithRange:NSMakeRange(0, 1)] intValue];
    ECCreditCardIssuer issuer;
    
    switch (prefixDigit) {
        case ECCreditCardIssuerAmericanExpress: {
            if ([self isAmericanExpress]) {
                issuer = ECCreditCardIssuerAmericanExpress;
            } else {
                issuer = ECCreditCardIssuerUnknown;
            }
        }
            break;
            
        case ECCreditCardIssuerDiscoverCard: {
            if ([self isDiscoverCard]) {
                issuer = ECCreditCardIssuerDiscoverCard;
            } else {
                issuer = ECCreditCardIssuerUnknown;
            }
        }
            break;
            
        case ECCreditCardIssuerMasterCard:
        case ECCreditCardIssuerMasterCardType2: {
            if ([self isMasterCard]) {
                issuer = ECCreditCardIssuerMasterCard;
            } else {
                issuer = ECCreditCardIssuerUnknown;
            }
        }
            break;
            
            
        case ECCreditCardIssuerVisa:{
            if ([self isVisa]) {
                issuer = ECCreditCardIssuerVisa;
            } else {
                issuer = ECCreditCardIssuerUnknown;
            }
        }
            break;
            
        default:
            issuer = ECCreditCardIssuerUnknown;
            break;
    }
    
    return issuer;
}

#pragma mark - Public Methods
- (instancetype) initWithCreditCardAccountNumber:(NSString *)accountNumber {
    
    NSParameterAssert(accountNumber != nil);
    
    if (self = [super init]) {
        _accountNumber = [accountNumber copy];
        _issuer = [self deriveIssuerType];
    }
    
    return self;
}

#pragma mark - Accessor Methods
- (NSString *)issuerName {
    
    switch (self.issuer) {
        case ECCreditCardIssuerAmericanExpress:
            return @"American Express";
            break;
         
        case ECCreditCardIssuerDiscoverCard:
            return @"Discover Card";
            break;
            
        case ECCreditCardIssuerMasterCard:
        case ECCreditCardIssuerMasterCardType2:
            return @"MasterCard";
            break;
            
        case ECCreditCardIssuerVisa:
            return @"Visa";
            break;
            
        case ECCreditCardIssuerUnknown:
            return @"Unknown";
            
        default:
            return @"Unknown";
            break;
    }
}

@end
