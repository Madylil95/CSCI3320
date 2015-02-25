//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Quyen Nguyen, Lily Dam, and Mohhomad Hossain
//  Copyright (c) 2015 Quyen Nguyen. All rights reserved.
//

#import "CalculatorBrain.h"
#import <math.h>

@interface CalculatorBrain()
@property (nonatomic,strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

//OPERAND_STACK_______________________________________
- (NSMutableArray *)operandStack
{
    if (!_operandStack)
    {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

//CLEAR_MEMORY____________________________
- (void)clearMemory
{
    [self.operandStack removeAllObjects];
}

//PUSH_OPERAND____________________________________________________
- (void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

//POP_OPERAND_______________________________________________
- (double)popOperand
{
    NSNumber *operandObject= [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

//PERFORM_OPERATION_________________________________________
- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    //main operations +,-,/,*
    if ([operation isEqualToString:@"+"])
    {
        result = [self popOperand] + [self popOperand];
    }
    else if ([@"*" isEqualToString:operation])
    {
        result = [self popOperand] * [self popOperand];
    }
    else if ([operation isEqualToString:@"-"])
    {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    }
    else if ([operation isEqualToString:@"/"])
    {
        double divisor = [self popOperand];
        if (divisor)
        {
            result = [self popOperand] / divisor;
        }
    }
    //other: sin,cos,π,sqrt
    else if ([operation isEqualToString:@"Sin"])
    {
        result = sin([self popOperand]);
        // performs the operation sine in radians
    }
    
    else if ([operation isEqualToString:@"Cos"])
    {
        result = cos([self popOperand]);
        // performs the operation cos in radians
    }
    
    else if([operation isEqualToString:@"Sqrt"])
    {
        result = sqrt([self popOperand]);
    }
    
    else if([operation isEqualToString:@"π"])
    {
        result = M_PI;
        
    }
    // +/- operation:
    else if([operation isEqualToString:@"+/-"])
    {
        result = [self popOperand] *-1; //pop and multiply by negative one
                                        //viewController.m pushes it back.
    }
    
    [self pushOperand:result];
    
    return result;
}

@end
