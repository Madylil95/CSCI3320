//
//  ViewController.m
//  Calculator
//
//  Created by Dam, Lily on 1/29/15.
//  Copyright (c) 2015 Dam, Lily. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+CalculatorBrain.h"

@interface ViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic,strong) CalculatorBrain *brain;
@end


@implementation ViewController

@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

-(CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    
    //UILabel *myDisplay = self.display; // [self display];
    //NSString *currentDisplayText = self.display.text;
    //NSString *newDisplayText = [currentDisplayText stringByAppendingString:digit];
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
    self.display.text = [self.display.text stringByAppendingString:digit];  // [self.display setText:newDisplayText];
    }
    else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    // NSLog(@"user touched %@", digit);
    
}
- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}
- (IBAction)operationPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed]; 
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}
@end
