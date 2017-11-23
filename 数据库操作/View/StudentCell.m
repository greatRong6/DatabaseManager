//
//  StudentCell.m
//  数据库操作
//
//  Created by iosdev on 2017/11/16.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import "StudentCell.h"
#import "StudentModel.h"
#import "WCDModel.h"

@implementation StudentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Initialization code
}

-(void)initWithData:(id)data{
    
    StudentModel *model = (StudentModel *)data;
    self.name.text = [NSString stringWithFormat:@"姓名:%@",model.name];
    self.telNum.text = [NSString stringWithFormat:@"手机号:%@",model.telNum];
    
}

-(void)initWithModelData:(id)data{
    
    WCDModel *model = (WCDModel *)data;
    self.name.text = [NSString stringWithFormat:@"姓名:%@",model.userName];
    self.telNum.text = [NSString stringWithFormat:@"手机号:%@",model.telNum];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
