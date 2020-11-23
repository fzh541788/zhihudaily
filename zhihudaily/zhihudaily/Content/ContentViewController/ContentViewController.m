//
//  ContentViewController.m
//  zhihudaily
//
//  Created by young_jerry on 2020/10/28.
//

#import "ContentViewController.h"
#import "ContentVIew.h"
#import "ContentModel.h"
#import "Manager.h"
#import "Masonry.h"
#import "CommentViewController.h"
#import <WebKit/WebKit.h>

@interface ContentViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) ContentVIew *contentView;
@property (nonatomic, strong) ContentModel *contentModel;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@",_idArray);
//
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 91, self.view.frame.size.width, self.view.frame.size.height - 100)];
    _scrollerView.contentSize = CGSizeMake(self.view.frame.size.width, (self.view.frame.size.height - 100) * _idArray.count);
    _scrollerView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < _idArray.count; i++) {
        if ([_idArray[i] isEqual:_testID]) {
            [_scrollerView setContentOffset:CGPointMake(self.scrollerView.frame.size.width, (self.scrollerView.frame.size.height) * i)];
            _flag = i;
        }
    }
    _scrollerView.pagingEnabled = YES;
    _scrollerView.delegate = self;
    [self.view addSubview:_scrollerView];
    
    for (int i = 0; i < _idArray.count; i++) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 100) * i, self.view.frame.size.width, self.view.frame.size.height - 200)];
    //    self.view = webView;
        [_scrollerView addSubview:webView];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://daily.zhihu.com/story/%@",_idArray[i]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
        }
    _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 100)];
    _buttonView.backgroundColor = [UIColor whiteColor];
//        _buttonView.tag = i;
//        _label = [[UILabel alloc]init];
//        _label.text = [NSString stringWithFormat:@"%d",i];
//        _label.frame = CGRectMake(0, 0, 30, 30);
    _commentButton = [[UIButton alloc]init];
    [_commentButton setImage:[UIImage imageNamed:@"msg-o.png"] forState:UIControlStateNormal];
    [_buttonView addSubview:_commentButton];
    [_commentButton addTarget:self action:@selector(pressCommentButton) forControlEvents:UIControlEventTouchUpInside];
//        [_commentButton addSubview:_label];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-40);
        make.left.mas_offset(self.view.frame.size.width * 0.2);
            make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width * 0.139,self.view.frame.size.width * 0.139));
    }];
    
    
    _collectButton = [[UIButton alloc]init];
    [_collectButton setImage:[UIImage imageNamed:@"shoucang.png"] forState:UIControlStateNormal];
    [_buttonView addSubview:_collectButton];
    [_collectButton addTarget:self action:@selector(pressCollectButton) forControlEvents:UIControlEventTouchUpInside];
    [_collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-40);
        make.left.mas_offset(self.view.frame.size.width * 0.6);
            make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width * 0.139,self.view.frame.size.width * 0.139));
    }];
    
    _likeButton = [[UIButton alloc]init];
    [_likeButton setImage:[UIImage imageNamed:@"dianzan.png"] forState:UIControlStateNormal];
    [_buttonView addSubview:_likeButton];
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-40);
        make.left.mas_offset(self.view.frame.size.width * 0.4);
            make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width * 0.139,self.view.frame.size.width * 0.139));
    }];
    
    _shareButton = [[UIButton alloc]init];
    [_shareButton setImage:[UIImage imageNamed:@"fenxiang.png"] forState:UIControlStateNormal];
    [_buttonView addSubview:_shareButton];
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-40);
        make.left.mas_offset(self.view.frame.size.width * 0.8);
            make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width * 0.139,self.view.frame.size.width * 0.139));
        
    }];
    [self.view addSubview:_buttonView];
    
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"agree.sqlite"];
    self.path = fileName;
//    NSLog(@"%@",fileName);
    FMDatabase *dataBase = [FMDatabase databaseWithPath:self.path];
    //3.打开数据库
    if ([dataBase open]) {
           //4.创表
           BOOL result=[dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_agreeOrder (id TEXT);"];
           if (result) {
//                        NSLog(@"创表成功");
                    } else {
                        NSLog(@"创表失败");
                    }
     }
    self.dataBase = dataBase;
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int a = scrollView.contentOffset.y / scrollView.frame.size.height;
    _flag = a;
}

- (void)pressCommentButton {
    CommentViewController *commentViewController = [[CommentViewController alloc]init];
    commentViewController.testIDNumber = _idArray[_flag];
    [self.navigationController pushViewController:commentViewController animated:YES];
}

- (void)pressCollectButton {
    FMDatabase *dataBase = [FMDatabase databaseWithPath:self.path];
        if ([dataBase open]) {
        BOOL res = [self.dataBase executeUpdate:@"INSERT INTO t_agreeOrder (id) VALUES (?);",_idArray[_flag]];
        if (!res) {
            NSLog(@"增加数据失败");
        } else {
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"收藏成功！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:sureAction];
                [self presentViewController:alert animated:NO completion:nil];
        }
          [dataBase close];
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
