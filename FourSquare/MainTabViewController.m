//
//  MainTabViewController.m
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/10/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import "MainTabViewController.h"
#import "UIViewController+AppController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

-(instancetype)initWithAppController:(AppController*)appController{
    self = [super init];
    if(self){
        [self setAppController:appController];
        [self populateViewController];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) populateViewController {
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


@end
