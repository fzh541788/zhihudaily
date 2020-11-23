//
//  ContentViewController.h
//  zhihudaily
//
//  Created by young_jerry on 2020/10/28.
//

#import <UIKit/UIKit.h>
#import "FMDB.h"
NS_ASSUME_NONNULL_BEGIN

@interface ContentViewController : UIViewController
@property (nonatomic, strong) NSString *testID;
@property (nonatomic, assign) int flag;

@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *collectButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *buttonView;

@property (nonatomic, strong) UIScrollView *scrollerView;

@property (nonatomic, copy) NSString *urlTest;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong) FMDatabase *dataBase;

@property (nonatomic, assign) bool didChange;


@property (nonatomic, strong) NSMutableArray *idArray;

@end


NS_ASSUME_NONNULL_END
