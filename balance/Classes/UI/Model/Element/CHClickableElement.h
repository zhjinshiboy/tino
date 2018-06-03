//
//  CHClickableElement.h
//  balance
//
//  Created by ZhangTino on 2018/5/21.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , CHClickableElementType) {
    CHClickableElementTypeCommon,
    CHClickableElementTypeChemistry,
    CHClickableElementTypePeriodicTable,
    CHClickableElementTypeCount,
    CHClickableElementTypeShiftSign,
    CHClickableElementTypeEqualSign,
    CHClickableElementTypeClealSign,
    CHClickableElementTypeDeleteSign,
    CHClickableElementTypeAddSign,
    CHClickableElementTypeReduceSign,
    CHClickableElementTypeBalanceSign,
    CHClickableElementTypeLeftBracket,
    CHClickableElementTypeRightBracket
};

@interface CHClickableElement : NSObject
@property (nonatomic , strong) NSString *title;
@property (nonatomic , assign) CGSize size;
@property (nonatomic , assign) CHClickableElementType type;
@property (nonatomic , assign) NSInteger colorNumber;
- (instancetype)initWithTitle:(NSString *)title size:(CGSize)size type:(CHClickableElementType)type colorNumber:(NSInteger)colorNumber;
@end
