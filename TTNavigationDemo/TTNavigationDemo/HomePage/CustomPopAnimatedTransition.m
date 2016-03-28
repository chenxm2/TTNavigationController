//
//  CustomPopAnimatedTransition.m
//  GoForward
//
//  Created by xianmingchen on 16/3/21.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "CustomPopAnimatedTransition.h"

@implementation CustomPopAnimatedTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 2;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        BOOL cancel = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!cancel];
        
        if (!cancel)
        {
            [fromViewController.view removeFromSuperview];
        }
        else
        {
            fromViewController.view.alpha = 1;
        }
    }];
}

@end
