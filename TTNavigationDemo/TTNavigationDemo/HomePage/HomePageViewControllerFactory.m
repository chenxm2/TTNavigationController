//
//  HomePageViewControllerFactory.m
//  GoForward
//
//  Created by xianmingchen on 16/3/18.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "HomePageViewControllerFactory.h"

@implementation HomePageViewControllerFactory
+ (instancetype)sharedFactory
{
    dispatch_once_t onceToken;
    static HomePageViewControllerFactory *g_instance = nil;
    
    dispatch_once(&onceToken, ^{
        g_instance = [[HomePageViewControllerFactory alloc] initWithStoryboard:[UIStoryboard storyboardWithName:@"HomePage" bundle:[NSBundle mainBundle]]];
    });
    
    return g_instance;
}

- (UINavigationController *)instantiateHomePageNavigationController
{
    return [self.storyboard instantiateInitialViewController];
}
@end
