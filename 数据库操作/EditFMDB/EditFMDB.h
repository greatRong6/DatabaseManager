//
//  EditFMDB.h
//  数据库操作
//
//  Created by iosdev on 2017/9/15.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface EditFMDB : NSObject

+(instancetype)shareInstance;

//创建表是否成功
-(BOOL)openFMDBName:(NSString *)pathStr;

/**
 *  增加
 */
-(BOOL)insetTitle:(id)model withPath:(NSString *)pathStr;

/**
 *  删除   根据userid进行删除
 */
-(void)deleteWithTitle:(NSString *)pathStr withUserID:(NSString *)userId;

/**
 *  删除所有数据
 */
-(void)deleteWithTitle:(NSString *)pathStr;

/**
 *  更新数据   修改
 */
-(void)updateWithModel:(id)model;

/**
 *  条件查询数据
 */
-(void)selectWithTitle:(NSString *)userId withUserID:(NSString *)pathStr;

/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod:(NSString *)pathStr withBlock:(void(^)(id Success))block;

//查询数据(去除重复数据)
-(NSArray *)queryDataWithTableName:(NSString *)pathStr keyword:(NSString *)keyword;


@end













