//
//  HomePageViewControllerFactory.h
//  GoForward
//
//  Created by xianmingchen on 16/3/18.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "StoryboardViewControllerFactory.h"

@interface HomePageViewControllerFactory : StoryboardViewControllerFactory

+ (instancetype)sharedFactory;

- (UINavigationController *)instantiateHomePageNavigationController;
@end
