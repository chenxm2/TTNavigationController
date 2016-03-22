//
//  StoryboardViewControllerFactory.h
//  GoForward
//
//  Created by xianmingchen on 16/3/18.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIStoryboard.h>
@interface StoryboardViewControllerFactory : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@property (nonatomic, strong, readonly) UIStoryboard *storyboard;

/**
 *  The designated initializer
 *
 *  @param storyboard create Factory's storyboard, must not nil
 *
 *  @return initialized `StoryboardViewControllerFactory` instance
 */
- (instancetype)initWithStoryboard:(UIStoryboard *)storyboard NS_DESIGNATED_INITIALIZER;
@end
