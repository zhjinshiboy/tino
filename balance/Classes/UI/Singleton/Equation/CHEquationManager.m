//
//  CHEquationManager.m
//  balance
//
//  Created by ZhangTino on 2018/5/26.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHEquationManager.h"
#import "CHEquationObj.h"
#import "CHToast.h"
#import "CHEquationBalance.h"

@interface CHEquationManager()
@property (nonatomic , strong) NSMutableArray *leftObjs;
@property (nonatomic , strong) NSMutableArray *rightObjs;
@end

@implementation CHEquationManager

+ (instancetype)defaultManager {
    static CHEquationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [CHEquationManager new];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)clickElement:(CHClickableElement *)element {
    switch (element.type) {
        case CHClickableElementTypeChemistry:
        {
            [self.currentConsole appendString:element.title];
        }
            break;
        case CHClickableElementTypePeriodicTable:
        {
            
        }
            break;
        case CHClickableElementTypeShiftSign:
        {
            
        }
            break;
        case CHClickableElementTypeEqualSign:
        {
            //todo left to right
            [self.currentConsole appendString:element.title];
        }
            break;
        case CHClickableElementTypeClealSign:
        {
            //todo clean
            [self.leftObjs removeAllObjects];
            [self.rightObjs removeAllObjects];
            [self.currentConsole deleteCharactersInRange:NSMakeRange(0, self.currentConsole.length)];
        }
            break;
        case CHClickableElementTypeDeleteSign:
        {
            [self.currentConsole deleteCharactersInRange:NSMakeRange(self.currentConsole.length - 1, 1)];
        }
            break;
        case CHClickableElementTypeAddSign:
        {
            if (self.underShift) {
                [self.currentConsole appendString:@"⁺"];
            }else {
                [self.currentConsole appendString:@"+"];
            }
        }
            break;
        case CHClickableElementTypeReduceSign:
        {
            if (self.underShift) {
                [self.currentConsole appendString:@"⁻"];
            }
        }
            break;
        case CHClickableElementTypeBalanceSign:
        {
            [self.leftObjs removeAllObjects];
            [self.rightObjs removeAllObjects];
            [self calculateResult];
        }
            break;
        case CHClickableElementTypeLeftBracket:
        {
            [self.currentConsole appendString:@"("];
        }
            break;
        case CHClickableElementTypeRightBracket:
        {
            [self.currentConsole appendString:@")"];
        }
            break;
        case CHClickableElementTypeCount:
        {
            if (self.underShift) {
                [self.currentConsole appendString:CHUPCountArr[[CHNormalCountArr indexOfObject:element.title]]];
            }else {
                [self.currentConsole appendString:CHBottomCountArr[[CHNormalCountArr indexOfObject:element.title]]];
            }
        }
            break;
            
        default:
            break;
    }
    self.currentConsole = self.currentConsole;
}

