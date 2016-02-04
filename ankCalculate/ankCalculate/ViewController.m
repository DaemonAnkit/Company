//
//  ViewController.m
//  Calculaor2
//
//  Created by Ankit on 2/2/16.
//  Copyright © 2016 Eb Pearls. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize displayString;

- (void)viewDidLoad {
    [super viewDidLoad];
    currentNumber=0;
    firstOperand=YES;
    isNumerator=YES;
    fromEql=NO;
    valueSet=NO;
    numSet=NO;
    self.displayString=[NSMutableString stringWithCapacity:40];
    myCalculator=[[Calculate alloc] init];
   
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)click:(id)sender
{
    UIButton *button = (UIButton *) sender;
    int digit=(int)[button tag];
    [self processDigit:digit];
    valueSet=YES;
    fromEql=NO;
    //self.display.text=[NSString stringWithFormat:@"%d",digit];

}

-(void)processDigit:(int)digit
{
    currentNumber=currentNumber*10+digit;
    [self.displayString appendString:[NSString stringWithFormat:@"%d",digit]];
    self.display.text=self.displayString;
}

-(void)processOp:(char)theOp
{
    if(isNumerator==NO)
    {
         myCalculator.accumulator.isInfinity=YES;
        firstOperand =YES;
        valueSet=NO;
        [myCalculator clear];
       
    }
    if(fromEql==YES || firstOperand==NO)
    {
        if(fromEql==NO)
        {
            [self storeFract];
            [myCalculator performOperation:op];
        }
        
        [self.displayString setString:[myCalculator.accumulator convertToString]];
        
        if(myCalculator.accumulator.isInfinity==NO)
        {
            NSLog(@"no");
            firstOperand=YES;
            
            isNumerator=YES;
            currentNumber=myCalculator.accumulator.numerator;
            valueSet=YES;
            [self storeFract];
            firstOperand=YES;
            isNumerator=NO;
            currentNumber=myCalculator.accumulator.denominator;
            valueSet=YES;

        }
        else{
             NSLog(@"yes");
            
            [self.displayString setString:@"Invalid Value"];
            self.display.text=self.displayString;
            [self clear];
            [myCalculator clear];
            valueSet=NO;
            return;
        }
        
        fromEql=NO;
    }
    NSString *opStr;
    op=theOp;
    switch (theOp) {
        case '+':
            opStr=@"+";
            break;
        case '-':
            opStr=@"-";
            break;
        case '*':
            opStr=@"x";
            break;
        case '/':
            opStr=@"/";
            break;
            
        default:
            break;
    }
    
    [self storeFract];
    firstOperand=NO;
    isNumerator=YES;
    numSet=NO;
    [displayString appendString:opStr];
    self.display.text=self.displayString;
    
}

-(void)storeFract
{
    if(valueSet==YES)
    {
        if(firstOperand)
        {
            
            if(isNumerator)
            {
                myCalculator.operand1.numerator=currentNumber;
                myCalculator.operand1.denominator=1;
                myCalculator.operand1.isSet=YES;
                numSet=YES;
            }
            else
            {
                if(myCalculator.operand1.isSet==YES)
                myCalculator.operand1.denominator=currentNumber;
                isNumerator=YES;
                numSet=NO;
            }
            
            
        }
        else
        {
            if(isNumerator)
            {
                myCalculator.operand2.numerator=currentNumber;
                myCalculator.operand2.denominator=1;
                myCalculator.operand2.isSet=YES;
                numSet=YES;
            }
            else
            {
                if(myCalculator.operand2.isSet==YES)
                myCalculator.operand2.denominator=currentNumber;
                isNumerator=YES;
                numSet=NO;
                //firstOperand=YES;
            }
            
            
        }

    }
    valueSet=NO;
    currentNumber=0;
}

- (IBAction)clickPlus:(id)sender {
    [self processOp:'+'];
}

- (IBAction)clickMinus:(id)sender {
    [self processOp:'-'];
}

- (IBAction)clickMul:(id)sender {
    [self processOp:'*'];
}

- (IBAction)clickDiv:(id)sender {
    [self processOp:'/'];
}

- (IBAction)clickOver:(id)sender {
    if(fromEql==YES)
    {
        /*[self.displayString setString:[myCalculator.accumulator convertToString]];
        firstOperand=YES;
        
        isNumerator=YES;
        currentNumber=myCalculator.accumulator.numerator;
        [self storeFract];
        firstOperand=YES;
        isNumerator=NO;
        currentNumber=myCalculator.accumulator.denominator;
        firstOperand=NO;
        fromEql=NO;*/
       [self processOp:'/'];

    }
    else
    {
        [self storeFract];
        [self.displayString appendString:@"/"];
        self.display.text=self.displayString;
        isNumerator=NO;
        valueSet=NO;
        //if(numSet)
        

    }
    
    
}

- (IBAction)clickEql:(id)sender {
    if(firstOperand == NO){
        
        [self storeFract];
        [myCalculator performOperation:op];
        if(myCalculator.accumulator.isInfinity==NO  )
        {
            [self.displayString appendString:@"="];
            [self.displayString appendString:[myCalculator.accumulator convertToString]];
             self.display.text = self.displayString;

        }
        else{
            [self.displayString setString:@"Invalid Value"];
            self.display.text = self.displayString;
            [self clear];
            [myCalculator clear];
            fromEql=NO;
             valueSet=NO;
            return;
          
            


            
        }
       
        [self clear];
        firstOperand=YES;
        valueSet=NO;
        fromEql=YES;
        
        
    }
    else
    {
        [self.displayString setString:@"Invalid Value"];
        self.display.text = self.displayString;
        [self clear];
        [myCalculator clear];
    }
    
}

- (IBAction)clickC:(id)sender {
    [self clear];
    [myCalculator clear];
    

    self.display.text=self.displayString;
    
}

-(void)clear
{
    currentNumber = 0;
    firstOperand = YES;
    fromEql=NO;
    isNumerator = YES;
        [self.displayString setString:@""];
    

}

@end
