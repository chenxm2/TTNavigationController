//
//  UIViewController+TTNavigation.m
//  GoForward
//
//  Created by xianmingchen on 16/3/22.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "UIViewController+TTNavigation.h"
#import <objc/runtime.h>


@interface MethodInfo : NSObject
@property (nonatomic, assign) IMP imp;
@property (nonatomic, assign) SEL sel;
@property (nonatomic, copy) NSString *methodName;
@property (nonatomic, assign) NSUInteger count;         //count of imp with the same name of the methodName;
@end

@implementation MethodInfo
@end

@implementation UIViewController (TTNavigation)

- (MethodInfo *)lastMethodInfoWithName:(NSString *)methodName
{
    if ([methodName length] <= 0)
    {
        return nil;
    }
    
    MethodInfo *methodInfo = [[MethodInfo alloc] init];
    Class currentClass = [self class];
    
    if (currentClass)
    {
        unsigned int methodCount;
        Method *methodList = class_copyMethodList(currentClass, &methodCount);
        IMP lastImp = NULL;
        SEL lastSel = NULL;
        for (NSInteger i = 0; i < methodCount; i++)
        {
            Method method = methodList[i];
            NSString *compareMethodName = [NSString stringWithCString:sel_getName(method_getName(method))
                                                      encoding:NSUTF8StringEncoding];
            if ([methodName isEqualToString:compareMethodName])
            {
                lastImp = method_getImplementation(method);
                lastSel = method_getName(method);
                methodInfo.count += 1;
            }
        }
        
        methodInfo.methodName = methodName;
        methodInfo.sel = lastSel;
        methodInfo.imp = lastImp;
        
        free(methodList);
    }
    
    return methodInfo;
}

- (BOOL)isPrimaryClassRealizeMethod:(MethodInfo *)methodInfo
{
    BOOL result = NO;
    
    if (methodInfo && methodInfo.imp != NULL
        && methodInfo.sel != NULL
        && methodInfo.count > 1 /*realize in primary class*/)
    {
        result = YES;
    }
    
    return result;
}

#pragma mark - TTViewControllerProtocol
/**
 *  Default is NO.
 */
- (BOOL)preferredNavigationBarHidden
{
    BOOL result = NO;

    MethodInfo *methodInfo = [self lastMethodInfoWithName:@"preferredNavigationBarHidden"];
    if ([self isPrimaryClassRealizeMethod:methodInfo])
    {
        typedef BOOL (*funcType)(id,SEL);
        funcType func = (funcType)methodInfo.imp;
        
        result = func(self, methodInfo.sel);
    }
    
    return result;
}

/**
 *  Default is NO.
 */
- (BOOL)preferredNavigationBarTranslucent
{
    BOOL result = NO;
    
    MethodInfo *methodInfo = [self lastMethodInfoWithName:@"preferredNavigationBarTranslucent"];
    if ([self isPrimaryClassRealizeMethod:methodInfo])
    {
        typedef BOOL (*funcType)(id,SEL);
        funcType func = (funcType)methodInfo.imp;
        
        result = func(self, methodInfo.sel);
    }

    return result;
}

/**
 *  Default is nil.
 *
 *  @param barMetrics see UIBarMetrics
 */
- (UIImage *)preferredNavigationBarBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics
{
    UIImage *result = nil;
    
    
    MethodInfo *methodInfo = [self lastMethodInfoWithName:@"preferredNavigationBarBackgroundImageForBarMetrics:"];
    if ([self isPrimaryClassRealizeMethod:methodInfo])
    {
        typedef UIImage* (*funcType)(id, SEL, UIBarMetrics);
        funcType func = (funcType)methodInfo.imp;
        
        result = func(self, methodInfo.sel, barMetrics);
    }
    
    return result;
}

/**
 *  Default is nil.
 */
- (UIImage *)preferredNavigationBarShadowImage
{
    UIImage *result = nil;
    
    MethodInfo *methodInfo = [self lastMethodInfoWithName:@"preferredNavigationBarShadowImage"];
    if ([self isPrimaryClassRealizeMethod:methodInfo])
    {
        typedef UIImage* (*funcType)(id, SEL);
        funcType func = (funcType)methodInfo.imp;
        
        result = func(self, methodInfo.sel);
    }

    
    return result;
}

/**
 *  Default is nil.
 */
- (UIColor *)preferredNavigationBarBackgroundColor
{
    UIColor *result = [UIColor yellowColor];
    
    MethodInfo *methodInfo = [self lastMethodInfoWithName:@"preferredNavigationBarBackgroundColor"];
    if ([self isPrimaryClassRealizeMethod:methodInfo])
    {
        typedef UIColor* (*funcType)(id, SEL);
        funcType func = (funcType)methodInfo.imp;
        
        result = func(self, methodInfo.sel);
    }
    
    return result;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC;
{
    id<UIViewControllerAnimatedTransitioning> result = nil;
    
    MethodInfo *methodInfo = [self lastMethodInfoWithName:@"preferredNavigationBarBackgroundColor"];
    if ([self isPrimaryClassRealizeMethod:methodInfo])
    {
        typedef id<UIViewControllerAnimatedTransitioning> (*funcType)(id, SEL, UINavigationController *, UINavigationControllerOperation, UIViewController *, UIViewController *);
        funcType func = (funcType)methodInfo.imp;
        
        result = func(self, methodInfo.sel, navigationController, operation, fromVC, toVC);
    }
    
    return result;
}

@end
