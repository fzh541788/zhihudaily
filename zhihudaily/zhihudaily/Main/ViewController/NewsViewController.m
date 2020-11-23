//
//  NewsViewController.m
//  zhihudaily
//
//  Created by young_jerry on 2020/10/19.
//

#import "NewsViewController.h"
#import "NewsSonTableViewCell.h"
#import "NewsModel.h"
#import "NewsView.h"
#import "Manager.h"
#import "ContentViewController.h"
#import "UsersViewController.h"
@interface NewsViewController ()
@property (nonatomic, strong) NewsModel *newsModel;
@property (nonatomic, strong) NewsView *newsView;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _newsView = [[NewsView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_newsView];
    [self test];
    self.navigationItem.title = @"知乎日报";
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame =CGRectMake( 0, 0, 40, 40);
    [but setImage:[UIImage imageNamed:@"001.jpg"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(pressRight) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *containView = [[UIView alloc] initWithFrame:but.bounds];
    [containView addSubview:but];
    containView.layer.cornerRadius = 20;
    containView.clipsToBounds = YES;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:containView];
    
    self.newsView.testBlock = ^(void) {
//        NSLog(@"%ld",self->_testNumber);
        NSString *stringInt = [NSString stringWithFormat:@"%ld",(long)self->_testNumber];
        [self testBefore:stringInt];
    };
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickDidSelect:) name:@"clickDidSelect" object:nil];
}

- (void)test {
    [[Manager sharedManager] NetWorkTestWithData:^(NewsModel * _Nonnull mainViewNowModel) {
//            NSLog(@"请求成功");
//        NSLog(@"%@",mainViewNowModel.stories[0]);
        
        self->_newsView.storiesTitle = [[NSMutableArray alloc]init];
        self->_newsView.storiesImages = [[NSMutableArray alloc]init];
        self->_newsView.storiesHint = [[NSMutableArray alloc]init];
        self->_newsView.topStoriesImage = [[NSMutableArray alloc]init];
        self->_newsView.id = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < mainViewNowModel.stories.count; i++) {
            [self.newsView.storiesTitle addObject:[mainViewNowModel.stories[i]title]];
            [self.newsView.storiesImages addObject:[mainViewNowModel.stories[i]images]];
            [self.newsView.storiesHint addObject:[mainViewNowModel.stories[i]hint]];
            [self.newsView.id addObject:[mainViewNowModel.stories[i]id]];
        }
        for (int i = 0; i < mainViewNowModel.top_stories.count; i++) {
            [self.newsView.topStoriesImage addObject:[mainViewNowModel.top_stories[i]image]];
        }
//        for (int i = 0; i < mainViewNowModel.stories.count; i++) {
//            NSLog(@"%@",self.newsView.storiesTitle[i]);
//            NSLog(@"%@",self.newsView.storiesImages[i]);
//        }
        self.testDate = mainViewNowModel.date;
        self.testNumber = [self change:self.testDate];
        self.newsView.sectionNumber = 1;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.newsView.tableView reloadData];
        });
    } error:^(NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];
    
}
- (int)change:(NSString *)s {
    int secondFlag = 0;
    int sum = 0, num = 0;
        num = [s characterAtIndex:0] - '0';
        for (int i = 1; i < s.length; i++) {
                if (secondFlag == 0) {
                    num = num * 10 + (double)[s characterAtIndex:i] - '0';
                } else {
                    secondFlag++;
                    num = num + ((double)[s characterAtIndex:i] - '0') * pow(10, -secondFlag);
                }
        }
    sum += num;
    return sum;
}
- (void)testBefore:(NSString *)a {
    [[Manager sharedManager] NetWorkBeforeWithData:a and:^(NewsModel * _Nonnull mainViewNowModel) {
//            NSLog(@"请求成功");
//        NSLog(@"%@",mainViewNowModel.stories[1]);
//        self->_newsView.storiesTitle = [[NSMutableArray alloc]init];
//        self->_newsView.storiesImages = [[NSMutableArray alloc]init];
//        self->_newsView.storiesHint = [[NSMutableArray alloc]init];

        for (int i = 0; i < mainViewNowModel.stories.count; i++) {
            [self.newsView.storiesTitle addObject:[mainViewNowModel.stories[i]title]];
            [self.newsView.storiesImages addObject:[mainViewNowModel.stories[i]images]];
            [self.newsView.storiesHint addObject:[mainViewNowModel.stories[i]hint]];
            [self.newsView.id addObject:[mainViewNowModel.stories[i]id]];
        }
        self.testDate = mainViewNowModel.date;
        self.testNumber = [self change:self.testDate];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.newsView.sectionNumber++;
            [self.newsView.tableView reloadData];
        });
    } error:^(NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];
}

- (void)clickDidSelect: (NSNotification *)noti {
    NSDictionary *dic = noti.userInfo;
    ContentViewController *secondView = [[ContentViewController alloc]init];
    secondView.testID = dic[@"name"];
    secondView.idArray = dic[@"pass"];
    [self.navigationController pushViewController:secondView animated:YES];
}

- (void)pressRight {
    UsersViewController *thirdView = [[UsersViewController alloc]init];
    [self.navigationController pushViewController:thirdView animated:YES];
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
