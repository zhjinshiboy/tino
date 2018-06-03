//
//  CHMacros.h
//  balance
//
//  Created by ZhangTino on 2018/5/21.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#ifndef CHMacros_h
#define CHMacros_h

#define CHString(x) NSLocalizedStringFromTable(x, @"CHLocalizable", nil)
#define CHScreenHeight [UIScreen mainScreen].bounds.size.height
#define CHScreenWidth [UIScreen mainScreen].bounds.size.width
#define CHKeyboardHeight (CHScreenHeight * 370 / 523.0f)
#define CHChemistryBoardWidth (CHScreenWidth * 363 / 866.0f)
#define CHOperatorBoardWidth (CHScreenWidth * 503 / 866.0f)
#define CHLineWidth (1.0/[UIScreen mainScreen].scale)
#define CHMAX 10

#endif /* CHMacros_h */
