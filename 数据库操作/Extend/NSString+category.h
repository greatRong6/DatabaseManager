//
//  NSString+category.h
//  FuzzySearch
//
//  Created by iosdev on 2017/9/15.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (category)

#pragma mark--获取汉字转成拼音字符串 通讯录模糊搜索 支持拼音检索 首字母 全拼 汉字 搜索
+ (NSString *)transformToPinyin:(NSString *)aString;

@end
