//
//  UIViewController+AppController.m
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/10/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import "UIViewController+AppController.h"
#import "objc/runtime.h"

@implementation UIViewController(AppController)
- (void) setAppController:(AppController *)theAppController; {
    objc_setAssociatedObject(self, @selector(appController), theAppController, OBJC_ASSOCIATION_ASSIGN);
}

- (AppController *) appController; {
    return objc_getAssociatedObject(self, @selector(appController));
}

@end
