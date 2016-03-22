//
//  TTViewControllerProtocol.h
//  GoForward
//
//  Created by xianmingchen on 16/3/18.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TTViewControllerProtocol <NSObject>
@optional

#pragma mark - navigationBar Appearance
/*
 * realize the protocol method to custom your viewController's navigationBar
 * you will get a default Appearance with the default value bellow
 */

/**
 *  Default is NO.
 */
- (BOOL)preferredNavigationBarHidden;

/**
 *  Default is NO.
 */
- (BOOL)preferredNavigationBarTranslucent;

/**
 *  Default is nil.
 *
 *  @param barMetrics see UIBarMetrics
 */
- (UIImage *)preferredNavigationBarBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics;

/**
 *  Default is nil.
 */
- (UIImage *)preferredNavigationBarShadowImage;

/**
 *  Default is nil.
 */
- (UIColor *)preferredNavigationBarBackgroundColor;


#pragma mark - navigation push or pop Transitioning
/*
 * realize the protocol method or realize by yourself's UINavigationControllerDelegate to custom your viewController's push or pop Transitioning.
 * or you will get a default Transitioning by default， it like system
 *
 * important:if you realize the protocol, you should know that.
 * suppose now the top viewController is A, and bellow A is B, they both in the navigationController,
 * If you push Controller C, then the message will be send to A.
 * If you pop Controller A, then the message will be send to B.
 * design like this because now C rely on A and A rely on B.
 * generally, we can use A on C file and we shouldn't use C on A file.
 */
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC;
@end

