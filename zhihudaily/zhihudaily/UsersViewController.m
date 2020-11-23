//
//  UsersViewController.m
//  zhihudaily
//
//  Created by young_jerry on 2020/10/31.
//

#import "UsersViewController.h"
#import "CollectViewController.h"

@interface UsersViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame =CGRectMake( 170, 60, 100, 100);
    [but setImage:[UIImage imageNamed:@"001.jpg"] forState:UIControlStateNormal];
    but.layer.cornerRadius = 50;
    but.clipsToBounds = YES;
    [self.tableView addSubview:but];
    
    UILabel *butLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, 190, 150, 30)];
    butLabel.text = @"复杂化";
    butLabel.font = [UIFont systemFontOfSize:25];
    [self.tableView addSubview:butLabel];
    
    UIButton *butSecond = [UIButton buttonWithType:UIButtonTypeCustom];
    butSecond.frame =CGRectMake( 150, 660, 50, 50);
    [butSecond setImage:[UIImage imageNamed:@"yejianmoshi.png"] forState:UIControlStateNormal];
    [self.tableView addSubview:butSecond];
    
    UILabel *butSecondLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 720, 150, 30)];
    butSecondLabel.text = @"夜间模式";
    butSecondLabel.font = [UIFont systemFontOfSize:15];
    [self.tableView addSubview:butSecondLabel];
    
    UIButton *butThird = [UIButton buttonWithType:UIButtonTypeCustom];
    butThird.frame =CGRectMake( 250, 660, 50, 50);
    [butThird setImage:[UIImage imageNamed:@"shezhi.png"] forState:UIControlStateNormal];
    [self.tableView addSubview:butThird];
    
    UILabel *butThirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(260, 720, 150, 30)];
    butThirdLabel.text = @"设置";
    butThirdLabel.font = [UIFont systemFontOfSize:15];
    [self.tableView addSubview:butThirdLabel];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return self.view.frame.size.height / 3;
    }
    if (indexPath.row == 3) {
        return self.view.frame.size.height - self.view.frame.size.height / 3 - 80;
    }
    return 80;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        UITableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
            if(cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"我的收藏";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"消息中心";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
            return cell;

    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        CollectViewController *collectViewController = [[CollectViewController alloc]init];
        [self.navigationController pushViewController:collectViewController animated:YES];
    }
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
