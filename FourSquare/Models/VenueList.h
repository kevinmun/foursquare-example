//
//  VenueList.h
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/11/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Venue.h"
@interface VenueList : NSObject
@property (strong,nonatomic) NSArray *venues;
@property (assign, nonatomic) int results;

-(void) translateVenues:(NSDictionary *)dict;
@end
