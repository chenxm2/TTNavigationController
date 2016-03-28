//
//  TTNavigationController.m
//  GoForward
//
//  Created by xianmingchen on 16/3/18.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "TTNavigationController.h"
#import "TTPushAnimatedTransition.h"
#import "TTPopAnimatedTransition.h"
/*
 * intercept UINavigationControllerDelegate message for TTNavigationController
 *
 */
@interface UINavigationControllerDeleagteInterceptor : NSObject
@property (nonatomic, weak) id realDelegate;                    //the readDeleagte set to TTNavigationController
@property (nonatomic, weak) id navigationController;            //is TTNavigationController
@end

@implementation UINavigationControllerDeleagteInterceptor
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([_navigationController respondsToSelector:aSelector])
    {
        return _navigationController;
    }
    if ([_realDelegate respondsToSelector:aSelector])
    {
        return _realDelegate;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    
    if ([_navigationController respondsToSelector:aSelector])
    {
        return YES;
    }
    if ([_realDelegate respondsToSelector:aSelector])
    {
        return YES;
    }
    
    return [super respondsToSelector:aSelector];
}
@end

@interface TTNavigationController ()
@property (nonatomic, strong) UINavigationControllerDeleagteInterceptor *interceptor;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionTransition;
@property (nonatomic, strong) TTPushAnimatedTransition *pushAnimator;
@property (nonatomic, strong) TTPopAnimatedTransition *popAnimator;
@property (nonatomic, assign) BOOL isPushingOrPoping;
@end

@implementation TTNavigationController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScreenEdgePanGestureRecognizer * panRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGesture:)];
    panRecognizer.edges = UIRectEdgeLeft;
    
    [self.view addGestureRecognizer:panRecognizer];
    
    _isPushingOrPoping = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //user not set the delegate, to active UINavigationControllerDeleagteInterceptor
    if ([super delegate] == nil)
    {
        [self setDelegate:nil];
    }
}


- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    if (_interceptor == nil)
    {
        _interceptor = [[UINavigationControllerDeleagteInterceptor alloc] init];
    }
    
    _interceptor.realDelegate = delegate;
    _interceptor.navigationController = self;

    [super setDelegate:(id<UINavigationControllerDelegate>)_interceptor];
}

#pragma mark - UIPanGestureRecognizer Action
- (void)onPanGesture:(UIPanGestureRecognizer *)panGesture
{
    UIView* view = self.view;
    if (panGesture.state == UIGestureRecognizerStateBegan)
    {
        if (self.viewControllers.count > 1)
        {
            self.interactionTransition = [UIPercentDrivenInteractiveTransition new];
            [self popViewControllerAnimated:YES];
        }
    }
    else if (panGesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [panGesture translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionTransition updateInteractiveTransition:d];
    }
    else if (panGesture.state == UIGestureRecognizerStateEnded)
    {
        if ([panGesture velocityInView:view].x > 0)
        {
            [self.interactionTransition finishInteractiveTransition];
        }
        else
        {
            [self.interactionTransition cancelInteractiveTransition];
        }
        self.interactionTransition = nil;
    }
}

#pragma mark - get Push or Pop Ainmator
- (TTPushAnimatedTransition *)pushAnimator
{
    if  (_pushAnimator == nil)
    {
        _pushAnimator = [[TTPushAnimatedTransition alloc] init];
    }
    
    return _pushAnimator;
}

