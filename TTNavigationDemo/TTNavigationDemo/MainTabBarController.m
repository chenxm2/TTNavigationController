//
//  MainTabBarController.m
//  GoForward
//
//  Created by xianmingchen on 16/3/17.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomePageViewControllerFactory.h"
#import "SettingsViewControllerFactory.h"

@interface MainTabBarController () <UITabBarControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UINavigationController *homePageNavController;
@property (nonatomic, strong) UINavigationController *meNavController;
@property (nonatomic, strong) UINavigationController *settingsNavController;
@end

@implementation MainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _homePageNavController = [[HomePageViewControllerFactory sharedFactory] instantiateHomePageNavigationController];
    _homePageNavController.delegate = self;
    _settingsNavController = [[SettingsViewControllerFactory sharedFactory] instantiateSettingsNavigationController];
    _settingsNavController.delegate = self;
    
    self.viewControllers = @[_homePageNavController, _settingsNavController];
}

#pragma mark - StatusBarStyle
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.selectedViewController preferredStatusBarStyle];
}

#pragma mark - UIViewController (UIViewControllerRotation)
- (BOOL)shouldAutorotate
{
    return [[self selectedViewController] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [[self selectedViewController] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self selectedViewController].preferredInterfaceOrientationForPresentation;
}
@end
