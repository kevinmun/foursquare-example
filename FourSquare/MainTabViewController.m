//
//  MainTabViewController.m
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/10/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import "MainTabViewController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

-(void) loadView{
    [super loadView];
    
    self.userDataViewController = [self.appController constructUserDataViewController];
    self.userDataViewController.title = NSLocalizedString(@"UserDataViewController_title", nil);
    self.userDataViewController.tabBarItem.image = [UIImage imageNamed:@"dash.png"];
    self.userDataViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"dashon.png"];
    
    self.venueTableViewController = [self.appController constructVenueTableViewController];
    self.venueTableViewController.title = NSLocalizedString(@"VenueTableViewController_title", nil);
    self.venueTableViewController.tabBarItem.image = [UIImage imageNamed:@"dash.png"];
    self.venueTableViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"dashon.png"];
    
    UINavigationController *userDataTab = [[UINavigationController alloc] initWithRootViewController:self.userDataViewController];
    UINavigationController *venueTab = [[UINavigationController alloc] initWithRootViewController:self.venueTableViewController];

    self.viewControllers = @[userDataTab,
                             venueTab];
    
    //disable editing of tab bar
    self.customizableViewControllers = @[];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
