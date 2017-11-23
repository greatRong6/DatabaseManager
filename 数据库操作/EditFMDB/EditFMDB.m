//
//  EditFMDB.m
//  数据库操作
//
//  Created by iosdev on 2017/9/15.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import "EditFMDB.h"
#import "StudentModel.h"

#define PATH_OF_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface EditFMDB()



@end

@implementation EditFMDB

//static FMDatabase *database;

+(instancetype)shareInstance{

    static EditFMDB *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EditFMDB alloc] init];
    });
    return instance;
    
}

-(BOOL)openFMDBName:(NSString *)pathStr{
    
    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey:@"fmdbPath"];
    if ([path isEqualToString:pathStr]) {
        NSLog(@"表已创建");
        return YES;
    }

    NSString* docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:pathStr];//数据库名
    FMDatabase *database = [FMDatabase databaseWithPath:dbpath];
    //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。

    if ([database open]){
        
        //4.创建表 t_people   ID integer primary key autoincrement, 
        BOOL result = [database executeUpdate:@"create table if not exists t_people (userID varchar(100), name varchar(100),telNum varchar(100),pinyin varchar(100))"];//表里面的字段
        if (result){
            NSLog(@"创建表成功");
            [[NSUserDefaults standardUserDefaults] setObject:pathStr forKey:@"fmdbPath"];
            return YES;
        }
        NSLog(@"数据库打开成功，创建表成功");
        
    }else{
        
        NSLog(@"创建表失败");
        [database close];
        return NO;
        
    }
    return NO;
    
}

/**
 *  增加
 */
-(BOOL)insetTitle:(id)model withPath:(NSString *)pathStr{
    
    __block BOOL success = NO;

    StudentModel *user = (StudentModel *)model;
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:pathStr];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbpath];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *rs= [db executeQuery:@"select * from t_people where userID =?", user.userID];

        if ([rs next]) {
            
            success = [db executeUpdate:@"update t_people set userID =?,name =?,telNum =?,pinyin =?",user.userID,user.name,user.telNum,user.pinyin];
            NSLog(@"更新数据成功  ID：%@", user.userID);
            
        }else{
        
            success = [db executeUpdate:@"insert into t_people (userID,name,telNum,pinyin) values (?,?,?,?)",user.userID,user.name,user.telNum,user.pinyin];
            NSLog(@"新增数据成功  ID：%@", user.userID);

        }
        
        [rs close];
        
    }];
    
    return success;
    
}

/**
 *  删除 根据userid进行删除
 */
-(void)deleteWithTitle:(NSString *)pathStr withUserID:(NSString *)userId{
    
//    FMDatabaseQueue *queue;
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:pathStr];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbpath];

    [queue inDatabase:^(FMDatabase *db) {
        
        BOOL flag = [db executeUpdate:@"delete from t_people where userID = ?",userId];
        if (flag) {
            NSLog(@"删除数据成功");
        }
        else{
            NSLog(@"删除数据失败");
        }
        
    }];
    
}
//删除所有数据
-(void)deleteWithTitle:(NSString *)pathStr{
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:pathStr];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbpath];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        BOOL flag = [db executeUpdate:@"delete from t_people"];
        if (flag) {
            NSLog(@"删除数据成功");
        }
        else{
            NSLog(@"删除数据失败");
        }
        
    }];
    
}

/**
 *  更新数据   修改
 */
-(void)updateWithModel:(id)model{
    
    StudentModel *user = (StudentModel *)model;
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"people.sqlite"];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbpath];

    [queue inDatabase:^(FMDatabase *db) {
        
        BOOL flag = [db executeUpdate:@"update t_people set userID = ?, telNum = ?, pinyin = ? where name = ?",user.userID,user.telNum, user.pinyin,user.name];
        if (flag) {
            NSLog(@"更新数据成功");
        }
        else{
            NSLog(@"更新数据失败");
        }
        
    }];
}

/**
 *  条件查询数据
 */
-(void)selectWithTitle:(NSString *)userId withUserID:(NSString *)pathStr{
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:pathStr];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbpath];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from t_people where userID = ?",userId];
        while ([rs next]) {
            
            StudentModel *user = [[StudentModel alloc] init];
            user.userID = [rs stringForColumn:@"userID"];
            user.name = [rs stringForColumn:@"name"];
            user.telNum = [rs stringForColumn:@"telNum"];
            user.pinyin = [rs stringForColumn:@"pinyin"];
            
            NSLog(@"userID:%@---name:%@----telNum:%@",user.userID,user.name,user.telNum);
//            [self.Array addObject:dic];
            
        }
    }];
}

/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod:(NSString *)pathStr withBlock:(void(^)(id Success))block{
    
    //每次进来查询的时候,先清除上次缓存数据
//    [self.Array removeAllObjects];
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:pathStr];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbpath];

    NSMutableArray *array  =[[NSMutableArray alloc] init];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from t_people"];
        while ([rs next]) {
            
            StudentModel *user = [[StudentModel alloc] init];
            user.userID = [rs stringForColumn:@"userID"];
            user.name = [rs stringForColumn:@"name"];
            user.telNum = [rs stringForColumn:@"telNum"];
            user.pinyin = [rs stringForColumn:@"pinyin"];
            
            NSLog(@"userID:%@---name:%@----telNum:%@",user.userID,user.name,user.telNum);

            [array addObject:user];
            
        }
        block(array);
        
    }];
}

//查询数据(去除重复数据)
-(NSArray *)queryDataWithTableName:(NSString *)pathStr keyword:(NSString *)keyword{
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:pathStr];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbpath];

    
    NSMutableArray *resultArray = [NSMutableArray new];
    NSMutableArray * tempArray = [NSMutableArray new];
    
    NSString *selectResult;
    if (keyword.length != 0 || keyword){
        selectResult = [NSString stringWithFormat:@"select * from t_people where pinyin like '%%%@%%' or telNum like '%%%@%%'", keyword,keyword];
    }else{
        selectResult = [NSString stringWithFormat:@"select * from %@",@"t_people"];
    }
    
    [queue inDatabase:^(FMDatabase *db) {
        // 先清空数组
        [resultArray removeAllObjects];
        [tempArray removeAllObjects];
        
        //执行循环查询操作
        FMResultSet *rs = [db executeQuery:selectResult];
        
        while ([rs next]){
            
            StudentModel *model = [[StudentModel alloc] init];
            model.name = [rs stringForColumn:@"name"];
            model.telNum = [rs stringForColumn:@"telNum"];
            model.userID = [rs stringForColumn:@"userID"];
            model.pinyin = [rs stringForColumn:@"pinyin"];
            
            BOOL isbool = [tempArray containsObject:model.pinyin];
            
            if (!isbool) {
                
                [tempArray addObject:model.pinyin];
                [resultArray addObject:model];
                
            }
        }
        
    }];
    
    return resultArray;
}

- (void)close {
    FMDatabase *fmBase;
    [fmBase close];
    fmBase = nil;
}


@end
