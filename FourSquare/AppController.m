//
//  AppController.m
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/10/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import "AppController.h"
#import "MainTabViewController.h"
#import "LoginViewController.h"
#import "UIViewController+AppController.h"
#import "AppPref.h"

@interface AppController()
@property (nonatomic, strong) MainTabViewController *mainTabViewController;
@property (nonatomic, strong) LoginViewController *loginViewController;
@property (nonatomic, strong) UIWindow *window;
-(void) setup;
@end

@implementation AppController

-(void) onLaunch {
    [self setup];
    [self launchNewSession];
    [self.window makeKeyAndVisible];
}

-(void) setup {
     self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
}

-(void) launchNewSession {
    self.loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.loginViewController setAppController:self];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:self.loginViewController];
    self.window.rootViewController = navController;
}

-(void) launchLoginSession {
    //if no token is found, bring user back to login
    if([AppPref getToken] == nil){
        [self launchNewSession];
        return;
    }
    
    if(self.mainTabViewController == nil){
        self.mainTabViewController = [[MainTabViewController alloc] initWithAppController:self];
    }
    
    if(self.window.rootViewController == nil) {
        self.window.rootViewController = self.mainTabViewController;
        [self.window makeKeyAndVisible];
    } else if(self.window.rootViewController != self.mainTabViewController){
        [UIView transitionFromView:self.window.rootViewController.view
                            toView: self.mainTabViewController.view
                          duration:0.65f
                           options: UIViewAnimationOptionTransitionCurlUp
                        completion:^(BOOL finished){
                            self.window.rootViewController = self.mainTabViewController;
                        }];
    }
    
}




#pragma nib controller construction

- (WebViewController *) constructWebViewController {
    WebViewController* webViewController =  [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    [webViewController setAppController:self];
    return webViewController;
}

- (UserDataViewController *) constructUserDataViewController {
    UserDataViewController* userDataController =  [[UserDataViewController alloc] initWithNibName:@"UserDataViewController" bundle:nil];
    [userDataController setAppController:self];
    return userDataController;
}

- (VenueTableViewController *) constructVenueTableViewController {
    VenueTableViewController* venueController =  [[VenueTableViewController alloc] initWithNibName:@"VenueTableViewController" bundle:nil];
    [venueController setAppController:self];
    return venueController;
}



@end
