//
//  WCDModel+WCTTableCoding.h
//  WCDBTest
//
//  Created by iosdev on 2017/9/18.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import "WCDModel.h"
#import <WCDB/WCDB.h>


@interface WCDModel (WCTTableCoding)<WCTTableCoding>

WCDB_PROPERTY(userName)
WCDB_PROPERTY(userID)
WCDB_PROPERTY(telNum)
WCDB_PROPERTY(pinyin)

WCDB_PROPERTY(location)
WCDB_PROPERTY(createdate)

@end
