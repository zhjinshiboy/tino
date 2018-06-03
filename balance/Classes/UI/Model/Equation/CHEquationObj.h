//
//  CHEquationObj.h
//  balance
//
//  Created by ZhangTino on 2018/5/28.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHUPCountArr @[@"⁰",@"¹",@"²",@"³",@"⁴",@"⁵",@"⁶",@"⁷",@"⁸",@"⁹"]
#define CHNormalCountArr @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]
#define CHBottomCountArr @[@"₀",@"₁",@"₂",@"₃",@"₄",@"₅",@"₆",@"₇",@"₈",@"₉"]
#define CHFormatError(x) [NSString stringWithFormat:@"%@格式错误" , x]

@interface CHEquationObj : NSObject<NSCopying>
@property (nonatomic , strong) NSMutableArray *subObjs;
@property (nonatomic , assign) NSInteger price;  //离子价
@property (nonatomic , assign) NSInteger count;  //个数
//@property (nonatomic , strong) NSMutableString *currentTitle;
@property (nonatomic , strong) NSString *title;
@property (nonatomic , weak) CHEquationObj *fatherObj;
- (NSArray *)allChemistrys;
- (NSInteger)multipleOfChemistry:(NSString *)chemistry;
//- (NSInteger)price;

- (void)matchText:(NSString *)text;


+ (NSTextCheckingResult *)matchText:(NSString *)text regular:(NSString *)regular;
+ (void)logMatch:(NSTextCheckingResult *)match text:(NSString *)text;
@end
