//
//  UIViewController+TTNavigation.h
//  GoForward
//
//  Created by xianmingchen on 16/3/22.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

/*
* suggestion & important:
* the TTNavigationController very suitable for create a new app. if your app is exist, it also work.
* if you have a app. in app, most scheme of the navigationBar appearance and the
* animatedTransition is same. you can use the UIViewController+TTNavigation and change
* the initial value at the begin of method those realize from TTViewControllerNavigationProtocol.h.
* example:
*
*      the method is in UIViewController+TTNavigation
- (UIColor *)preferredNavigationBarBackgroundColor
{
    UIColor *result = [UIColor yellowColor]; (this is the initial value, you can change it);
    
    MethodInfo *methodInfo = [self lastMethodInfoWithName:@"preferredNavigationBarBackgroundColor"];
    if ([self isPrimaryClassRealizeMethod:methodInfo])
    {
        typedef UIColor* (*funcType)(id, SEL);
        funcType func = (funcType)methodInfo.imp;
        
        result = func(self, methodInfo.sel);
    }
    
    return result;
}
*
*
* And in some scheme you want make different, you can realize methods in TTViewControllerNavigationProtocol.h
* in your viewController(must subclass of UIViewController). The primary class method has
* the higher priority.
*
* So you can use this file to set for the default scheme.
* And you also don't need it at all, if so, you should add it to your project.
 
* If you use the UIViewController+TTNavigation, you can no longer use the
* UINavigationController's delegate to make the animatedTransition. You Just can use the
* method in TTViewControllerNavigationProtocol to do this;
*/


#import <UIKit/UIKit.h>
#import "TTViewControllerNavigationProtocol.h"
@interface UIViewController (TTNavigation) <TTViewControllerNavigationAppearanceProtocol, TTViewControllerNavigationTransitionProtocol>

@end
