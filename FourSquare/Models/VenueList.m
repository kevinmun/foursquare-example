//
//  VenueList.m
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/11/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import "VenueList.h"

@implementation VenueList
@synthesize venues;
@synthesize results;

-(void) translateVenues:(NSDictionary *)dict{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSDictionary * response = [dict objectForKey:@"response"];
    //results =response objectForKey:@""
}
@end
