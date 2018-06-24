//
//  CHEquationManager.h
//  balance
//
//  Created by ZhangTino on 2018/5/26.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHClickableElement.h"

typedef NS_ENUM(NSInteger , CHEquationState) {
    CHEquationStateWait =           1 << 0,
    CHEquationStateInput =          1 << 1,
    CHEquationStateBracketWait =    1 << 2,
    CHEquationStateBracketClose =   1 << 3,
    CHEquationStateShiftWait =      1 << 4,
    CHEquationStateShiftInput =     1 << 5,
    CHEquationStateShiftClose =     1 << 6,
    CHEquationStateCornerInput =    1 << 7,
};

@interface CHEquationManager : NSObject
@property (nonatomic , strong) NSArray *chemistryArr;
@property (nonatomic , strong) NSString *chemistryString;
//@property (nonatomic , assign) CHEquationState state;
@property (nonatomic , strong) NSMutableString *currentConsole;
@property (nonatomic , assign) NSInteger bracketCount;
@property (nonatomic , assign) BOOL underShift;

+ (instancetype)defaultManager;
- (void)clickElement:(CHClickableElement *)element;


#pragma mark - for item display signal
/**
 发送nil时，元素全部可选。否则只有发送的元素为可选状态
 */
@property (nonatomic , strong) RACSubject *enableChemistrySubject;

@end
