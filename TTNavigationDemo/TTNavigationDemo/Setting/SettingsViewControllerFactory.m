//
//  SettingsViewControllerFactory.m
//  GoForward
//
//  Created by xianmingchen on 16/3/21.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "SettingsViewControllerFactory.h"

@implementation SettingsViewControllerFactory
+ (instancetype)sharedFactory
{
    dispatch_once_t onceToken;
    static SettingsViewControllerFactory *g_instance = nil;
    
    dispatch_once(&onceToken, ^{
        g_instance = [[SettingsViewControllerFactory alloc] initWithStoryboard:[UIStoryboard storyboardWithName:@"Settings" bundle:[NSBundle mainBundle]]];
    });
    
    return g_instance;
}

- (UINavigationController *)instantiateSettingsNavigationController
{
    return [self.storyboard instantiateInitialViewController];
}
@end
