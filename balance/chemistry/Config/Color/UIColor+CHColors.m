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

+ (UIColor *)colorWithNumber:(NSInteger)colorNumber {
    switch (colorNumber) {
        case 0:
            return HEXCOLOR(0xf4f4f4);
            break;
            
        default:
            break;
    }
    return nil;
}

@end
