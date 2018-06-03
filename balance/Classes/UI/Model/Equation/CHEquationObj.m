//
//  CHEquationObj.m
//  balance
//
//  Created by ZhangTino on 2018/5/28.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHEquationObj.h"
#import "CHToast.h"

@interface CHEquationObj()

@end

@implementation CHEquationObj

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.count = 1;
        self.price = 0;
    }
    return self;
}
//¹₁²₂³₃⁴₄⁵₅⁶₆⁷₇⁸₈⁹₉⁰₀⁺₊⁻₋₍₎⁽⁾
- (void)matchText:(NSString *)text {
    //FeFH(NO₃)₂⁻   (SO₄²⁻)
//    text = ;
//    NSTextCheckingResult *match = [self matchText:text regular:@"^[^⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻]+([⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻]+)$"];
    NSTextCheckingResult *match = [CHEquationObj matchText:text regular:@"[⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻]+$"];
//    [self logMatch:match text:text];
//    return;
    if (match) {
        if ([match numberOfRanges] != 1) {
            [CHToast showCenterToast:CHFormatError(text)];
            return;
        }
        NSRange cornerRange = [match rangeAtIndex:0];
        NSString *cornerString = [text substringWithRange:cornerRange];
//        NSTextCheckingResult *cornerMatch = [self matchText:cornerString regular:@"^[[¹²³⁴⁵⁶⁷⁸⁹][⁰¹²³⁴⁵⁶⁷⁸⁹]]*[⁺⁻]$"];
        NSTextCheckingResult *cornerMatch = [CHEquationObj matchText:cornerString regular:@"^([¹²³⁴⁵⁶⁷⁸⁹][⁰¹²³⁴⁵⁶⁷⁸⁹]*)?[⁺⁻]$"];
//        [self logMatch:cornerMatch text:cornerString];
        if (!cornerMatch) {
            [CHToast showCenterToast:CHFormatError(text)];
            return;
        }
        NSString *positiveOrNegative = nil;
        NSString *countString = nil;
        if (cornerString.length == 1) {
            positiveOrNegative = cornerString;
        }else {
            positiveOrNegative = [cornerString substringFromIndex:cornerString.length - 1];
            countString = [cornerString substringToIndex:cornerString.length - 1];
        }
        NSInteger price = 1;
        if (countString) {
            NSMutableString *string = [NSMutableString new];
            for (NSInteger i = 0; i < countString.length; i++) {
                NSInteger index = [CHUPCountArr indexOfObject:[countString substringWithRange:NSMakeRange(i, 1)]];
                [string appendString:CHNormalCountArr[index]];
            }
            price = string.integerValue;
        }
        if ([positiveOrNegative isEqualToString:@"⁺"]) {
            self.price = price;
        }else {
            self.price = -price;
        }
        text = [text substringWithRange:NSMakeRange(0, cornerRange.location)];
    }
    
    NSTextCheckingResult *matchBlock = [CHEquationObj matchText:text regular:@"^[(](.+)[)]([₁₂₃₄₅₆₇₈₉₀])*$"];
    if (matchBlock) {
        if ([matchBlock numberOfRanges] != 3) {
            [CHToast showCenterToast:CHFormatError(text)];
            return;
        }
        NSString *subString = [text substringWithRange:[matchBlock rangeAtIndex:1]];
        CHEquationObj *obj = [CHEquationObj new];
        [obj matchText:subString];
        [self.subObjs addObject:obj];
        if ([matchBlock rangeAtIndex:2].location == NSNotFound) {
            obj.count = 1;
        }else {
            NSString *count = [text substringWithRange:[matchBlock rangeAtIndex:2]];
            NSMutableString *string = [NSMutableString new];
            for (NSInteger i = 0; i < count.length; i++) {
                NSInteger index = [CHBottomCountArr indexOfObject:[count substringWithRange:NSMakeRange(i, 1)]];
                [string appendString:CHNormalCountArr[index]];
            }
            obj.count = string.integerValue;
        }
        return;
    }
    
    NSTextCheckingResult *matchBlock1 = [CHEquationObj matchText:text regular:@"[(](.+)[)]([₁₂₃₄₅₆₇₈₉₀])*"];
//    [self logMatch:matchBlock1 text:text];
    if (matchBlock1) {
        if ([matchBlock1 numberOfRanges] != 3) {
            [CHToast showCenterToast:CHFormatError(text)];
            return;
        }
        NSString *subString = [text substringWithRange:[matchBlock1 rangeAtIndex:1]];
        CHEquationObj *obj = [CHEquationObj new];
        [obj matchText:subString];
        [self.subObjs addObject:obj];
        if ([matchBlock1 rangeAtIndex:2].location == NSNotFound) {
            obj.count = 1;
        }else {
            NSString *count = [text substringWithRange:[matchBlock1 rangeAtIndex:2]];
            NSMutableString *string = [NSMutableString new];
            for (NSInteger i = 0; i < count.length; i++) {
                NSInteger index = [CHBottomCountArr indexOfObject:[count substringWithRange:NSMakeRange(i, 1)]];
                [string appendString:CHNormalCountArr[index]];
            }
            obj.count = string.integerValue;
        }
        text = [text substringWithRange:NSMakeRange(0, [matchBlock1 rangeAtIndex:0].location)];
    }
    while (text.length) {
        NSTextCheckingResult *matchChemistry = [CHEquationObj matchText:text regular:@"(H|N|O|Fe|F)([₁₂₃₄₅₆₇₈₉₀])*"];
        [CHEquationObj logMatch:matchChemistry text:text];
        if (matchChemistry) {
            if ([matchChemistry numberOfRanges] != 3) {
                [CHToast showCenterToast:CHFormatError(text)];
                return;
            }
            NSString *subString = [text substringWithRange:[matchChemistry rangeAtIndex:1]];
            CHEquationObj *obj = [CHEquationObj new];
            [obj setTitle:subString];
            [self.subObjs addObject:obj];
            if ([matchChemistry rangeAtIndex:2].location == NSNotFound) {
                obj.count = 1;
            }else {
                NSString *count = [text substringWithRange:[matchChemistry rangeAtIndex:2]];
                NSMutableString *string = [NSMutableString new];
                for (NSInteger i = 0; i < count.length; i++) {
                    NSInteger index = [CHBottomCountArr indexOfObject:[count substringWithRange:NSMakeRange(i, 1)]];
                    [string appendString:CHNormalCountArr[index]];
                }
                obj.count = string.integerValue;
            }
            text = [text substringWithRange:NSMakeRange([matchChemistry rangeAtIndex:0].length, text.length - [matchChemistry rangeAtIndex:0].length)];
        }
    }
}

