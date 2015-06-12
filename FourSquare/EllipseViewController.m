//
//  EllipseViewController.m
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/12/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import "EllipseViewController.h"

@interface EllipseViewController ()

@end

@implementation EllipseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    EllipseControl * control = [[EllipseControl alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];;
    [self.view addSubview:control];
    self.control = control;
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.control.center = self.view.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
