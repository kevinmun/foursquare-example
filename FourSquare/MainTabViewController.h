//
//  MainTabViewController.h
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/10/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDataViewController.h"
#import "VenueTableViewController.h"
#import "UIViewController+AppController.h"

@interface MainTabViewController : UITabBarController

@property (strong, nonatomic) UserDataViewController *userDataViewController;
@property (strong, nonatomic) VenueTableViewController *venueTableViewController;

@end
