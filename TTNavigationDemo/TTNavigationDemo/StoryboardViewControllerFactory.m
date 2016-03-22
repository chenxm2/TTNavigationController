//
//  StoryboardViewControllerFactory.m
//  GoForward
//
//  Created by xianmingchen on 16/3/18.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "StoryboardViewControllerFactory.h"

@implementation StoryboardViewControllerFactory
- (instancetype)initWithStoryboard:(UIStoryboard *)storyboard
{
    NSParameterAssert(storyboard);
    self = [super init];
    
    if (self) {
        _storyboard = storyboard;
    }
    return self;
}
@end
