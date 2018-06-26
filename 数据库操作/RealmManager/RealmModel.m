//
//  RealmModel.m
//  数据库操作
//
//  Created by iosdev on 2017/11/24.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import "RealmModel.h"

@implementation RealmModel

//主键
+ (NSString *)primaryKey {
    return @"userID";
}

////设置属性默认值
//+ (NSDictionary *)defaultPropertyValues {
//    return @{@"dialCode":@"00" };
//}

//设置忽略属性,即不存到realm数据库中
+ (NSArray<NSString *> *)ignoredProperties {
    return @[@""];
}

//一般来说,属性为nil的话realm会抛出异常,但是如果实现了这个方法的话,就只有countryId为nil会抛出异常,也就是说现在dialCode属性可以为空了
+ (NSArray *)requiredProperties {
    return @[@"userID"];
}

//设置索引,可以加快检索的速度
+ (NSArray *)indexedProperties {
    return @[@"userID"];
}

@end
