//
//  AppController.h
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/10/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "WebViewController.h"
#import "UserDataViewController.h"
#import "VenueTableViewController.h"

@interface AppController : NSObject
- (void) onLaunch;
- (void) launchLoginSession;
- (WebViewController*) constructWebViewController;
- (UserDataViewController*) constructUserDataViewController;
- (VenueTableViewController*) constructVenueTableViewController;

@end
