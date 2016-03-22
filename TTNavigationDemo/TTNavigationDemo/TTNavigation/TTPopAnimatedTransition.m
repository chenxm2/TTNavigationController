//
//  TTPopAnimatedTransition.m
//  GoForward
//
//  Created by xianmingchen on 16/3/21.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "TTPopAnimatedTransition.h"

@implementation TTPopAnimatedTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.33;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    CGRect frame = fromViewController.view.frame;
    
    CGRect finalFrame = frame;
    finalFrame.origin.x += finalFrame.size.width;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        
        BOOL cancel = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!cancel];
        
        if (!cancel)
        {
            [fromViewController.view removeFromSuperview];
        }
    }];
}
@end
