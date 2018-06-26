//
//  RealmModel.h
//  数据库操作
//
//  Created by iosdev on 2017/11/24.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import <Realm/Realm.h>

@interface RealmModel : RLMObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *userID;
@property (nonatomic,copy)NSString *telNum;
@property (nonatomic,copy)NSString *pinyin;

@end

