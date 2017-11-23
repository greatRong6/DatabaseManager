//
//  PeopleCell.m
//  数据库操作
//
//  Created by iosdev on 2017/9/27.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import "PeopleCell.h"

@implementation PeopleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.content = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.content.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:self.content];
        
    }
    return self;
    
}

-(void)initWithConTent:(NSString *)content{
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