#pragma mark - action
- (void)calculateResult {
//    self.currentConsole = [NSMutableString stringWithString:@"FeO+HNO₃→FeO+H₂"];
//    self.currentConsole = [NSMutableString stringWithString:@"HNO₂+HNO₄→HNO₃"];
//    self.currentConsole = [NSMutableString stringWithString:@"HNO₃→H₂+N₂+O₂"];
//    self.currentConsole = [NSMutableString stringWithString:@"HNO₃→O₂+H₂+N₂"];
//    self.currentConsole = [NSMutableString stringWithString:@"O₃→O₂"];
    self.currentConsole = [NSMutableString stringWithString:@"FeO+HNO₃→Fe(NO₃)₃+NO+H₂O"];
    NSMutableArray *XArr = [NSMutableArray array];
    NSTextCheckingResult *match = [CHEquationObj matchText:self.currentConsole regular:@"^([^→]+)→([^→]+)$"];
    [CHEquationObj logMatch:match text:self.currentConsole];
    if (!match) {
        [CHToast showCenterToast:@"不能缺失方程两侧"];
        return;
    }
    if ([match numberOfRanges] != 3) {
        [CHToast showCenterToast:@"不能缺失方程两侧"];
        return;
    }
    NSString *leftString = [self.currentConsole substringWithRange:[match rangeAtIndex:1]];
    NSString *rightString = [self.currentConsole substringWithRange:[match rangeAtIndex:2]];
    [self.leftObjs addObjectsFromArray:[self parseString:leftString]];
    [self.rightObjs addObjectsFromArray:[self parseString:rightString]];
    NSMutableArray *leftArr = [NSMutableArray array];
    for (CHEquationObj *obj in self.leftObjs) {
        for (NSString *title in [obj allChemistrys]) {
            if (![leftArr containsObject:title]) {
                [leftArr addObject:title];
            }
        }
    }
    NSMutableArray *rightArr = [NSMutableArray array];
    for (CHEquationObj *obj in self.rightObjs) {
        for (NSString *title in [obj allChemistrys]) {
            if (![rightArr containsObject:title]) {
                [rightArr addObject:title];
            }
        }
    }
    if (leftArr.count != rightArr.count) {
        [CHToast showCenterToast:@"方程两侧不匹配"];
        return;
    }else {
        BOOL equal = YES;
        for (NSString *title in leftArr) {
            if (![rightArr containsObject:title]) {
                equal = NO;
            }
        }
        if (!equal) {
            [CHToast showCenterToast:@"方程两侧不匹配"];
            return;
        }
    }
    
    for (NSString *title in leftArr) {
        NSMutableArray *arr = [NSMutableArray array];
        printf("\n");
        for (CHEquationObj *obj in self.leftObjs) {
            NSInteger number = [obj multipleOfChemistry:title];
            [arr addObject:@(number)];
            printf("%d ",(int)number);
        }
        for (CHEquationObj *obj in self.rightObjs) {
            NSInteger number = [obj multipleOfChemistry:title];
            [arr addObject:@(number)];
            printf("%d ",(int)number);
        }
        [XArr addObject:arr];
    }
    printf("\n");
    
    NSMutableArray *YArr = [NSMutableArray array];
    for (NSArray *x in XArr) {
        BOOL exist = NO;
        for (NSArray *y in YArr) {
            BOOL equal = YES;
            for (NSInteger i = 0; i < x.count; i ++) {
                if ([x[i] integerValue] != [y[i] integerValue]) {
                    equal = NO;
                    break;
                }
            }
            if (equal) {
                exist = YES;
                break;
            }
        }
        if (!exist) {
            [YArr addObject:x];
        }
    }
    
    YArr = [self sortArr:YArr index:0];
    
    NSArray *arr = [CHEquationBalance balanceEqationWithInput:YArr];
    NSLog(@"%@",arr);
    for (id x in arr) {
        if (isnan([x doubleValue])) {
            [CHToast showCenterToast:@"方程式错误，无法配平"];
            return;
        }
    }
    arr = [self configArr:arr];
    NSMutableString *string = [NSMutableString string];
    for (NSInteger i = 0; i < self.leftObjs.count; i ++ ) {
        CHEquationObj *obj = self.leftObjs[i];
        NSNumber *current = arr[i];
        [string appendString:[NSString stringWithFormat:@"%@%@",current.integerValue == 1 ? @"":@(current.integerValue),obj.currentTitle]];
        if (i < self.leftObjs.count - 1 ) {
            [string appendString:@"+"];
        }else {
            [string appendString:@"→"];
        }
    }
    for (NSInteger i = 0; i < self.rightObjs.count; i ++ ) {
        CHEquationObj *obj = self.rightObjs[i];
        NSNumber *current = arr[i + self.leftObjs.count];
        current = self.rightObjs.count - 1 == i?@(current.integerValue):@(-current.integerValue);
        [string appendString:[NSString stringWithFormat:@"%@%@",current.integerValue == 1? @"":current,obj.currentTitle]];
        if (i < self.rightObjs.count - 1 ) {
            [string appendString:@"+"];
        }
    }
    self.currentConsole = string;
}

- (NSArray *)configArr:(NSArray *)arr {
    NSMutableArray *result = [NSMutableArray arrayWithArray:arr];
    BOOL noPass = YES;
    while (noPass) {
        BOOL wrong = NO;
        for (NSNumber *num in result) {
            if (num.floatValue != ceil(num.floatValue)) {
                wrong = YES;
            }
        }
        if (wrong) {
            for (NSInteger i = 0; i < result.count; i ++) {
                CGFloat count = [result[i] floatValue];
                [result replaceObjectAtIndex:i withObject:@(count * 10)];
            }
        }else {
            noPass = NO;
        }
    }
    NSInteger i = [result[0] integerValue];
    for (NSNumber *num in result) {
        if (num.integerValue < i) {
            i = num.integerValue;
        }
    }
    NSInteger divisor = 2;
    while (divisor <= i) {
        BOOL allPass = YES;
        for (NSNumber *num in result) {
            if (num.integerValue % divisor != 0) {
                allPass = NO;
            }
        }
        if (allPass) {
            for (NSInteger i = 0; i < result.count; i ++) {
                NSInteger count = [result[i] integerValue];
                [result replaceObjectAtIndex:i withObject:@(count / divisor)];
            }
        }else {
            divisor ++;
        }
    }
    return result;
}

