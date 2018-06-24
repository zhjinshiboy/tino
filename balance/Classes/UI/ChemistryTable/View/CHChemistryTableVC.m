//
//  CHChemistryTableVC.m
//  balance
//
//  Created by ZhangTino on 2018/6/24.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHChemistryTableVC.h"
#import "CHEquationManager.h"

@interface CHChemistryTableVC ()
@property (nonatomic , strong) UIImageView *img;
@property (nonatomic , strong) NSMutableArray *btns;
@end

@implementation CHChemistryTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    for (NSInteger i = 0; i < 103; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTag:i + 100];
        [self.view addSubview:btn];
        @weakify(self);
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self clickByTag:x.tag];
        }];
        NSInteger line = 0;
        NSInteger row = 0;
        CGFloat width = self.view.bounds.size.width;
        CGFloat height = self.view.bounds.size.height;
        NSInteger number = i + 1;
        if (number < 57 || (number > 71 && number < 89) || number > 103) {
            [self calculateCommonLine:&line row:&row withChemistryNumber:number];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.img.mas_width).multipliedBy(32 / 667.0f);
                make.height.equalTo(self.img.mas_height).multipliedBy(37 / 375.0f);
                make.left.equalTo(self.img.mas_left).offset(32 / 667.0f * width + row * 32 / 667.0f * width);
                make.top.equalTo(self.img.mas_top).offset(27 / 375.0f * height + line * 37 / 375.0f * height);
            }];
        }else {
            
        }
    }
    
}

- (void)clickByTag:(NSInteger)tag {
    NSArray *titleArr = @[@"H",@"He",@"Li",@"Be",@"B",@"C",@"N",@"O",@"F",@"Ne",@"Na",@"Mg",@"Al",@"Si",@"P",@"S",@"Cl",@"Ar",@"K",@"Ca",@"Sc",@"Ti",@"V",@"Cr",@"Mn",@"Fe",@"Co",@"Ni",@"Cu",@"Zn",@"Ga",@"Ge",@"As",@"Se",@"Br",@"Kr",@"Rb",@"Sr",@"Y",@"Zr",@"Nb",@"Mo",@"Tc",@"Ru",@"Rh",@"Pd",@"Ag",@"Cd",@"In",@"Sn",@"Sb",@"Te",@"I",@"Xe",@"Cs",@"Ba",@"La",@"Ce",@"Pr",@"Nd",@"Pm",@"Sm",@"Eu",@"Gd",@"Tb",@"Dy",@"Ho",@"Er",@"Tm",@"Yb",@"Lu",@"Hf",@"Ta",@"W",@"Re",@"Os",@"Ir",@"Pt",@"Au",@"Hg",@"Tl",@"Pb",@"Bi",@"Po",@"At",@"Rn",@"Fr",@"Ra",@"Ac",@"Th",@"Pa",@"U",@"Np",@"Pu",@"Am",@"Cm",@"Bk",@"Cf",@"Es",@"Fm",@"Md",@"No",@"Lr",@"Rf",@"Db",@"Sg",@"Bh",@"Hs",@"Mt",@"Ds",@"Rg",@"Uub"];
    CHClickableElement *element = [[CHClickableElement alloc] initWithTitle:CHString(titleArr[tag - 100]) size:CGSizeZero type:CHClickableElementTypeChemistry colorNumber:0];
    [[CHEquationManager defaultManager] clickElement:element];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)calculateCommonLine:(NSInteger *)line row:(NSInteger *)row withChemistryNumber:(NSInteger)number {
    NSInteger tableLine = 1;  //表上的行列，从1开始  （与数组从0开始不同，为了方便看图添加的这两个值）
    NSInteger tableRow = 1;
    if (number <= 2) {
        tableLine = 1;
    }
    if (number >= 3 && number <= 10) {
        tableLine = 2;
    }
    if (number >= 11 && number <= 18) {
        tableLine = 3;
    }
    if (number >= 19 && number <= 36) {
        tableLine = 4;
    }
    if (number >= 37 && number <= 54) {
        tableLine = 5;
    }
    if (number >= 55 && number <= 86) {
        tableLine = 6;
    }
    if (number >= 87 && number <= 112) {
        tableLine = 7;
    }
    
    if (number == 1 || number == 3 || number == 11 || number == 19 || number == 37 || number == 55 || number == 87) {
        tableRow = 1;
    }
    if (number == 4 || number == 12 || number == 20 || number == 38 || number == 56 || number == 88) {
        tableRow = 2;
    }
    if (number == 21 || number == 39) {
        tableRow = 3;
    }
    if (number == 22 || number == 40 || number == 72 || number == 104) {
        tableRow = 4;
    }
    if (number == 23 || number == 41 || number == 73 || number == 105) {
        tableRow = 5;
    }
    if (number == 24 || number == 42 || number == 74 || number == 106) {
        tableRow = 6;
    }
    if (number == 25 || number == 43 || number == 75 || number == 107) {
        tableRow = 7;
    }
    if (number == 26 || number == 44 || number == 76 || number == 108) {
        tableRow = 8;
    }
    if (number == 27 || number == 45 || number == 77 || number == 109) {
        tableRow = 9;
    }
    if (number == 28 || number == 46 || number == 78 || number == 110) {
        tableRow = 10;
    }
    if (number == 29 || number == 47 || number == 79 || number == 111) {
        tableRow = 11;
    }
    if (number == 30 || number == 48 || number == 80 || number == 112) {
        tableRow = 12;
    }
    if (number == 5 || number == 13 || number == 31 || number == 49 || number == 81) {
        tableRow = 13;
    }
    if (number == 6 || number == 14 || number == 32 || number == 50 || number == 82) {
        tableRow = 14;
    }
    if (number == 7 || number == 15 || number == 33 || number == 51 || number == 83) {
        tableRow = 15;
    }
    if (number == 8 || number == 16 || number == 34 || number == 52 || number == 84) {
        tableRow = 16;
    }
    if (number == 9 || number == 17 || number == 35 || number == 53 || number == 85) {
        tableRow = 17;
    }
    if (number == 10 || number == 18 || number == 36 || number == 54 || number == 86) {
        tableRow = 18;
    }
    
    *line = tableLine - 1;
    *row = tableRow - 1;
}

- (UIImageView *)img {
    if (!_img) {
        _img = [UIImageView new];
        [_img setImage:[UIImage imageNamed:@"chemistry"]];
    }
    return _img;
}

- (NSMutableArray *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

@end
