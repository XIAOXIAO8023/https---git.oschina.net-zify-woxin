//
//  ViewUtils.h
//  JuTuanHuiYN
//
//  Created by 陆楠 on 14/12/15.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewUtils : NSObject

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;//创建纯色UIImage
/**
 *  改变view的高度
 *
 *  @param view   视图
 *  @param height 更新后高度
 *
 *  @return 更新后的视图
 */
+(BOOL)updateView:(UIView*)view byHeight:(float) height;
@end
