//
//  CHEquationInputView.m
//  kfptb
//
//  Created by ZhangTino on 2018/5/16.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHEquationInputView.h"
#import "CHEquationInputViewModel.h"
#import "CHChemistryCollectionViewCell.h"

@interface CHEquationInputView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) CHEquationInputViewModel *viewModel;
@property (nonatomic , strong) UICollectionView *chemistryCollection;
@property (nonatomic , strong) UICollectionView *operatorCollection;
@property (nonatomic , strong) UILabel *operatorTitle;
@property (nonatomic , strong) UIButton *helpButton;
@end

@implementation CHEquationInputView
@dynamic viewModel;

- (instancetype)initWithViewModel:(CHBaseViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    [self addSubview:self.chemistryCollection];
    [self.chemistryCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(363/866.0f);
    }];
    [self addSubview:self.operatorCollection];
    [self.operatorCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.left.equalTo(self.chemistryCollection.mas_right);
        make.height.equalTo(@(CHKeyboardHeight * (370 - 52) / 370.0f));
    }];
    [self addSubview:self.operatorTitle];
    [self.operatorTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.operatorCollection.mas_top);
        make.left.equalTo(self.chemistryCollection.mas_right);
        make.top.equalTo(self);
    }];
    [self addSubview:self.helpButton];
    CGFloat width = (CHOperatorBoardWidth - 1.2) / 4.0f - CHLineWidth;
    [self.helpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
        make.left.equalTo(self.operatorTitle.mas_right).offset(2);
        make.top.equalTo(self.operatorTitle.mas_top);
        make.right.equalTo(self).offset(-2);
        make.bottom.equalTo(self.operatorTitle.mas_bottom);
    }];
    [[self.helpButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        CHClickableElement *element = [CHClickableElement new];
        [element setType:CHClickableElementTypeLearning];
        [[CHEquationManager defaultManager] clickElement:element];
    }];
}

- (UICollectionView *)chemistryCollection {
    if (!_chemistryCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setMinimumInteritemSpacing:0];
        [layout setMinimumLineSpacing:0];
        _chemistryCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _chemistryCollection.delegate = self;
        _chemistryCollection.dataSource = self;
        _chemistryCollection.showsHorizontalScrollIndicator = NO;
        _chemistryCollection.showsVerticalScrollIndicator = NO;
        [_chemistryCollection setScrollEnabled:NO];
        [_chemistryCollection registerClass:[CHChemistryCollectionViewCell class] forCellWithReuseIdentifier:CHEquationCollectioCellIdentifier];
        [_chemistryCollection setBackgroundColor:[UIColor clearColor]];
    }
    return _chemistryCollection;
}

- (UICollectionView *)operatorCollection {
    if (!_operatorCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [layout setMinimumInteritemSpacing:0];
        [layout setMinimumLineSpacing:0];
        _operatorCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _operatorCollection.delegate = self;
        _operatorCollection.dataSource = self;
        _operatorCollection.showsHorizontalScrollIndicator = NO;
        _operatorCollection.showsVerticalScrollIndicator = NO;
        [_operatorCollection setScrollEnabled:NO];
        [_operatorCollection registerClass:[CHChemistryCollectionViewCell class] forCellWithReuseIdentifier:CHEquationCollectioCellIdentifier];
        [_operatorCollection setBackgroundColor:[UIColor clearColor]];
    }
    return _operatorCollection;
}

- (UILabel *)operatorTitle {
    if (!_operatorTitle) {
        _operatorTitle = [UILabel new];
        [_operatorTitle setBackgroundColor:[UIColor colorWithNumber:1]];
        [_operatorTitle setFont:[UIFont fontWithNumber:0]];
        [_operatorTitle setTextColor:[UIColor colorWithNumber:0]];
        [_operatorTitle setText:CHString(@"Chemical Equation / Lonic Equation")];
        [_operatorTitle setTextAlignment:NSTextAlignmentCenter];
    }
    return _operatorTitle;
}

- (UIButton *)helpButton {
    if (!_helpButton) {
        _helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_helpButton setBackgroundColor:[UIColor colorWithNumber:2]];
        [_helpButton setTitleColor:[UIColor colorWithNumber:0] forState:UIControlStateNormal];
        [_helpButton.titleLabel setFont:[UIFont fontWithNumber:2]];
        [_helpButton setTitle:CHString(@"Learn") forState:UIControlStateNormal];
    }
    return _helpButton;
}

#pragma mark - collectionView delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.chemistryCollection) {
        return [self.viewModel getChemistrySizeAtIndexPath:indexPath];
    }
    if (collectionView == self.operatorCollection) {
        return [self.viewModel getOperatorSizeAtIndexPath:indexPath];
    }
    return CGSizeZero;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.chemistryCollection) {
        return self.viewModel.chemistryDataArr.count;
    }
    if (collectionView == self.operatorCollection) {
        return self.viewModel.operatorDataArr.count;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CHChemistryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CHEquationCollectioCellIdentifier forIndexPath:indexPath];
    if (collectionView == self.chemistryCollection) {
        [cell setData:self.viewModel.chemistryDataArr[indexPath.row]];
    }
    if (collectionView == self.operatorCollection) {
        [cell setData:self.viewModel.operatorDataArr[indexPath.row]];
    }
    return cell;
}

@end
