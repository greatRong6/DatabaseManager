//
//  WCDManager.h
//  WCDBTest
//
//  Created by iosdev on 2017/9/18.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCDModel.h"
@interface WCDManager : NSObject

+(WCDManager *)defaultManager;

//关闭数据库
+(void)killDB;

//添加数据
- (BOOL)insertUser:(WCDModel*)mod;

//更新所有的数据
- (BOOL)updateUser:(WCDModel*)mod;

//根据userid进行更新数据
- (BOOL)updateAgeAndUserIDWithMod:(WCDModel*)mod;

//通过model进行删除
- (BOOL)deleteUser:(WCDModel*)mod;

//删除所有
- (BOOL)deleteAllUsers;

//通过userid查询
- (WCDModel *)getUserWithId:(NSString*)userID;

//根据号查询
- (NSArray*)getUsersWithTelNum:(NSInteger)telNum;

//查询所有数据
- (NSArray*)getAllUser;

@end
