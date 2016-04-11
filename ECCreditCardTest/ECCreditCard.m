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

/**
 *  Constants
 */
static NSString * const kErrorDomain = @"uk.co.ironworksmedialimited";
static const NSUInteger kAmexLength = 15;
static const NSUInteger kDiscoverShortLength = 16;
static const NSUInteger kDiscoverLongLength = 19;
static const NSUInteger kMasterCardLength = 16;
static const NSUInteger kVisaShortLength = 13;
static const NSUInteger kVisaMedLength = 16;
static const NSUInteger kVisaLongLength = 19;

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

- (BOOL)isValidLength {
    
    switch (self.issuer) {
        case ECCreditCardIssuerAmericanExpress:
        {
            if (self.accountNumber.length == kAmexLength) {
                return YES;
            } else {
                return NO;
            }
        }
            break;
        
        case ECCreditCardIssuerDiscoverCard:
        {
            if (self.accountNumber.length == kDiscoverShortLength ||
                self.accountNumber.length == kDiscoverLongLength) {
                return YES;
            } else {
                return NO;
            }
        }
            
        case ECCreditCardIssuerMasterCard:
        case ECCreditCardIssuerMasterCardType2:
        {
            if (self.accountNumber.length == kMasterCardLength) {
                return YES;
            } else {
                return NO;
            }
        }
            
        case ECCreditCardIssuerVisa:
        {
            if (self.accountNumber.length == kVisaShortLength ||
                self.accountNumber.length == kVisaMedLength ||
                self.accountNumber.length == kVisaLongLength) {
                return YES;
            } else {
                return NO;
            }
        }
        default:
            return NO; //Assumption: Unknown provider is always an invalid length
            break;
    }
}



-(BOOL)isValidCheckDigit {
    
    //Luhn Algorithm
    BOOL isOdd = YES;
    int oddSum = 0;
    int evenSum = 0;
    
    for (NSInteger i = self.accountNumber.length - 1; i >= 0; i--) {
        
        NSInteger digit = [[self.accountNumber substringWithRange:NSMakeRange(i, 1)] intValue];
        
        if (isOdd)
            oddSum += digit;
        else
            evenSum += digit/5 + (2 * digit) % 10;
        
        isOdd = !isOdd;
    }
    
    return ((oddSum + evenSum) % 10 == 0);

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

- (BOOL)isValidWithError:(NSError **)error {
    
    if ([self isValidLength]) {
        if ([self isValidCheckDigit]) {
            return YES;
        } else {
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            errorDetail[NSLocalizedDescriptionKey] = @"Invalid account check digit";
            *error = [NSError errorWithDomain:kErrorDomain code:ECErrorCodeInvalidCheckDigit userInfo:errorDetail];
            return NO;
        }
    } else {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        errorDetail[NSLocalizedDescriptionKey] = @"Invalid account length";
        *error = [NSError errorWithDomain:kErrorDomain code:ECErrorCodeInvalidLength userInfo:errorDetail];
        return NO;

    }
    
    return YES;
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
