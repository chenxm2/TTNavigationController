# TTNavigationController

/** 
* TTNavigationController is subClass of UINavigationController
* it provide that:
* 1、left screenedgepangesturere to pop controller
* 2、custom the navigationBar appearance by realize TTViewControllerProtocol
* 3、custom the push and pop animatedTransition by realize TTViewControllerProtocol
*
* suggestion:
* the TTNavigationController very suitable for create a new app. if your app is exist, it also work.
* if you have a app. in app, most scheme of the navigationBar appearance and the 
* animatedTransition is same. you can use the UIViewController+TTNavigation and change
* the initial value at the begin of method those realize from TTViewControllerProtocol.
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
* And in some scheme you want make different, you can realize TTViewControllerProtocol
* in your viewController(must subclass of UIViewController). The primary class method has
* the higher priority.
*
* you can learn more useage detail from the TTNavigationDemo
*/
