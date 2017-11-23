//
//  EditDataVC.h
//  数据库操作
//
//  Created by iosdev on 2017/11/14.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditDataVC : UIViewController

@property (nonatomic,copy) NSString *isFmdb;
@property (nonatomic,copy)void (^backBlcok)();

@end
