//
//  NSObject+CalculatorBrain.h
//  Calculator
//
//  Created by Dam, Lily on 1/29/15.
//  Copyright (c) 2015 Dam, Lily. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain: NSObject

-(void)pushOperand:(double)operand;
-(double)performOperation:(NSString *)operation;

@end
