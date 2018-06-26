//
//  RealmManager.m
//  数据库操作
//
//  Created by iosdev on 2017/11/24.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import "RealmManager.h"

#define RealmPath @"realmDB.realm"

@implementation RealmManager

+(instancetype)shareInstance{
    
    static RealmManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RealmManager alloc] init];
    });
    return instance;
    
}

-(BOOL)openRealmD{
    
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [docPath objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:RealmPath];
    NSLog(@"数据库目录 = %@",filePath);
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL URLWithString:filePath];
//    config.objectClasses = @[MyClass.class, MyOtherClass.class];
    config.readOnly = NO;
    int currentVersion = 0;
    config.schemaVersion = currentVersion;
    
    config.migrationBlock = ^(RLMMigration *migration , uint64_t oldSchemaVersion) {
        
        // 这里是设置数据迁移的block
        if (oldSchemaVersion < currentVersion) {
            
        }
        
    };
    
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    return YES;
    
}

- (void)creatDataBaseWithName:(RealmModel *)model
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docPath stringByAppendingPathComponent:RealmPath];
    NSLog(@"数据库目录 = %@",dbPath);
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        RLMRealm *realm = [RLMRealm realmWithURL:[NSURL URLWithString:dbPath]];
        [realm transactionWithBlock:^(){
            [realm addObject:model];
            [realm commitWriteTransaction];
        }];

//    });
    
    NSLog(@"realm 添加成功");
    
}


@end
