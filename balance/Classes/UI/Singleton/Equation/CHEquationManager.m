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
//@property (nonatomic , strong) CHEquationObj *currentObj;
//@property (nonatomic , strong) CHEquationObj *currentSubObj;
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
//¹₁²₂³₃⁴₄⁵₅⁶₆⁷₇⁸₈⁹₉⁰₀⁺₊⁻₋₍₎⁽⁾
- (instancetype)init
{
    self = [super init];
    if (self) {
//        CHEquationObj *obj = [CHEquationObj new];
//        [obj matchText:@"H⁺"];
//        NSLog(@"%@",obj);
        [self.currentConsole appendString:@"H₂+O₂→H₂O"];
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
    NSMutableArray *A = [NSMutableArray arrayWithObjects:
                         [NSMutableArray arrayWithObjects:@1,@0,@0,@-1,@0,@0,nil],
                         [NSMutableArray arrayWithObjects:@0,@1,@0,@0,@0,@2,nil],
                         [NSMutableArray arrayWithObjects:@1,@0,@3,@0,@-1,@1,nil],
                          [NSMutableArray arrayWithObjects:@0,@1,@-1,@-2,@0,@0,nil],
                         [NSMutableArray arrayWithObjects:@0,@0,@1,@0,@-1,@0,nil],
                        
                          nil];
//    NSMutableArray *B = [NSMutableArray arrayWithObjects:@0,@2,@0, nil];
    NSMutableArray *X = [NSMutableArray array];
    
//    NSLog(@"%@",[CHEquationBalance balanceEqationWithInput:A]);
//    NSString *test = @"H(NO₃)₂⁵⁺";
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
            CHEquationObj *obj = [CHEquationObj new];
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
            
        }
    }
//    CHEquationObj matchText:string regular:@"()"
    return nil;
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
