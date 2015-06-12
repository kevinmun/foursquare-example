//
//  VenueList.m
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/11/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import "VenueList.h"
#import "NSDictionary+Path.h"
typedef NS_ENUM(NSInteger, Err) {
    ErrErrorExtract = 10001,
    ErrErrorTranslate = 10002
};


@implementation VenueList
@synthesize venues;

-(void) translateVenues:(NSDictionary *)dict error:(NSError**) error{
    venues = [self extractVenuesArray:dict error:error];
}

-(NSArray *) extractVenuesArray:(NSDictionary*)dict error:(NSError**) error{
    NSArray * groups = (NSArray*)[dict objectForPath:@"response.groups"];
    NSObject *items = [(NSDictionary*)[groups objectAtIndex:0] objectForKey:@"items"];
    NSMutableArray * venueArray = nil;
    if(items!=nil){
        NSArray *rawArray = (NSArray*) items;
        venueArray = [[NSMutableArray alloc]initWithCapacity:rawArray.count];
        for (NSDictionary* object in rawArray){
            Venue * translatedVenue = [self translateVenue:object];
            if(translatedVenue!=nil){
               [venueArray addObject:translatedVenue];
            } else {
                NSLog(@"failed to translate venue with data: %@", object);
            }
        }
    } else {
        NSString *msg = @"Error extracting venue from raw dictionary";
        NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys: msg, NSLocalizedDescriptionKey, nil];
        *error = [NSError errorWithDomain:@"Ipropertytest.net" code:ErrErrorExtract userInfo:info];
    }
    return venueArray;
}

-(Venue*) translateVenue:(NSDictionary*) rawObject{
    Venue* venue = [[Venue alloc]init];
    venue.name = (NSString*)[rawObject objectForPath:@"venue.name"];
    venue.address = (NSString*)[rawObject objectForPath:@"venue.location.address"];
    return venue;
}
                             
                             
@end
