//
//  ViewController.h
//  Calculaor2
//
//  Created by Ankit on 2/2/16.
//  Copyright © 2016 Eb Pearls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculate.h"
@interface ViewController : UIViewController
{
    NSMutableString *displayString;
    int currentNumber;
    char op;
    BOOL firstOperand,isNumerator,fromEql;
    BOOL numSet;
    BOOL valueSet;
    Calculate *myCalculator;
}

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (retain,nonatomic) NSMutableString *displayString;


-(void)clear;

-(IBAction)click:(id)sender;

-(void)processDigit:(int)digit;
-(void)processOp:(char)theOp;
-(void)storeFract;

- (IBAction)clickPlus:(id)sender;
- (IBAction)clickMinus:(id)sender;
- (IBAction)clickMul:(id)sender;
- (IBAction)clickDiv:(id)sender;

- (IBAction)clickOver:(id)sender;
- (IBAction)clickEql:(id)sender;
- (IBAction)clickC:(id)sender;


@end

