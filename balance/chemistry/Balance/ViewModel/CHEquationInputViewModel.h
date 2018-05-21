//
//  CHEquationInputViewModel.h
//  balance
//
//  Created by ZhangTino on 2018/5/21.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHBaseViewModel.h"
#import "CHCollectionViewFlowLayout.h"

#define CHEquationCollectioCellIdentifier @"CHEquationCollectioCellIdentifier"

@interface CHEquationInputViewModel : CHBaseViewModel<UICollectionViewDataSource,CHCollectionViewDelegate>
@property (nonatomic , strong) NSArray *dataArr;
@property (nonatomic , strong) RACSubject *clickSignal;
//@property (nonatomic , strong)
- (CGSize)getCellSizeAtIndexPath:(NSIndexPath *)indexPath;
@end
