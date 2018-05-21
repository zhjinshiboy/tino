//
//  CHCollectionViewFlowLayout.h
//  balance
//
//  Created by ZhangTino on 2018/5/20.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CHCollectionViewDelegate
@property (nonatomic , strong) NSArray *dataArr;
@end

@interface CHCollectionViewFlowLayout : UICollectionViewFlowLayout
//@property (nonatomic, assign) UIEdgeInsets sectionInset;
- (instancetype)initWithDelegate:(id<CHCollectionViewDelegate>)delegate;
@end