- (TTPopAnimatedTransition *)popAnimator
{
    if (_popAnimator == nil)
    {
        _popAnimator = [[TTPopAnimatedTransition alloc] init];
    }
    
    return _popAnimator;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //give back to realDeleagte
    if ([_interceptor.realDelegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)])
    {
        [_interceptor.realDelegate navigationController:navigationController willShowViewController:viewController animated:animated];
    }
    
    //remove the warning
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    //set the navigation bar appearance
    if ([viewController respondsToSelector:@selector(preferredNavigationBarHidden)])
    {
        BOOL preferredNavigationBarHidden = [viewController performSelector:@selector(preferredNavigationBarHidden)];
        [self setNavigationBarHidden:preferredNavigationBarHidden animated:animated];
    }
    
    if ([viewController respondsToSelector:@selector(preferredNavigationBarTranslucent)])
    {
        BOOL preferredNavigationBarTranslucent = [viewController performSelector:@selector(preferredNavigationBarTranslucent)];
        [self.navigationBar setTranslucent:preferredNavigationBarTranslucent];
    }
    
    if ([viewController respondsToSelector:@selector(preferredNavigationBarBackgroundColor)])
    {
        UIColor *backgroundColor = [viewController performSelector:@selector(preferredNavigationBarBackgroundColor)];
        
        if ([self.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
            self.navigationBar.barTintColor = backgroundColor;
        }
    }
    
    if ([viewController respondsToSelector:@selector(preferredNavigationBarBackgroundImageForBarMetrics:)])
    {
        UIImage *defaultImage =
        defaultImage = [viewController performSelector:@selector(preferredNavigationBarBackgroundImageForBarMetrics:) withObject:UIBarMetricsDefault];
        [self.navigationBar setBackgroundImage:defaultImage forBarMetrics:UIBarMetricsDefault];
    }
    
    if ([viewController respondsToSelector:@selector(preferredNavigationBarShadowImage)])
    {
        UIImage *image = [viewController performSelector:@selector(preferredNavigationBarShadowImage)];
        [self.navigationBar setShadowImage:image];
    }
    #pragma clang diagnostic pop
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //give back to realDeleagte
    if ([_interceptor.realDelegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [_interceptor.realDelegate navigationController:navigationController didShowViewController:viewController animated:YES];
    }
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    //give back to realDeleagte
    if ([_interceptor.realDelegate respondsToSelector:@selector(navigationController:interactionControllerForAnimationController:)]) {
        return [_interceptor.realDelegate navigationController:navigationController interactionControllerForAnimationController:animationController];
    }
    else
    {
        return self.interactionTransition;
    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    
    //remove the warning
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

    BOOL responds = [[UIViewController class] respondsToSelector:@selector(TTCheckUIViewControllerTTNavigationCategoryExist)];
#pragma clang diagnostic pop
    
    if ([_interceptor.realDelegate respondsToSelector:@selector(navigationController:animationControllerForOperation:fromViewController:toViewController:)]
        && !responds /*the project not use UIViewController+TTNavigation File*/)
    {
        //give control back to realDeleagte
        return [_interceptor.realDelegate navigationController:navigationController animationControllerForOperation:operation fromViewController:fromVC toViewController:toVC];
    }
    else if ([fromVC respondsToSelector:@selector(navigationController:animationControllerForOperation:fromViewController:toViewController:)] || [toVC respondsToSelector:@selector(navigationController:animationControllerForOperation:fromViewController:toViewController:)])
    {
        __autoreleasing id<UIViewControllerAnimatedTransitioning> animator = nil;
        id target = nil;
        
        if (operation == UINavigationControllerOperationPush && [fromVC respondsToSelector:@selector(navigationController:animationControllerForOperation:fromViewController:toViewController:)])
        {
            target = fromVC;
        }
        else if (operation == UINavigationControllerOperationPop && [toVC respondsToSelector:@selector(navigationController:animationControllerForOperation:fromViewController:toViewController:)])
        {
            target = toVC;
        }
        
        if (target)
        {
            NSMethodSignature *methodSignature = [target methodSignatureForSelector:@selector(navigationController:animationControllerForOperation:fromViewController:toViewController:)];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
            [invocation setSelector:@selector(navigationController:animationControllerForOperation:fromViewController:toViewController:)];
            [invocation setTarget:target];
            [invocation setArgument:&navigationController atIndex:2];
            [invocation setArgument:&operation atIndex:3];
            [invocation setArgument:&fromVC atIndex:4];
            [invocation setArgument:&toVC atIndex:5];
            
            [invocation invoke];
            [invocation getReturnValue:&animator];
            
            return animator;
        }
        else
        {
            return nil;
        }
    }
    else
    {
        if (operation == UINavigationControllerOperationPush)
        {
            return self.pushAnimator;
        }
        else if (operation == UINavigationControllerOperationPop)
        {
            return self.popAnimator;
        }
        else
        {
            return nil;
        }   
    }
}

#pragma mark - over write from UINavigationController
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.isPushingOrPoping) {
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf pushViewController:viewController animated:animated];
        });
        
        return;
    }
    
    [super pushViewController:viewController animated:animated];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.isPushingOrPoping) {
        
        __block UIViewController *viewController = nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            viewController = [super popViewControllerAnimated:animated];
        });
        return viewController;
    }
    UIViewController *viewController = [super popViewControllerAnimated:animated];
    return viewController;
}


#pragma mark - over write from UIViewController
- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.topViewController preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden {
    return [self.topViewController prefersStatusBarHidden];
}
@end
