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
static NSString* versioning =@"20150611";
static NSString* mode= @"foursquare";
static NSString* userUrl = @"https://api.foursquare.com/v2/users/self?oauth_token=%@&v=%@&m=%@";
static NSString* venueUrl = @"https://api.foursquare.com/v2/venues/explore?oauth_token=%@&ll=40.7,-74&limit=%d&offset=%d&v=%@&m=%@";

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

#pragma mark api calls - could be separated into a rest manager class
- (void) getUserData:(void (^)(NSData *, NSError *)) handler{
    NSString* token = [AppPref getToken];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:userUrl ,token,versioning,mode]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(handler!=nil)
                handler(received,error);
        });
    });
}

- (void) getVenueData:(int)offset limit:(int)limit completion:(void(^)(VenueList *, NSError *))handler{
     NSString* token = [AppPref getToken];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:venueUrl ,token,limit,offset,versioning,mode]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:&error];
        VenueList *venueList = [[VenueList alloc]init];
        [venueList translateVenues:jsonDic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(handler!=nil)
                handler(venueList,error);
        });
    });
}


#pragma mark nib controller construction - could be separated into a builder class

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

-(EllipseViewController *) constructEllipseViewController {
    EllipseViewController* ellipseController =  [[EllipseViewController alloc] initWithNibName:@"EllipseViewController" bundle:nil];
    [ellipseController setAppController:self];
    return ellipseController;
}



@end
