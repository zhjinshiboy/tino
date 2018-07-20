//
//  CHEquationBalance.m
//  balance
//
//  Created by ZhangTino on 2018/5/30.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHEquationBalance.h"

@implementation CHEquationBalance

+ (NSArray *)balanceEqationWithInput1:(NSArray *)inputArr {
    if (inputArr.count > 0) {
        NSArray *first = inputArr[0];
        NSMutableArray *result = [NSMutableArray new];
        for (NSInteger i = 0; i < first.count; i ++) {
            [result addObject:@1];
        }
        
    }
    return nil;
}

+ (instancetype)shared {
    static CHEquationBalance *balance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        balance = [CHEquationBalance new];
    });
    return balance;
}

- (NSMutableArray *)caculateWithArr:(NSArray *)arr index:(NSInteger)index result:(NSMutableArray *)result max:(NSInteger)max {
    NSMutableArray *input = [arr mutableCopy];
    NSArray *des = input.firstObject;
    if (!result) {
        result = [NSMutableArray array];
        for (NSInteger i = 0; i < des.count; i++) {
            [result addObject:@0];
        }
    }
    NSMutableArray *desIndexs = [NSMutableArray new];
    for (NSInteger i = 0; i < des.count; i++) {
        if ([des[i] integerValue] != 0 && [result[i] integerValue] == 0) {
            [desIndexs addObject:@(i)];
        }
    }
    if (desIndexs.count > 0) {
        NSMutableArray *newResult = [NSMutableArray new];
        newResult = [result mutableCopy];
        while (newResult.count) {
            newResult = [self creatNextTryByArr:newResult indexs:desIndexs max:max];
            if (newResult && [self caculateArr1:des Arr2:newResult index:index]) {
                [input removeObject:des];
                if (input.count) {
                    NSMutableArray *mutArr = [self caculateWithArr:input index:index result:newResult max:max];
                    if (mutArr.count) {
                        return mutArr;
                    }
                }else {
                    return newResult;
                }
            }
        }
    }else {
        if ([self caculateArr1:des Arr2:result index:index]) {
            [input removeObject:des];
            if (input.count) {
                return [self caculateWithArr:input index:index result:result max:max];
            }else {
                return result;
            }
        }else {
            return nil;
        }
    }
    return nil;
}

- (NSMutableArray *)creatNextTryByArr:(NSMutableArray *)arr indexs:(NSMutableArray *)indexs max:(NSInteger)max {
    NSNumber *firstIndex = indexs.firstObject;
    if ([arr[firstIndex.integerValue] integerValue] == 0) {
        for (NSNumber *index in indexs) {
            arr[index.integerValue] = @1;
        }
        return arr;
    }else {
        NSInteger changeIndex = -1;
        for (NSInteger i = indexs.count - 1; i >= 0; i -- ) {
            NSInteger index = [indexs[i] integerValue];
            if ([arr[index] integerValue] < max) {
                arr[index] = @([arr[index] integerValue] + 1);
                changeIndex = index;
                break;
            }
        }
        if (changeIndex >= 0) {
            for (NSInteger i = 0; i < indexs.count; i ++) {
                NSInteger index = [indexs[i] integerValue];
                if (index > changeIndex) {
                    arr[index] = @1;
                }
            }
            return arr;
        }
        return nil;
    }
    return nil;
}

- (BOOL)caculateArr1:(NSArray *)arr1 Arr2:(NSArray *)arr2 index:(NSInteger)index {
    NSInteger left = 0;
    NSInteger right = 0;
    for (NSInteger i = 0; i < index; i ++) {
        left += [arr1[i] integerValue] * [arr2[i] integerValue];
    }
    for (NSInteger i = index; i < arr1.count; i ++) {
        right += [arr1[i] integerValue] * [arr2[i] integerValue];
    }
    return left == right;
}

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
                [tmp replaceObjectAtIndex:j withObject:@([inputArr[i][j] floatValue] - (float)([temp[m] floatValue] * [inputArr[k][j] floatValue]))];
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
                [tmp replaceObjectAtIndex:j withObject:@([inputArr[k - i][j] floatValue] - (float)([temp[m] floatValue] * [inputArr[k + 1][j] floatValue]))];
            }
        }
    }
    
    for (NSArray *logArr in inputArr) {
        for (NSNumber *logNum in logArr) {
            printf("%lf ",logNum.floatValue);
        }
        printf("\n");
    }
    
    NSMutableArray *result = [NSMutableArray array];
    CGFloat common = 1.0f;
    for (NSInteger i = 0; i < rows; i ++) {
        CGFloat number = [inputArr[i][i] floatValue];
        common *= number;
    }
    for (NSInteger i = 0; i < rows; i ++) {
        CGFloat value = [inputArr[i][rows] floatValue] * common / [inputArr[i][i] floatValue];
        NSLog(@"%lf * %lf / %lf = %lf",[inputArr[i][rows] floatValue],common,[inputArr[i][i] floatValue],value);
        [result addObject:[NSNumber numberWithFloat:value]];
    }
    [result addObject:[NSNumber numberWithFloat:common]];
    return result;
}

@end
