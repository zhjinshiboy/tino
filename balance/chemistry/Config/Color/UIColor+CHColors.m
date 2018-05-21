//
//  UIColor+CHColors.m
//  balance
//
//  Created by ZhangTino on 2018/5/20.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "UIColor+CHColors.h"

#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HEXACOLOR(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define RGBCOLOR(r, g, b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@implementation UIColor (CHColors)

/**
 colorNumber:
 0:文字黑
 1:选中黄
 2:元素灰
 3:运算灰
 4:数字白
 5:配平蓝
 6:禁用灰
 7:文字灰
 8:分割线
 9:选中灰
 */

+ (UIColor *)colorWithNumber:(NSInteger)colorNumber {
    switch (colorNumber) {
        case 0:
            return [UIColor blackColor];
            break;
        case 1:
            return HEXCOLOR(0xe78b1f);
            break;
        case 2:
            return HEXCOLOR(0xcccccc);
            break;
        case 3:
            return HEXCOLOR(0xf4f4f4);
            break;
        case 4:
            return [UIColor whiteColor];
            break;
        case 5:
            return [UIColor blueColor];
            break;
        case 6:
            return HEXCOLOR(0xaaaaaa);
            break;
        case 7:
            return HEXCOLOR(0x999999);
            break;
        case 8:
            return HEXCOLOR(0xe7e7e7);
            break;
        case 9:
            return HEXCOLOR(0xc0c0c0);
            break;
        default:
            break;
    }
    return nil;
}



@end
