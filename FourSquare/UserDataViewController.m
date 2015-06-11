//
//  UserDataViewController.m
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/10/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import "UserDataViewController.h"
#import "UIViewController+AppController.h"

@interface UserDataViewController ()

@end

@implementation UserDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.retryButton.hidden = TRUE;
    [self.retryButton setTitle:NSLocalizedString(@"UserDataViewController_retrybutton", nil) forState:UIControlStateNormal];
    [self.retryButton addTarget:self action:@selector(loadUserData) forControlEvents:UIControlEventTouchUpInside];
    [self loadUserData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadUserData {
    self.retryButton.hidden = TRUE;
    [self.userDataLabel setText:NSLocalizedString(@"UserDataViewController_labelloading", nil)];
    [self.appController getUserData:^(NSData * data, NSError *error){
        if(error== nil){
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [self.userDataLabel setText:dataString];
        } else {
            [self.userDataLabel setText:NSLocalizedString(@"UserDataViewController_labelerror", nil)];
        }
        self.retryButton.hidden = FALSE;
    }];
}

@end
