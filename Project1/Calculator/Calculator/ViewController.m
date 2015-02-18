//
//  ViewController.m
//  Calculator
//
//  Created by Quyen Nguyen on 1/31/15.
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
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize signChange = _signChange;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
        return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else
    {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(id)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction)decimalPressed:(UIButton *)sender {
    NSRange range = [self.display.text rangeOfString:@"."];
    if (range.location == NSNotFound) {
        self.display.text = [self.display.text stringByAppendingString:@"."];
    }
    self.userIsInTheMiddleOfEnteringANumber = YES;
}
- (IBAction)clearPressed{
    [self.brain clearMemory];
    self.display.text = @"0";
}

- (IBAction)negativePositivePressed:(id)sender {
    if ([self.display.text isEqualToString:@"0"]) {
        return;
    }
    else {
        NSString *neg = @"-";
        if (!_signChange) {
            _signChange = YES;
            self.display.text = [neg stringByAppendingFormat: neg,self.display.text];
        }
        else {
            _signChange = NO;
            self.display.text = [self.display.text substringFromIndex:1];
        }
    }
}


@end
