//
//  AppPref.m
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/10/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import "AppPref.h"

@interface AppPref()

@end

@implementation AppPref

NSString *const sToken = @"token";

+(void) saveToken:(NSString*) token{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:sToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*) getToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:sToken];
}

+ (void) clearCookie {
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
