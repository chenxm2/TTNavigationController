//
//  secondHomeViewController.m
//  GoForward
//
//  Created by xianmingchen on 16/3/18.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "secondHomeViewController.h"
#import "ThirdHomeViewController.h"
#import "TTViewControllerNavigationProtocol.h"

@interface secondHomeViewController () <TTViewControllerNavigationAppearanceProtocol>

@end

@implementation secondHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)secondButtonClicked:(id)sender {
    ThirdHomeViewController *thirdHomeViewController = [[ThirdHomeViewController alloc] init];
    [self.navigationController pushViewController:thirdHomeViewController animated:YES];
}

- (UIColor *)preferredNavigationBarBackgroundColor
{
    return [UIColor redColor];
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
