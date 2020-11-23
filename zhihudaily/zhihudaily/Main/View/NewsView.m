//
//  NewsView.m
//  zhihudaily
//
//  Created by young_jerry on 2020/10/19.
//

#import "NewsView.h"
#import "NewsSonTableViewCell.h"
#import "NewsViewController.h"
#import "UIImageView+WebCache.h"

@implementation NewsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.sectionFooterHeight = 0;
    [self addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.automaticallyAdjustsScrollIndicatorInsets = NO;
    _tableView.tag = 111;
    [self.tableView registerClass:[NewsSonTableViewCell class] forCellReuseIdentifier:@"111"];
    _daisy = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        
    _firstScrollView = [[UIScrollView alloc] init];
    _firstScrollView.frame = CGRectMake(0,0,self.tableView.frame.size.width,self.tableView.frame.size.height/2.3);
    _firstScrollView.pagingEnabled = YES;
    _firstScrollView.delegate = self;
    _firstScrollView.tag = 112;
    [_firstScrollView setContentOffset:CGPointMake(self.tableView.frame.size.width, self.tableView.frame.size.height / 2.3)];
    _firstScrollView.showsHorizontalScrollIndicator = NO;
    _firstScrollView.contentSize = CGSizeMake(self.tableView.frame.size.width * 7, self.tableView.frame.size.height/2.3);
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width/2 + 30, self.tableView.frame.size.height / 2.3 - 50, 100, 50)];
    _pageControl.numberOfPages = 5;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    //立即开始启动定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
            return self.tableView.frame.size.height/2.3;
    } else if (indexPath.row == 0 && indexPath.section != 0) {
            return self.tableView.frame.size.height/28;
    }
    return self.tableView.frame.size.height/7;
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.tag == 111) {
//        CGFloat currentOffsetY = scrollView.contentOffset.y;
//    //    NSLog(@"%lf %lf %lf",currentOffsetY,scrollView.frame.size.height,scrollView.contentSize.height);
//        if ((currentOffsetY + scrollView.frame.size.height > scrollView.contentSize.height) && _flag == 0) {
//            _daisy.center = CGPointMake(200, self.tableView.frame.size.height - 50);//只能设置中心，不能设置大小
//            [self addSubview:_daisy];
//            _daisy.color = [UIColor grayColor];
//            [_daisy startAnimating]; // 开始旋转
//            [self addSection];
//            _flag = 1;
//            }
//    }
//}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag == 111) {
        CGFloat currentOffsetY = scrollView.contentOffset.y;
    //    NSLog(@"%lf %lf %lf",currentOffsetY,scrollView.frame.size.height,scrollView.contentSize.height);
        if (currentOffsetY + scrollView.frame.size.height + 5 > scrollView.contentSize.height) {
            _daisy.center = CGPointMake(200, self.tableView.frame.size.height - 50);//只能设置中心，不能设置大小
            [self addSubview:_daisy];
            _daisy.color = [UIColor grayColor];
            [_daisy startAnimating]; // 开始旋转
            [self addSection];
            }
    }
    if (scrollView.tag == 112) {
        _endContentOffsetX = scrollView.contentOffset.x;
           if (_endContentOffsetX < _willEndContentOffsetX && _willEndContentOffsetX < _startContentOffsetX) { //画面从右往左移动，前一页
//               NSLog(@"left");
               [self leftMoved];
           } else if (_endContentOffsetX > _willEndContentOffsetX && _willEndContentOffsetX > _startContentOffsetX) { //画面从左往右移动，后一页
//               NSLog(@"right");
               [self rightMoved];
           }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    }
}

- (void)addSection{
//    NSLog(@"%ld",(long)_sectionNumber);
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(action) userInfo:nil repeats:NO];
}

