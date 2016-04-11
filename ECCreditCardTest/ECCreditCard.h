//
//  ECCreditCard.h
//  ECCreditCardTest
//
//  Created by Trevor Doodes on 11/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface ECCreditCard : NSObject

/**
 *  Credit Card Account Number
 */
@property (nonatomic, copy, readonly) NSString *accountNumber;

/**
 *  Credit Card Issuer Name
 */
@property (nonatomic, copy, readonly) NSString *issuerName;

/**
 *  Initialiser for ECCreditCard
 *
 *  @param accountNumber The Account number for the Credit Card
 *
 *  @return An instance of ECCreditCard
 */
- (instancetype) initWithCreditCardAccountNumber:(NSString *)accountNumber;
@end
