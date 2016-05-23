//
//  HomePageViewController.m
//  GoForward
//
//  Created by xianmingchen on 16/3/18.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "HomePageViewController.h"
#import "secondHomeViewController.h"
#import "CustomPushAnimatedTransition.h"
#import "CustomPopAnimatedTransition.h"
#import "TTViewControllerNavigationProtocol.h"


@interface HomePageViewController () <TTViewControllerNavigationTransitionProtocol>
@property (nonatomic, strong) CustomPushAnimatedTransition *customPush;
@property (nonatomic, strong) CustomPopAnimatedTransition *customPop;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClicked:(id)sender {
    secondHomeViewController *seconController = [[secondHomeViewController alloc] init];
    
    [self.navigationController pushViewController:seconController animated:YES];
}


#pragma mark - TTViewControllerNavigationTransitionProtocol
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    id<UIViewControllerAnimatedTransitioning> animatedTransition = nil;
    if (operation == UINavigationControllerOperationPush)
    {
        animatedTransition = self.customPush;
    }
    else if (operation == UINavigationControllerOperationPop)
    {
        animatedTransition = self.customPop;
    }
    
    return animatedTransition;
    
}

#pragma mark - Getting 
- (CustomPopAnimatedTransition *)customPop
{
    if (_customPop == nil)
    {
        _customPop = [CustomPopAnimatedTransition new];
    }
    
    return _customPop;
}

- (CustomPushAnimatedTransition *)customPush
{
    if (_customPush == nil)
    {
        _customPush = [CustomPushAnimatedTransition new];
    }
    
    return _customPush;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