+ (NSTextCheckingResult *)matchText:(NSString *)text regular:(NSString *)regular {
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regular options:NSRegularExpressionCaseInsensitive error:nil];
    return [re firstMatchInString:text options:0 range:NSMakeRange(0, text.length)];
}

+ (void)logMatch:(NSTextCheckingResult *)match text:(NSString *)text {
    NSLog(@"match %@",text);
    if (!match) {
        NSLog(@"match 失败");
    }
    NSLog(@"match %ld条",[match numberOfRanges]);
    for (NSInteger i = 0 ; i < [match numberOfRanges]; i ++) {
        NSRange range = [match rangeAtIndex:i];
        if (range.location == NSNotFound) {
            NSLog(@"match 第%ld条 : NSNotFound",i);
        }else {
            NSLog(@"match 第%ld条 : %ld-%ld : %@",i,range.location,range.length,[text substringWithRange:[match rangeAtIndex:i]]);
        }
    }
}

- (id)copyWithZone:(nullable NSZone *)zone {
    CHEquationObj *model = [[[self class] allocWithZone:zone] init];
//    model.chemistryDic = self.chemistryDic;
//    model.price  = self.price;
    return model;
}

- (NSArray *)allChemistrys {
//    return self.chemistryDic.allKeys;
//    for (<#type *object#> in <#collection#>) {
//        <#statements#>
//    }
    return nil;
}

- (NSInteger)multipleOfChemistry:(NSString *)chemistry {
//    if ([self.chemistryDic.allKeys containsObject:chemistry]) {
//        return [[self.chemistryDic objectForKey:chemistry] integerValue];
//    }
    return 0;
}

- (NSInteger)count {
    if (!_count) {
        _count = 1;
    }
    return _count;
}

//- (NSMutableString *)currentTitle {
//    if (!_currentTitle) {
//        _currentTitle = [NSMutableString new];
//    }
//    return _currentTitle;
//}

- (NSMutableArray *)subObjs {
    if (!_subObjs) {
        _subObjs = [NSMutableArray new];
    }
    return _subObjs;
}

@end
