//
//  NewsView.h
//  zhihudaily
//
//  Created by young_jerry on 2020/10/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *storiesTitle;
@property (nonatomic, strong) NSMutableArray *storiesImages;
@property (nonatomic, strong) NSMutableArray *storiesHint;
@property (nonatomic, strong) NSMutableArray *topStoriesImage;
@property (nonatomic, strong) NSMutableArray *id;
@property (nonatomic, assign) CGFloat startContentOffsetX;
@property (nonatomic, assign) CGFloat willEndContentOffsetX;
@property (nonatomic, assign) CGFloat endContentOffsetX;
@property (nonatomic, strong) UIImageView *topImageView;

@property (nonatomic, strong) UIScrollView *firstScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger sectionNumber;
@property (nonatomic, assign) NSInteger flag;

@property (nonatomic, copy) void (^testBlock) (void);


@property(nonatomic,strong)NSTimer * timer;//计时器

@property (nonatomic, strong) UIActivityIndicatorView *daisy;
@end

NS_ASSUME_NONNULL_END
