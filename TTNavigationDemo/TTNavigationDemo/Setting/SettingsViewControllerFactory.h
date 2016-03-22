//
//  SettingsViewControllerFactory.h
//  GoForward
//
//  Created by xianmingchen on 16/3/21.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "StoryboardViewControllerFactory.h"
@interface SettingsViewControllerFactory : StoryboardViewControllerFactory
+ (instancetype)sharedFactory;

- (UINavigationController *)instantiateSettingsNavigationController;

@end
