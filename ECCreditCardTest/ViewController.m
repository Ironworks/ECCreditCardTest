//
//  ViewController.m
//  ECCreditCardTest
//
//  Created by Trevor Doodes on 11/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "ViewController.h"
#import "ECCreditCard.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountNumberTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

- (IBAction)verifyButtonPressed:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)verifyButtonPressed:(id)sender {
    
    if (self.accountNumberTextField.text.length == 0) {
        return;
    }
    
    ECCreditCard *cardToVerify = [[ECCreditCard alloc] initWithCreditCardAccountNumber:self.accountNumberTextField.text];
    
    NSError *error;
    if ([cardToVerify isValidWithError:&error]) {
        self.resultLabel.text = [NSString stringWithFormat:@"Card Number %@ is a valid %@ card",cardToVerify.accountNumber, cardToVerify.issuerName];
    } else {
        //Verification failed
        if (error) {
            self.resultLabel.text = [NSString stringWithFormat:@"Card number %@ is invalid. %@", cardToVerify.accountNumber, error.localizedDescription];

        } else {
            self.resultLabel.text = @"Card is invalid. Unknown error!";
        }
    }
}
@end
