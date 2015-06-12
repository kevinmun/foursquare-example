//
//  MainTabViewController.h
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/10/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

@class AppController;
#import <UIKit/UIKit.h>
#import "UserDataViewController.h"
#import "VenueTableViewController.h"
#import "EllipseViewController.h"

@interface MainTabViewController : UITabBarController

@property (strong, nonatomic) UserDataViewController *userDataViewController;
@property (strong, nonatomic) VenueTableViewController *venueTableViewController;
@property (strong, nonatomic) EllipseViewController *ellipseViewController;

/**
 inits tab controller with the app controller which is vital to populating the other view controllers into the tab controller.
 tab controller will fail to populate the available view controllers if not init with appcontroller
 
 */
- (instancetype)initWithAppController:(AppController*)appController;

@end
