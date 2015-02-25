//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Quyen Nguyen on 2/1/15.
//  Copyright (c) 2015 Quyen Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString*)operation;
- (void)clearMemory;

@end
