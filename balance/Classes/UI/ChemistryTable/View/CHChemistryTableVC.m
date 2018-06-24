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

@end

@implementation CHChemistryTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)didClickChemistry:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSArray *titleArr = @[@"H",@"He",@"Li",@"Be",@"B",@"C",@"N",@"O",@"F",@"Ne",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H",@"H"];
    CHClickableElement *element = [[CHClickableElement alloc] initWithTitle:CHString(titleArr[btn.tag - 101]) size:CGSizeZero type:CHClickableElementTypeChemistry colorNumber:0];
    [[CHEquationManager defaultManager] clickElement:element];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
