//
//  CustomPushAnimatedTransition.m
//  GoForward
//
//  Created by xianmingchen on 16/3/21.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "CustomPushAnimatedTransition.h"

@implementation CustomPushAnimatedTransition
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 2;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UINavigationController *navigationController = toViewController.navigationController;
    
    CGRect screenSize = [UIScreen mainScreen].bounds;
    
    BOOL statusBarHidden = toViewController.prefersStatusBarHidden;
    BOOL navigationBarHidden = navigationController.navigationBarHidden;
    BOOL toolBarHidden = navigationController.toolbarHidden;
    
    
    CGRect frame = screenSize;
    if (!navigationBarHidden) {
        CGFloat navigationBarHeight = CGRectGetHeight(navigationController.navigationBar.frame);
        frame.origin.y += navigationBarHeight;
        frame.size.height -= navigationBarHeight;
    }
    
    if (!statusBarHidden)
    {
        frame.origin.y += 20;
        frame.size.height -= 20;
    }
    
    if (!toolBarHidden)
    {
        frame.size.height -= CGRectGetHeight(navigationController.toolbar.frame);
    }

    
    toViewController.view.frame = frame;

    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}

@end
