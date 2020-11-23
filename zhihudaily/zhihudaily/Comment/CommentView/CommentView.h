//
//  ContentView.h
//  zhihudaily
//
//  Created by young_jerry on 2020/11/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger NumberOfComments;
@property (nonatomic, assign) NSInteger NumberOfLongComments;
@property (nonatomic, assign) NSInteger NumberOfShortComments;

@property (nonatomic, strong) NSMutableArray *longComment;
@property (nonatomic, strong) NSMutableArray *longCommentImages;
@property (nonatomic, strong) NSMutableArray *longCommentAuthor;
@property (nonatomic, strong) NSMutableArray *longCommentTime;
@property (nonatomic, strong) NSMutableArray *longCommentReply;
@property (nonatomic, strong) NSMutableArray *longCommentAuthorReply;
@property (nonatomic, strong) NSMutableArray *longCommentLikes;

@property (nonatomic, strong) NSMutableArray *shortComment;
@property (nonatomic, strong) NSMutableArray *shortCommentImages;
@property (nonatomic, strong) NSMutableArray *shortCommentAuthor;
@property (nonatomic, strong) NSMutableArray *shortCommentTime;
@property (nonatomic, strong) NSMutableArray *shortCommentReply;
@property (nonatomic, strong) NSMutableArray *shortCommentAuthorReply;
@property (nonatomic, strong) NSMutableArray *shortCommentLikes;

@property (nonatomic, assign) bool didChange;
@property (nonatomic, assign) bool didSecondChange;

@end

NS_ASSUME_NONNULL_END
