//
//  UIFont+CHFonts.m
//  balance
//
//  Created by ZhangTino on 2018/5/26.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "UIFont+CHFonts.h"

@implementation UIFont (CHFonts)

/**
 colorNumber:
 0:通用按钮font
 1:输出台font
 2:balance按钮font
 */

+ (UIFont *)fontWithNumber:(NSInteger)fontNumber {
    switch (fontNumber) {
        case 0:
            return [UIFont systemFontOfSize:15];
            break;
        case 1:
            return [UIFont systemFontOfSize:40];
            break;
        case 2:
            return [UIFont systemFontOfSize:20];
            break;
        default:
            break;
    }
    return nil;
}


@end
