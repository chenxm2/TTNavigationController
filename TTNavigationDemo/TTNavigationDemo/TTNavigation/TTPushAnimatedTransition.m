//
//  TTPushAnimatedTransition.m
//  GoForward
//
//  Created by xianmingchen on 16/3/21.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "TTPushAnimatedTransition.h"

@implementation TTPushAnimatedTransition
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.33;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    CGRect screenSize = [UIScreen mainScreen].bounds;
    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UINavigationController *navigationController = toViewController.navigationController;
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
    
    CGRect finalFrame = frame;
    frame.origin.x += frame.size.width;
    toViewController.view.frame = frame;
    [[transitionContext containerView] addSubview:toViewController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
