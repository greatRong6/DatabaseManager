//
//  WCDModel+WCTTableCoding.m
//  WCDBTest
//
//  Created by iosdev on 2017/9/18.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import "WCDModel+WCTTableCoding.h"

@implementation WCDModel (WCTTableCoding)


#pragma mark - 定义绑定到数据库表的类
WCDB_IMPLEMENTATION(WCDModel)

#pragma mark - 定义需要绑定到数据库表的字段
WCDB_SYNTHESIZE(WCDModel, userName)
WCDB_SYNTHESIZE(WCDModel, userID)
WCDB_SYNTHESIZE(WCDModel, telNum)

WCDB_SYNTHESIZE(WCDModel, location)
WCDB_SYNTHESIZE(WCDModel, createdate)
#pragma mark - 设置主键
WCDB_PRIMARY(WCDModel, createdate)

//#pragma mark - 设置索引
WCDB_INDEX(WCDModel, "_index", createdate)


@end
