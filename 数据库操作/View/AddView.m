//
//  AddView.m
//  数据库操作
//
//  Created by iosdev on 2017/9/18.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import "AddView.h"

@implementation AddView

-(void)awakeFromNib{

    [super awakeFromNib];
    self.nameTextF.delegate = self;
    self.ageTextF.delegate = self;
//    self.heightTextF.delegate = self;
//    self.preferenTextF.delegate = self;
//    self.chinTextF.delegate =self;
//    self.mathTextF.delegate = self;
//    self.EnglishF.delegate = self;
    self.telTextF.delegate = self;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self endEditing:NO];
    return YES;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
