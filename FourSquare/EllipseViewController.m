//
//  EllipseViewController.m
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/12/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import "EllipseViewController.h"
#import "EllipseControl.h"

@interface EllipseViewController ()

@end

@implementation EllipseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    EllipseControl *control = [[EllipseControl alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    [self.view addSubview:control];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
