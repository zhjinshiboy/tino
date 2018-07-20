//
//  CHEquationBalance.h
//  balance
//
//  Created by ZhangTino on 2018/5/30.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHEquationBalance : NSObject
+ (instancetype)shared;
+ (NSArray *)balanceEqationWithInput:(NSArray *)inputArr;
- (NSMutableArray *)caculateWithArr:(NSArray *)arr index:(NSInteger)index result:(NSMutableArray *)result max:(NSInteger)max;
@end
