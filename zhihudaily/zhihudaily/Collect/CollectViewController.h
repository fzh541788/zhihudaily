//
//  CollectViewController.h
//  zhihudaily
//
//  Created by young_jerry on 2020/11/19.
//

#import <UIKit/UIKit.h>
#import "FMDB.h"
NS_ASSUME_NONNULL_BEGIN

@interface CollectViewController : UIViewController
@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *TestId;
@property (nonatomic, strong) NSMutableArray *storiesTitle;
@property (nonatomic, strong) NSMutableArray *storiesImages;
@property (nonatomic, strong) NSMutableArray *storiesHint;

@property (nonatomic, assign) NSInteger i;
@end

NS_ASSUME_NONNULL_END
