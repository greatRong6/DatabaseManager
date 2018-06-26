//
//  RealmManager.h
//  数据库操作
//
//  Created by iosdev on 2017/11/24.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "RLMRealm.h"
#import "RealmModel.h"

@interface RealmManager : NSObject

+(instancetype)shareInstance;

//创建数据库
-(BOOL)openRealmD;

//添加数据
- (void)creatDataBaseWithName:(RealmModel *)model;

@end
