//
//  CHEquationInputViewModel.m
//  balance
//
//  Created by ZhangTino on 2018/5/21.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHEquationInputViewModel.h"
#import "CHClickableElement.h"

@implementation CHEquationInputViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (RACSubject *)clickSignal {
    if (!_clickSignal) {
        _clickSignal = [RACSubject subject];
    }
    return _clickSignal;
}

- (CGSize)getChemistrySizeAtIndexPath:(NSIndexPath *)indexPath {
    CHClickableElement *ele = self.chemistryDataArr[indexPath.row];
    return ele.size;
}

- (CGSize)getOperatorSizeAtIndexPath:(NSIndexPath *)indexPath {
    CHClickableElement *ele = self.operatorDataArr[indexPath.row];
    return ele.size;
}

#pragma mark - lazy load
- (NSArray *)chemistryDataArr {
    if (!_chemistryDataArr) {
        CGFloat height = (CHKeyboardHeight - 2.4) / 7.0f - CHLineWidth;
        CGFloat width1 = (CHChemistryBoardWidth - 0.8) / 3.0f - CHLineWidth;
        CGFloat width2 = CHChemistryBoardWidth - width1 - CHLineWidth;
        CGSize common = CGSizeMake(width1, height);
        CGSize action = CGSizeMake(width2, height);
        
        _chemistryDataArr = @[
                              [[CHClickableElement alloc] initWithTitle:CHString(@"Common") size:common type:CHClickableElementTypeCommon colorNumber:1],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"Periodic Table") size:action type:CHClickableElementTypePeriodicTable colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"H") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"C") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"N") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"O") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"Na") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"Mg") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"Al") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"Si") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"S") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"Cl") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"K") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"Ca") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"Mn") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"Fe") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"Cu") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"Zn") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"Br") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              [[CHClickableElement alloc] initWithTitle:CHString(@"Ba") size:common type:CHClickableElementTypeChemistry colorNumber:2],
                              ];
    }
    return _chemistryDataArr;
}

- (NSArray *)operatorDataArr {
    if (!_operatorDataArr) {
        CGFloat height1 = CHKeyboardHeight * 52 / 370.0f - CHLineWidth;
        CGFloat height2 = CHKeyboardHeight * 66 / 370.0f - CHLineWidth;
        CGFloat width = (CHOperatorBoardWidth - 1.2) / 4.0f - CHLineWidth;
        CGSize size1 = CGSizeMake(width, height1);
        CGSize size2 = CGSizeMake(width, height2);
        CGSize size3 = CGSizeMake(width, height2 * 2);
        
        _operatorDataArr = @[
                             [[CHClickableElement alloc] initWithTitle:CHString(@"Shift") size:size1 type:CHClickableElementTypeShiftSign colorNumber:3],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"1") size:size2 type:CHClickableElementTypeCount colorNumber:4],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"4") size:size2 type:CHClickableElementTypeCount colorNumber:4],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"7") size:size2 type:CHClickableElementTypeCount colorNumber:4],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"0") size:size2 type:CHClickableElementTypeCount colorNumber:4],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"→") size:size1 type:CHClickableElementTypeEqualSign colorNumber:3],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"2") size:size2 type:CHClickableElementTypeCount colorNumber:4],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"5") size:size2 type:CHClickableElementTypeCount colorNumber:4],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"8") size:size2 type:CHClickableElementTypeCount colorNumber:4],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"(") size:size2 type:CHClickableElementTypeLeftBracket colorNumber:4],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"C") size:size1 type:CHClickableElementTypeClealSign colorNumber:3],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"3") size:size2 type:CHClickableElementTypeCount colorNumber:4],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"6") size:size2 type:CHClickableElementTypeCount colorNumber:4],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"9") size:size2 type:CHClickableElementTypeCount colorNumber:4],
                             [[CHClickableElement alloc] initWithTitle:CHString(@")") size:size2 type:CHClickableElementTypeRightBracket colorNumber:4],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"Delete") size:size1 type:CHClickableElementTypeDeleteSign colorNumber:3],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"+") size:size2 type:CHClickableElementTypeAddSign colorNumber:3],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"-") size:size2 type:CHClickableElementTypeReduceSign colorNumber:3],
                             [[CHClickableElement alloc] initWithTitle:CHString(@"Balance") size:size3 type:CHClickableElementTypeBalanceSign colorNumber:5],
                             ];
    }
    return _operatorDataArr;
}


@end