- (NSMutableArray *)sortArr:(NSMutableArray *)inputArr index:(NSInteger)index {
    NSMutableArray *result = [NSMutableArray array];
    if (inputArr.count == 1) {
        NSArray *arr = inputArr[0];
        if ([arr[index] integerValue] != 0) {
            [result addObject:arr];
        }
        return result;
    }
    for (NSInteger i = 0; i<inputArr.count; i++) {
        NSArray *arr = inputArr[i];
        if ([arr[index] integerValue] != 0) {
            NSMutableArray *tmp = [inputArr mutableCopy];
            [tmp removeObjectAtIndex:i];
            NSMutableArray *others = [self sortArr:tmp index:index + 1];
            if (others.count) {
                [result addObject:arr];
                [result addObjectsFromArray:others];
                break;
            }
        }
    }
    return result;
}

- (NSArray *)parseString:(NSString *)string {
    NSTextCheckingResult * isOK = [CHEquationObj matchText:string regular:@"^(?<![+])[^+]+([+][^+]+)*(?![+])$"];
    if (!isOK) {
        [CHToast showCenterToast:CHFormatError(string)];
        return nil;
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableString *mutString = [NSMutableString stringWithString:string];
    while (mutString.length) {
        NSTextCheckingResult *matchChemistry = [CHEquationObj matchText:mutString regular:@"[^+]+"];
        [CHEquationObj logMatch:matchChemistry text:mutString];
        if (matchChemistry) {
            if ([matchChemistry numberOfRanges] != 1) {
                [CHToast showCenterToast:CHFormatError(mutString)];
                return nil;
            }
            NSString *first = [mutString substringWithRange:[matchChemistry rangeAtIndex:0]];
            
            NSTextCheckingResult *matchNumbers = [CHEquationObj matchText:first regular:@"[0-9]+"];
            if (matchNumbers && [matchNumbers numberOfRanges]) {
                NSRange range = [matchNumbers rangeAtIndex:0];
                first = [first substringWithRange:NSMakeRange(range.length, first.length - range.length)];
            }

            CHEquationObj *obj = [CHEquationObj new];
            [obj setCurrentTitle:first];
            [obj matchText:first];
            [arr addObject:obj];
            [mutString deleteCharactersInRange:[matchChemistry rangeAtIndex:0]];
//            NSString *subString = [text substringWithRange:[matchChemistry rangeAtIndex:1]];
//            CHEquationObj *obj = [CHEquationObj new];
//            [obj setTitle:subString];
//            [self.subObjs addObject:obj];
//            if ([matchChemistry rangeAtIndex:2].location == NSNotFound) {
//                obj.count = 1;
//            }else {
//                NSString *count = [text substringWithRange:[matchChemistry rangeAtIndex:2]];
//                NSMutableString *string = [NSMutableString new];
//                for (NSInteger i = 0; i < count.length; i++) {
//                    NSInteger index = [CHBottomCountArr indexOfObject:[count substringWithRange:NSMakeRange(i, 1)]];
//                    [string appendString:CHNormalCountArr[index]];
//                }
//                obj.count = string.integerValue;
//            }
//            text = [text substringWithRange:NSMakeRange([matchChemistry rangeAtIndex:0].length, text.length - [matchChemistry rangeAtIndex:0].length)];
        }else {
            break;
        }
    }
    return arr;
}

#pragma mark - lazy load
- (NSMutableString *)currentConsole {
    if (!_currentConsole) {
        _currentConsole = [NSMutableString string];
    }
    return _currentConsole;
}

- (RACSubject *)enableChemistrySubject {
    if (!_enableChemistrySubject) {
        _enableChemistrySubject = [RACSubject subject];
    }
    return _enableChemistrySubject;
}

//- (RACSubject *)disableCountSubject {
//    if (!_disableCountSubject) {
//        _disableCountSubject = [RACSubject subject];
//    }
//    return _disableCountSubject;
//}
//
//- (RACSubject *)enalbeSignSubject {
//    if (!_enalbeSignSubject) {
//        _enalbeSignSubject = [RACSubject subject];
//    }
//    return _enalbeSignSubject;
//}

- (NSMutableArray *)leftObjs {
    if (!_leftObjs) {
        _leftObjs = [NSMutableArray array];
    }
    return _leftObjs;
}

- (NSMutableArray *)rightObjs {
    if (!_rightObjs) {
        _rightObjs = [NSMutableArray array];
    }
    return _rightObjs;
}


@end
