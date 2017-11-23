//
//  UIAlertController+GZRAlertController.h
//  JYJAdViewController
//
//  Created by iosdev on 2017/11/6.
//  Copyright © 2017年 shanqi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GZRAlertType){
    
    GZRAlertStyleAlert,
    GZRAlertStyleActionSheet
    
};

typedef void(^SuccessBlock)(id value,id value1);

@interface UIAlertController (GZRAlertController)


/**
 *  提示框
 *
 *  @param alertTitle   提示标题
 *  @param alertMessage 提示内容
 */
+(void)initWithShowTitle:(NSString *)alertTitle
                 message:(NSString *)alertMessage
          viewController:(UIViewController *)viewController;

/**
 *  提示框
 *
 *  @param alertTitle   提示标题
 *  @param alertMessage 提示内容
 */
+(void)initWithShowTitle:(NSString *)alertTitle
                 message:(NSString *)alertMessage
                   style:(GZRAlertType)stype
             cancleTitle:(NSString *)cancleTitle
                otherBtn:(NSArray *)otherArr
          viewController:(UIViewController *)viewController
            successBlock:(SuccessBlock)successBlock;

/**
 *  提示框    添加输入框
 *
 *  @param alertTitle   提示标题
 *  @param alertMessage 提示内容
 */
+(void)initWithShowAddTextF:(NSString *)alertTitle
                    message:(NSString *)alertMessage
                cancleTitle:(NSString *)cancleTitle
                 holderText:(NSString *)holderText
                   otherBtn:(NSArray *)otherArr
             viewController:(UIViewController *)viewController
               successBlock:(SuccessBlock)successBlock;


@end
