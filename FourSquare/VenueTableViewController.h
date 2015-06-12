//
//  VenueTableViewController.h
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/10/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueTableViewController : UITableViewController
@property (strong,nonatomic) NSMutableArray* venueList;
@property (assign,nonatomic) int page;
@property (assign,nonatomic) bool isLoading;
@property (assign,nonatomic) bool allLoaded;
@end
