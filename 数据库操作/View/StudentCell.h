//
//  StudentCell.h
//  数据库操作
//
//  Created by iosdev on 2017/11/16.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *telNum;

-(void)initWithData:(id)data;
-(void)initWithModelData:(id)data;
-(void)initWithRealmData:(id)data;

@end
