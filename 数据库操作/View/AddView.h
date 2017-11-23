//
//  AddView.h
//  数据库操作
//
//  Created by iosdev on 2017/9/18.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddView : UIView<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextF;
@property (weak, nonatomic) IBOutlet UITextField *ageTextF;
//@property (weak, nonatomic) IBOutlet UITextField *heightTextF;
//@property (weak, nonatomic) IBOutlet UITextField *preferenTextF;
//@property (weak, nonatomic) IBOutlet UITextField *chinTextF;
//@property (weak, nonatomic) IBOutlet UITextField *mathTextF;
//@property (weak, nonatomic) IBOutlet UITextField *EnglishF;
@property (weak, nonatomic) IBOutlet UITextField *telTextF;


@end
