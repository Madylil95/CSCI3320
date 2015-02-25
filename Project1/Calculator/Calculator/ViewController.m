//
//  ViewController.m
//  Calculator
//
//  Created by Quyen Nguyen, Lily Dam, Mohhamad Hossain
//  Copyright (c) 2015 Quyen Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation ViewController

@synthesize display;
@synthesize sentToStack;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
        return _brain;
}

//DIGIT_PRESSED_________________________________________________________________________
- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber)            //only append the digit
    {
        self.display.text = [self.display.text stringByAppendingString:digit];
        self.sentToStack.text = [self.sentToStack.text stringByAppendingString:digit];
    }
    else                                                    //a new number
    {
        self.display.text = digit;
        //Edit the stack display, only by appending, no new string value.
        if([self.sentToStack.text isEqualToString:@"0"])    //remove leading zero in stack
        {                                                   //display.
            self.sentToStack.text = digit;
        }
        else
        {
            self.sentToStack.text = [self.sentToStack.text stringByAppendingString:@" "];
            self.sentToStack.text = [self.sentToStack.text stringByAppendingString:digit];
        }
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
//ENTER_PRESSED____________________________________________________________________________
- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];       //put on stack
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

//OPERATION_PRESSED__________________________________________________________________________
- (IBAction)operationPressed:(id)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    
    //stack display operations for +/-:
    if(![operation isEqualToString:@"+/-"])         //plus minus is not printed out in stack display.
    {
        self.sentToStack.text = [self.sentToStack.text stringByAppendingString:@" "];
        self.sentToStack.text = [self.sentToStack.text stringByAppendingString:operation];
        self.sentToStack.text = [self.sentToStack.text stringByAppendingString:@" "];
    }
    else
    {
        if([self.sentToStack.text hasPrefix:@"-"])          //if number is already negative, remove -
        {
            NSString *prefixToRemove = @"-";
            self.sentToStack.text = [self.sentToStack.text substringFromIndex:[prefixToRemove length]];
        }
        else
        {
            NSString *existingString = self.sentToStack.text;
            self.sentToStack.text = [@"-" stringByAppendingString:existingString];
        }
    }
    //stack display operation for pi:
    if ([operation isEqualToString: @"π"] || [self.sentToStack.text isEqualToString:@"0"])
    {
        self.sentToStack.text = @"π";
    }
    //display the new negative value by popping, multiplying by -1, and pushing on the stack again
    else if ([operation isEqualToString:@"+/-"])
    {
        [self.brain pushOperand:[self.display.text doubleValue]];
        self.userIsInTheMiddleOfEnteringANumber = YES; 
    }
    //+/- DOES NOT complete an expression with an '='
    else
    {
        self.sentToStack.text =[self.sentToStack.text stringByAppendingString:@"="];
        self.sentToStack.text = [self.sentToStack.text stringByAppendingString:@" "];
    }

}

//DECIMAL_PRESSED_______________________________________________________________________
- (IBAction)decimalPressed:(UIButton *)sender
{
    NSRange range = [self.display.text rangeOfString:@"."];
    if (range.location == NSNotFound)
    {
        self.display.text = [self.display.text stringByAppendingString:@"."];
        self.sentToStack.text = [self.sentToStack.text stringByAppendingString:@"."];
    }
    self.userIsInTheMiddleOfEnteringANumber = YES;
}

//CLEAR_PRESSED____________________________________
- (IBAction)clearPressed{
    [self.brain clearMemory];
    self.display.text = @"0";
    self.sentToStack.text = @"0";
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

//DELETE______________________________________________________________________
- (IBAction)delete:(id)sender
{
    if(userIsInTheMiddleOfEnteringANumber) //can no longer delete if user has pressed an operation
    {
        NSString *string = self.display.text;                  //edit the display
        float length = self.display.text.length;
        NSString *temp = [string substringToIndex:length-1];
        self.display.text = temp;
    
        NSString *stackString = self.sentToStack.text;          //edit the stack display
        float stackLength = self.sentToStack.text.length;
        NSString *stackTemp = [stackString substringToIndex:stackLength-1];
        self.sentToStack.text = stackTemp;
    }
}

@end
