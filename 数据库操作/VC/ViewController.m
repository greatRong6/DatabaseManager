//
//  ViewController.m
//  数据库操作
//
//  Created by iosdev on 2017/9/15.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import "ViewController.h"
#import "AddStudentVC.h"
#import "EditFMDB.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextField *passTextF;
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    [self creatTableView];
    
    self.dataSource = [[NSMutableArray alloc] initWithArray:@[@"FMDB",@"WCDB",@"Realm"]];

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)creatTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddStudentVC *student = [[AddStudentVC alloc] init];
    NSString *isFmdb = self.dataSource[indexPath.row];
    if ([isFmdb isEqualToString:@"FMDB"]) {
        student.isFmdb = @"0";
    }else if([isFmdb isEqualToString:@"WCDB"]){
        student.isFmdb = @"1";
    }else{
        student.isFmdb = @"2";
    }
    [self.navigationController pushViewController:student animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
