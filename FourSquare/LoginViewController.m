//
//  LoginViewController.m
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/10/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import "LoginViewController.h"
#import "UIViewController+AppController.h"
#import <QuartzCore/QuartzCore.h>
@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"LoginViewController_title", nil);
    [self.loginButton.layer setCornerRadius:3.0f];
    [self.loginButton.layer setBorderWidth:1.0f];
    [self.loginButton.layer setBorderColor:[UIColor blueColor].CGColor];
    [self.loginButton setTitle:NSLocalizedString(@"LoginViewController_loginbuttonkey", nil) forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(initiateWebView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initiateWebView {
    UIViewController *vc = [self.appController constructWebViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
