# TTNavigationController


 TTNavigationController is subClass of UINavigationController
 it provide that:<br/>
 1、left screenedgepangesturere to pop controller<br/>
 2、custom the navigationBar appearance by realize TTViewControllerNavigationAppearanceProtocol<br/>
 3、custom the push and pop animatedTransition by realize TTViewControllerNavigationTransitionProtocol<br/>

 suggestion:<br/>
 the TTNavigationController very suitable for create a new app. if your app is exist, it also work.
 if you have a app. in app, most scheme of the navigationBar appearance and the 
 animatedTransition is same. you can use the UIViewController+TTNavigation and change
 the initial value at the begin of method those realize from TTViewControllerNavigationAppearanceProtocol.
 example: 
      
      the method is in UIViewController+TTNavigation
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


 And in some scheme you want make different, you can realize the methods ind TTViewControllerNavigationProtocol.h
 in your viewController(must subclass of UIViewController). The primary class method has
 the higher priority.
 If you use the UIViewController+TTNavigation, you can no longer use the 
 UINavigationController's delegate to make the animatedTransition. You Just can use the
 TTViewControllerNavigationAppearanceProtocol and TTViewControllerNavigationTransitionProtocol to do this;

 ！！！important:if you are chinese,you can read document file to know why I design this.Or you only can read the code.
 you can learn the useage detail from the TTNavigationDemo
/
