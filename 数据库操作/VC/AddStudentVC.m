//
//  AddStudentVC.m
//  数据库操作
//
//  Created by iosdev on 2017/9/18.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import "AddStudentVC.h"
#import "AddView.h"
#import "StudentModel.h"
#import "EditFMDB.h"
#import "EditDataVC.h"
#import "StudentCell.h"
#import "UIAlertController+GZRAlertController.h"

#import "WCDModel.h"
#import "WCDManager.h"

#define DEF_WIDTH [UIScreen mainScreen].bounds.size.width
#define DEF_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface AddStudentVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation AddStudentVC

-(NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
    
}
-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

//UISearchBar作为tableview的头部
-(UIView *)headView{
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, 100, 44)];
    searchBar.keyboardType = UIKeyboardAppearanceDefault;
    searchBar.placeholder = @"请输入搜索关键字";
    searchBar.delegate = self;
    //底部的颜色
    searchBar.barTintColor = [UIColor colorWithRed:200/225.0 green:200/225.0 blue:200/225.0 alpha:1];
    searchBar.searchBarStyle = UISearchBarStyleDefault;
    searchBar.barStyle = UIBarStyleDefault;
    return searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"数据显示";
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    addBtn.frame = CGRectMake(0, 0, 20, 20);
    [addBtn addTarget:self action:@selector(addcleck) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    [self creatTableView];
    
    [self loadData];
    
    // Do any additional setup after loading the view.
}

-(void)addcleck{
    
    EditDataVC *edit = [[EditDataVC alloc] init];
    edit.isFmdb = self.isFmdb;
    __weak AddStudentVC *weakSelf = self;
    edit.backBlcok = ^{
        [weakSelf loadData];
    };
    [self.navigationController pushViewController:edit animated:YES];
    
}

-(void)loadData{
    
    [self.dataArray removeAllObjects];
    [self.dataSource removeAllObjects];
    
    if ([self.isFmdb isEqualToString:@"0"]) {
        __weak AddStudentVC *weakSelf = self;
        [[EditFMDB shareInstance] selectAllMethod:@"people.sqlite" withBlock:^(id Success) {
            
            NSArray *array =(NSArray *)Success;
            NSLog(@"array --- %@",array);
            [weakSelf.dataArray addObjectsFromArray:array];
            [weakSelf.dataSource addObjectsFromArray:weakSelf.dataArray];
            
            [weakSelf.tableView reloadData];
            
        }];
        
    }else{
        
        NSArray *array = [[WCDManager defaultManager] getAllUser];
        
        NSLog(@"tempMod %@",array);
        
        [self.dataArray addObjectsFromArray:array];
        [self.dataSource addObjectsFromArray:self.dataArray];
        [self.tableView reloadData];
        
    }

}

-(void)creatTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StudentCell" bundle:nil] forCellReuseIdentifier:@"StudentCell"];
    self.tableView.tableFooterView = [[UIView alloc] init];

    self.tableView.tableHeaderView = [self headView];
    
    UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleBtn.backgroundColor = [UIColor redColor];
    deleBtn.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
    [deleBtn setTitle:@"全部删除" forState:UIControlStateNormal];
    deleBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [deleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleBtn addTarget:self action:@selector(deleClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleBtn];
    
}

-(void)deleClick{
    
    if ([self.isFmdb isEqualToString:@"0"]) {
        [[EditFMDB shareInstance] deleteWithTitle:@"people.sqlite"];
    }else{
        [[WCDManager defaultManager] deleteAllUsers];
    }
    [self loadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StudentCell *cell = nil;
    static NSString *cellId = @"StudentCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if ([self.isFmdb isEqualToString:@"0"]) {
        StudentModel *model = self.dataSource[indexPath.row];
        [cell initWithData:model];
    }else{
        WCDModel *model = self.dataSource[indexPath.row];
        [cell initWithModelData:model];
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak AddStudentVC *weakSelf = self;
    [UIAlertController initWithShowAddTextF:@"提示" message:@"修改手机号" cancleTitle:@"取消" holderText:@"请输入手机号" otherBtn:@[@"确定"] viewController:self successBlock:^(id value, id value1) {
        NSString *numStr = (NSString *)value1;
        if ([weakSelf.isFmdb isEqualToString:@"0"]) {
            StudentModel *model = weakSelf.dataSource[indexPath.row];
            model.telNum = numStr;
            [[EditFMDB shareInstance] updateWithModel:model];
        }else{
            WCDModel *model = weakSelf.dataSource[indexPath.row];
            model.telNum = numStr;
            [[WCDManager defaultManager] updateAgeAndUserIDWithMod:model];
        }
        [weakSelf loadData];
    }];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if ([self.isFmdb isEqualToString:@"0"]) {
            
            StudentModel *model = self.dataSource[indexPath.row];
            [[EditFMDB shareInstance] deleteWithTitle:@"people.sqlite" withUserID:model.userID];
            
        }else{
            
            WCDModel *model = self.dataSource[indexPath.row];
            [[WCDManager defaultManager] deleteUser:model];
            
        }
        
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

#pragma mark-searchBarDelegate
//在搜索框中修改搜索内容时，自动触发下面的方法
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    NSLog(@"开始输入搜索内容");
    searchBar.showsCancelButton = YES;//取消的字体颜色，
    [searchBar setShowsCancelButton:YES animated:YES];
    
    //改变取消的文本
    for(UIView *view in [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"输入搜索内容完毕");
}

//搜框中输入关键字的事件响应
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSLog(@"输入的关键字是---%@---%lu",searchText,(unsigned long)searchText.length);
    
    //需要事先清空存放搜索结果的数组
    [self.dataSource removeAllObjects];
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        if ([self.isFmdb isEqualToString:@"0"]) {
            
            if (searchText!=nil && searchText.length>0) {
                NSArray *array = [[EditFMDB shareInstance] queryDataWithTableName:@"people.sqlite" keyword:searchText];
                [self.dataSource addObjectsFromArray:array];
            }else{
                self.dataSource = [NSMutableArray arrayWithArray:self.dataArray];
            }
            
        }else{
            
            if (searchText!=nil && searchText.length>0) {
                NSArray *array = [[WCDManager defaultManager] getUserWithName:searchText];
                [self.dataSource addObjectsFromArray:array];
            }else{
                self.dataSource = [NSMutableArray arrayWithArray:self.dataArray];
            }

        }
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
    
}

//取消的响应事件
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"取消搜索");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
}

//键盘上搜索事件的响应
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"搜索");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

/**  本地搜索的时候   搜索内容
 if (searchText!=nil && searchText.length>0) {
 
 //遍历需要搜索的所有内容，其中self.dataArray为存放总数据的数组
 for (Student *model in self.dataArray) {
 
 //----------->把所有的搜索结果转成成拼音
 NSString *pinyin = [NSString transformToPinyin:model.name];
 NSLog(@"pinyin--%@",pinyin);
 
 if ([pinyin rangeOfString:searchText options:NSCaseInsensitiveSearch].length >0 ) {
 //把搜索结果存放self.resultArray数组
 [self.dataSource addObject:model];
 }
 }
 
 }else{
 
 self.dataSource = [NSMutableArray arrayWithArray:self.dataArray];
 }
 */

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
