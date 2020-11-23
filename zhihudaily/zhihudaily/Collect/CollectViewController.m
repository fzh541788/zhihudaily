//
//  CollectViewController.m
//  zhihudaily
//
//  Created by young_jerry on 2020/11/19.
//

#import "CollectViewController.h"
#import "CollectSonTableViewCell.h"
#import "FMDB.h"
#import "Manager.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
@interface CollectViewController ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    // 去除多余黑线问题
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.tableView.bounds),0)];
    _tableView.tableFooterView = v;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tag = 111;
    self.storiesTitle = [[NSMutableArray alloc]init];
    self.storiesImages = [[NSMutableArray alloc]init];
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"agree.sqlite"];
    self.path = fileName;
    [self queryData];
//    NSLog(@"%@",self.TestId);
    _i = 0;
    while (_TestId.count != _i) {
        [self test:_TestId[_i++]];
    }

    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _TestId.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.tableView.frame.size.height/7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
       CollectSonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CollectSonTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (self.storiesTitle.count == _i) {
        cell.newsTitle.text = [self.storiesTitle objectAtIndex:indexPath.row];
        [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:[_storiesImages objectAtIndex:indexPath.row]]];
    }
    
    return cell;
}
- (void) queryData{
    FMDatabase *dataBase = [FMDatabase databaseWithPath:self.path];
    NSLog(@"%@",self.path);
    if ([dataBase open]) {
    // 1.执行查询语句
    FMResultSet *resultSet = [dataBase executeQuery:@"SELECT * FROM t_agreeOrder"];
    // 2.遍历结果
        self.TestId = [[NSMutableArray alloc]init];
    while ([resultSet next]) {
        NSString *bankStr = [resultSet stringForColumn:@"id"];
        [self.TestId addObject:bankStr];
    }
        [dataBase close];
    } else {
        NSLog(@"打开数据库失败");
    }
}
- (void)test:(NSString *)a {
//    NSLog(@"%@",a);
    [[Manager sharedManager]NetWorkCollectWithData:a and:^(CollectModel * _Nonnull mainViewNowModel) {
//        NSLog(@"%@ %@",a,mainViewNowModel.title);
//        NSLog(@"请求成功");
            [self.storiesTitle addObject: mainViewNowModel.title];
            [self.storiesImages addObject:mainViewNowModel.image];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        } error:^(NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        FMDatabase *dataBase = [FMDatabase databaseWithPath:self.path];
        if ([dataBase open]) {
            BOOL result = [dataBase executeUpdate:@"delete from t_agreeOrder where id = ?",self->_TestId[indexPath.row]];
            if (result) {
//                NSLog(@"删除数据成功");
            } else {
                NSLog(@"删除数据失败");
            }
            [dataBase close];
        }
//        dispatch_async(dispatch_get_main_queue(), ^{
        [self queryData];
        self->_i = 0;
        while (self->_TestId.count != self->_i) {
            [self test:self->_TestId[self->_i++]];
        }
        [self.tableView reloadData];
//        });
        completionHandler (YES);
        
    }];
    deleteRowAction.backgroundColor = [UIColor redColor];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
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
