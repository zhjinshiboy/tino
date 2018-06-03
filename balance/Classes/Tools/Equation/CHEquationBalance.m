//
//  CHEquationBalance.m
//  balance
//
//  Created by ZhangTino on 2018/5/30.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHEquationBalance.h"

@implementation CHEquationBalance

+ (NSArray *)balanceEqationWithInput:(NSArray *)inputArr {
    NSInteger rows = inputArr.count;
    NSArray *tempForCols = inputArr[0];
    NSInteger cols = tempForCols.count;
    NSInteger L = rows - 1;
    
    NSMutableArray *temp = [NSMutableArray array];
    for (NSInteger i = 0; i < rows; i++) {
        [temp addObject:@0];
    }
    
    for (NSInteger k = 0; k < rows; k ++) {
        NSInteger n = 0;
        for (NSInteger l = k; l < L; l ++) {
            [temp replaceObjectAtIndex:n++ withObject:@([inputArr[l+1][k] floatValue] / [inputArr[k][k] floatValue])];
        }
        NSInteger m = 0;
        for (NSInteger i = k + 1; i < rows; i++ , m++) {
            for (NSInteger j = k; j < cols; j ++) {
                NSMutableArray *tmp = inputArr[i];
                [tmp replaceObjectAtIndex:j withObject:@([inputArr[i][j] floatValue] - [temp[m] floatValue] * [inputArr[k][j] floatValue])];
            }
        }
    }
    
    for (NSInteger k = L - 1; k >= 0; k--) {
        NSInteger n = 0;
        for (NSInteger l = k; l >= 0; l --) {
            [temp replaceObjectAtIndex:n++ withObject:@([inputArr[k - l][k + 1] floatValue] / [inputArr[k + 1][k + 1] floatValue])];
        }
        NSInteger m = 0;
        for (NSInteger i = k; i >= 0; i-- , m++) {
            for (NSInteger j = k; j < cols; j++) {
                NSMutableArray *tmp = inputArr[k-i];
                [tmp replaceObjectAtIndex:j withObject:@([inputArr[k - i][j] floatValue] - [temp[m] floatValue] * [inputArr[k + 1][j] floatValue])];
            }
        }
    }
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger i = 0; i < rows; i ++) {
        [result addObject:@([inputArr[i][rows] floatValue] / [inputArr[i][i] floatValue])];
    }
    return result;
}

@end
