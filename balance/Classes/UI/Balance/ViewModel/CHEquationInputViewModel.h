//
//  CHEquationInputViewModel.h
//  balance
//
//  Created by ZhangTino on 2018/5/21.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHBaseViewModel.h"

#define CHEquationCollectioCellIdentifier @"CHEquationCollectioCellIdentifier"

@interface CHEquationInputViewModel : CHBaseViewModel
@property (nonatomic , strong) NSArray *chemistryDataArr;
@property (nonatomic , strong) NSArray *operatorDataArr;
@property (nonatomic , strong) RACSubject *clickSignal;
- (CGSize)getOperatorSizeAtIndexPath:(NSIndexPath *)indexPath;
- (CGSize)getChemistrySizeAtIndexPath:(NSIndexPath *)indexPath;
@end