- (void)action{
    _testBlock();
    [_daisy stopAnimating];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
       NewsSonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
       if (!cell) {
           cell = [[NewsSonTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
       }
    if (_storiesTitle != NULL) {
        if (indexPath.row == 0 && indexPath.section == 0) {
            for (int i = 0; i < 7; i++) {
                if (i == 0) {
                    _topImageView = [[UIImageView alloc] init];
                    [_topImageView sd_setImageWithURL:[NSURL URLWithString:[_topStoriesImage objectAtIndex:4]]];
                    _topImageView.frame = CGRectMake(0,0,self.tableView.frame.size.width,self.tableView.frame.size.height/2.3);
                    
                    [_firstScrollView addSubview:_topImageView];
                } else if (i == 6){
                    _topImageView = [[UIImageView alloc] init];
                    [_topImageView sd_setImageWithURL:[NSURL URLWithString:[_topStoriesImage objectAtIndex:0]]];
                    _topImageView.frame = CGRectMake(6 * self.tableView.frame.size.width,0,self.tableView.frame.size.width,self.tableView.frame.size.height/2.3);
                    [_firstScrollView addSubview:_topImageView];
                } else {
                _topImageView = [[UIImageView alloc] init];
                [_topImageView sd_setImageWithURL:[NSURL URLWithString:[_topStoriesImage objectAtIndex:i - 1]]];
                _topImageView.frame = CGRectMake(i * self.tableView.frame.size.width,0,self.tableView.frame.size.width,self.tableView.frame.size.height/2.3);
                
                [_firstScrollView addSubview:_topImageView];
            }
            }
            [cell addSubview:_firstScrollView];
            [cell addSubview:_pageControl];
        }
        if ( indexPath.section == 0 && indexPath.row != 0) {
            cell.newsTitle.text = _storiesTitle[indexPath.row - 1];
            [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:[_storiesImages objectAtIndex:indexPath.row - 1][0]]];
//为什么是后面要加【0】因为请求到的的images是一个只有一个变量的数组就是这样：["https:...."] 加0取数组中的内容
            cell.newsHint.text = _storiesHint[indexPath.row - 1];
            }
        if (indexPath.section != 0 && indexPath.row != 0 && _storiesTitle.count > 6 * indexPath.section + indexPath.row - 1 ) {
            cell.newsTitle.text = _storiesTitle[6 * indexPath.section + indexPath.row - 1 ];
            [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:[_storiesImages objectAtIndex:6 * indexPath.section + indexPath.row - 1][0]]];
            cell.newsHint.text = _storiesHint[6 * indexPath.section + indexPath.row - 1];
        }
        }
    return cell;
}

- (void)changeImage{
    int page = _firstScrollView.contentOffset.x / (self.tableView.frame.size.width);
    CGFloat offSetX = self.firstScrollView.contentOffset.x;
    if (page == 6) {
            //回到第一页
            _firstScrollView.contentOffset = CGPointMake(self.tableView.frame.size.width, 0);
            //跳转到第二页
            [_firstScrollView setContentOffset:CGPointMake((self.tableView.frame.size.width)*2, 0) animated:YES];
    } else {
            offSetX += self.firstScrollView.bounds.size.width;
        [self.firstScrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
        }

    if (page == 5) {
        _pageControl.currentPage = 0;
    } else if(page == 6) {
        _pageControl.currentPage = 1;
    } else {
        _pageControl.currentPage = page;
    }
}

- (void)rightMoved{
//    NSLog(@"right");
    int page = _firstScrollView.contentOffset.x / (self.tableView.frame.size.width);
//    NSLog(@"%d",page);
    if (page == 5) {
        _pageControl.currentPage = 5;
    } else if (page == 6) {
        _pageControl.currentPage = 0;
    } else {
        _pageControl.currentPage = page - 1;
    }
    if (page == 6) {
            //回到第一页
            _firstScrollView.contentOffset = CGPointMake(self.tableView.frame.size.width, 0);
//            //跳转到第二页
    }
}

- (void)leftMoved{
//    NSLog(@"left");
    int page = _firstScrollView.contentOffset.x / (self.tableView.frame.size.width);
    if (page == 0) {
            //回到第一页
            _firstScrollView.contentOffset = CGPointMake(self.tableView.frame.size.width * 5, 0);
    }
    if (page == 0) {
        _pageControl.currentPage = 5;
    } else {
        _pageControl.currentPage = page - 1;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.tag == 112) {
        _startContentOffsetX = scrollView.contentOffset.x;
//        NSLog(@"%lf",_startContentOffsetX);
        [self stopTimer];
        if (_startContentOffsetX > self.tableView.frame.size.width * 5) {
            _firstScrollView.contentOffset = CGPointMake(self.tableView.frame.size.width, 0);
            _pageControl.currentPage = 1;
//            NSLog(@"111");
//            [self rightMoved];
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (scrollView.tag == 112) {
        _willEndContentOffsetX = scrollView.contentOffset.x;
//        NSLog(@"_willEndContentOffsetX:%lf",_willEndContentOffsetX);
    }
}

- (void)stopTimer {
    //结束计时
    [self.timer invalidate];
    self.timer = nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickDidSelect" object:nil userInfo:@{@"name":_id[6 * indexPath.section + indexPath.row - 1],@"pass":_id}];
}

@end
