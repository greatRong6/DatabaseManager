//
//  UIAlertController+GZRAlertController.m
//  JYJAdViewController
//
//  Created by iosdev on 2017/11/6.
//  Copyright © 2017年 shanqi. All rights reserved.
//

#import "UIAlertController+GZRAlertController.h"

@implementation UIAlertController (GZRAlertController)

+(void)initWithShowTitle:(NSString *)alertTitle message:(NSString *)alertMessage viewController:(UIViewController *)viewController{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    [viewController presentViewController:alertController animated:YES completion:nil];
    
}

+(void)initWithShowTitle:(NSString *)alertTitle
                 message:(NSString *)alertMessage
                   style:(GZRAlertType)stype
             cancleTitle:(NSString *)cancleTitle
                otherBtn:(NSArray *)otherArr
          viewController:(UIViewController *)viewController
            successBlock:(SuccessBlock)successBlock{
    
    if (stype == GZRAlertStyleAlert) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消");
        }]];
        for (int i = 0; i < otherArr.count; i++) {
            [alertController addAction:[UIAlertAction actionWithTitle:otherArr[i] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                NSString *index = [NSString stringWithFormat:@"%d",i + 1];
                if (successBlock) {
                    successBlock(otherArr[i],index);
                }
            }]];
        }
        [viewController presentViewController:alertController animated:YES completion:nil];
        
    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消");
        }]];
        for (int i = 0; i < otherArr.count; i++) {
            [alertController addAction:[UIAlertAction actionWithTitle:otherArr[i] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                NSString *index = [NSString stringWithFormat:@"%d",i + 1];
                if (successBlock) {
                    successBlock(otherArr[i],index);
                }
            }]];
        }
        [viewController presentViewController:alertController animated:YES completion:nil];
        
    }
}

+(void)initWithShowAddTextF:(NSString *)alertTitle
                    message:(NSString *)alertMessage
                cancleTitle:(NSString *)cancleTitle
                 holderText:(NSString *)holderText
                   otherBtn:(NSArray *)otherArr
             viewController:(UIViewController *)viewController
               successBlock:(SuccessBlock)successBlock{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (successBlock) {
            successBlock(@"确定",alertController.textFields[0].text);
        }
    }]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = holderText;
    }];
    [viewController presentViewController:alertController animated:YES completion:nil];
    
}

@end
