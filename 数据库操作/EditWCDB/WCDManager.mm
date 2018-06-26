//
//  WCDManager.m
//  WCDBTest
//
//  Created by iosdev on 2017/9/18.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import "WCDManager.h"
#import "WCDModel+WCTTableCoding.h"

static WCDManager *instance = nil;
static NSString *const UserTable = @"user";

@interface WCDManager ()
@property (nonatomic,strong) WCTDatabase *dataBase;
@property (nonatomic,strong) WCTTable    *table;
@end

@implementation WCDManager

+(WCDManager *)defaultManager
{
    if (instance) {
        return instance;
    }
    @synchronized (self) {
        if (instance == nil) {
            instance = [[WCDManager alloc]init];
            [instance creatDB];
        }
    }
    return instance;
}

+(void)killDB
{
    instance = nil;
}

- (BOOL)creatDB
{
    
    NSString *dbPath = [self getDBPath];
    NSLog(@"DBPath:%@",dbPath);
    self.dataBase = [[WCTDatabase alloc]initWithPath:dbPath];
    BOOL result   = [self.dataBase createTableAndIndexesOfName:UserTable withClass:WCDModel.class];
    self.table    = [self.dataBase getTableOfName:UserTable withClass:WCDModel.class];
  
    assert(result);
    
    
    if ([self.dataBase canOpen]) {
        NSLog(@"能打开数据库");
    }else{
        NSLog(@"不能打开数据库");
    }
    if ([self.dataBase isOpened]) {
        NSLog(@"打开中");
    }else{
        NSLog(@"没打开");
    }
    return result;
}

- (NSString *)getDBPath {
    NSString *databasePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database/userID"];
    databasePath = [databasePath stringByAppendingPathComponent:@"user.db"];
    return databasePath;
}

- (BOOL)insertUser:(WCDModel*)mod
{
    return [self.table insertObject:mod];
}

- (BOOL)updateUser:(WCDModel*)mod
{
    return [self.table updateRowsOnProperties:WCDModel.AllProperties withObject:mod where:WCDModel.telNum == mod.telNum];
}

- (BOOL)updateAgeAndUserIDWithMod:(WCDModel*)mod
{
    return [self.table updateRowsOnProperties:{WCDModel.telNum,WCDModel.userID,WCDModel.pinyin}  withObject:mod where:WCDModel.userName == mod.userName];
}

- (BOOL)deleteUser:(WCDModel*)mod
{
    return [self.table deleteObjectsWhere:WCDModel.telNum == mod.telNum];
}

- (BOOL)deleteAllUsers
{
    return [self.table deleteAllObjects];
}

- (WCDModel *)getUserWithId:(NSString*)userID
{
    return [self.table getObjectsWhere:WCDModel.userID == userID].firstObject;
}

- (NSArray *)getUserWithName:(NSString *)pinyin{
    
    return [self.table getObjectsWhere:(WCDModel.pinyin.like([NSString stringWithFormat:@"%%%@%%",pinyin]),WCDModel.telNum.like([NSString stringWithFormat:@"%%%@%%",pinyin]))];
    
}

- (NSArray*) :(NSInteger)telNum
{
    return [self.table getObjectsWhere:WCDModel.telNum == telNum];
}

- (NSArray*)getAllUser
{
    return [self.table getAllObjects];
}

@end
