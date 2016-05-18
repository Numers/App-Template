//
//  SCLoginScrollViewController.m
//  ShangCheng
//
//  Created by baolicheng on 16/1/19.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "SCLoginScrollViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "SCLoginViewController.h"
#import "SCHomeViewController.h"
#import "RFGeneralManager.h"
@interface SCLoginScrollViewController ()<UIScrollViewDelegate,SCLoginViewProtocol>
{
    TPKeyboardAvoidingScrollView *scrollView;
    SCLoginViewController *scLoginVC;
    UIStoryboard *storyboard;
}
@end

@implementation SCLoginScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    scLoginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewIdentify"];
    scLoginVC.delegate = self;
    [scrollView addSubview:scLoginVC.view];
    
    [scrollView setContentSize:scLoginVC.view.frame.size];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark ZXLoginViewProtocol
-(void)loginSuccess
{
    [[RFGeneralManager defaultManager] sendClientIdSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } Error:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } Failed:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    SCHomeViewController *scHomeVC = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewIdentify"];
    [self.navigationController pushViewController:scHomeVC animated:YES];
}
@end
