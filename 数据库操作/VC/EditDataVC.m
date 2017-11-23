//
//  EditDataVC.m
//  数据库操作
//
//  Created by iosdev on 2017/11/14.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import "EditDataVC.h"
#import "AddView.h"
#import "StudentModel.h"
#import "EditFMDB.h"
#import "UIAlertController+GZRAlertController.h"
#import "NSString+category.h"

#import "WCDModel.h"
#import "WCDManager.h"

#define DEF_WIDTH [UIScreen mainScreen].bounds.size.width
#define DEF_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface EditDataVC ()

@property (nonatomic,strong)AddView *add;

@end

@implementation EditDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑资料";
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, 20, 20);
    [addBtn setTitle:@"保存" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(backcleck) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_WIDTH, DEF_HEIGHT)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    self.add = [[[NSBundle mainBundle] loadNibNamed:@"AddView" owner:self options:nil] lastObject];
    self.add.frame = CGRectMake(0, 0, DEF_WIDTH, 100);
    [scrollView addSubview:self.add];
    
    scrollView.contentSize = CGSizeMake(DEF_WIDTH, DEF_HEIGHT);
    
    // Do any additional setup after loading the view.
}

-(void)backcleck{
    
    StudentModel *model = [[StudentModel alloc] init];
    model.name = self.add.nameTextF.text;
    model.userID = [self ret32bitString];
    model.telNum = self.add.telTextF.text;
    model.pinyin = [NSString transformToPinyin:model.name];
    
    // 插入数据
    if ([self.isFmdb isEqualToString:@"0"]) {
        
        BOOL isOpen = [[EditFMDB shareInstance] openFMDBName:@"people.sqlite"];
        
        if (isOpen) {
            
            BOOL success = [[EditFMDB shareInstance] insetTitle:model withPath:@"people.sqlite"];
            NSLog(@"数据添加成功  %d",success);
            if (self.backBlcok) {
                self.backBlcok();
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            [UIAlertController initWithShowTitle:@"提示" message:@"打开数据库失败" viewController:self];
            return;
            
        }
        
    }else{
        
        WCDModel *tempMod = [WCDModel new];
        tempMod.createdate =  [[NSDate date] timeIntervalSince1970]*1000;
        tempMod.userName = self.add.nameTextF.text;
        tempMod.userID = [self ret32bitString];
        tempMod.telNum = self.add.telTextF.text;
        
        NSLog(@"tempMod.userID %@",tempMod.userID);
        
        if ([[WCDManager defaultManager] insertUser:tempMod]) {
            NSLog(@"添加字段成功");
            if (self.backBlcok) {
                self.backBlcok();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [UIAlertController initWithShowTitle:@"提示" message:@"添加字段失败" viewController:self];
        }
        
    }
    
}

-(NSString *)ret32bitString
{
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
