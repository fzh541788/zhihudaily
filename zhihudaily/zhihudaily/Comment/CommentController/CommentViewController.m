//
//  CommentViewController.m
//  zhihudaily
//
//  Created by young_jerry on 2020/11/2.
//

#import "CommentViewController.h"
#import "Manager.h"
#import "CommentModel.h"
#import "CommentView.h"
#import "CommentSonTableViewCell.h"

@interface CommentViewController ()
@property (nonatomic, strong) CommentModel *commentModel;
@property (nonatomic, strong) CommentView *commentView;
@property (nonatomic, strong) CommentSonTableViewCell *commentSonTableViewCell;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _commentView = [[CommentView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_commentView];
    
    [self numberOfComments:_testIDNumber];
    [self longComments:_testIDNumber];
    [self shortComments:_testIDNumber];
    [self.commentView.tableView reloadData];
}

- (void)numberOfComments:(NSString *)a {
    [[Manager sharedManager]NetWorkNumberOfCommentsWithData:a and:^(numberCommentModel * _Nonnull mainViewNowModel) {
        self.commentView.NumberOfComments = [self change:mainViewNowModel.comments];
        self.commentView.NumberOfLongComments = [self change:mainViewNowModel.long_comments];
        self.commentView.NumberOfShortComments = [self change:mainViewNowModel.short_comments];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commentView.tableView reloadData];
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

- (void)shortComments:(NSString *)a {
    [[Manager sharedManager]NetWorkShortCommentsWithData:a and:^(ShortCommentModel * _Nonnull mainViewNowModel) {
//        NSLog(@"%@",[mainViewNowModel.comments[2]reply_to]);
        self->_commentView.shortComment = [[NSMutableArray alloc]init];
        self->_commentView.shortCommentImages = [[NSMutableArray alloc]init];
        self->_commentView.shortCommentAuthor = [[NSMutableArray alloc]init];
        self->_commentView.shortCommentTime = [[NSMutableArray alloc]init];
        self->_commentView.shortCommentAuthorReply = [[NSMutableArray alloc]init];
        self->_commentView.shortCommentReply = [[NSMutableArray alloc]init];
        self->_commentView.shortCommentLikes = [[NSMutableArray alloc]init];
        for (int i = 0; i < mainViewNowModel.comments.count; i++) {
            [self.commentView.shortComment addObject:[mainViewNowModel.comments[i]content]];
            [self.commentView.shortCommentImages addObject:[mainViewNowModel.comments[i]avatar]];
            [self.commentView.shortCommentAuthor addObject:[mainViewNowModel.comments[i]author]];
            [self.commentView.shortCommentTime addObject:[mainViewNowModel.comments[i]time]];
            [self.commentView.shortCommentLikes addObject:[mainViewNowModel.comments[i]likes]];
            if ([mainViewNowModel.comments[i]reply_to] != nil) {
                if ([[[mainViewNowModel.comments[i]reply_to]error_msg] isEqual:@"抱歉，原点评已经被删除"]) {
                    [self.commentView.shortCommentReply addObject:@"抱歉，原点评已经被删除"];
                    [self.commentView.shortCommentAuthorReply addObject:@""];
                } else {
                [self.commentView.shortCommentReply addObject:[mainViewNowModel.comments[i]reply_to].content];
                [self.commentView.shortCommentAuthorReply addObject:[mainViewNowModel.comments[i]reply_to].author];
             }
//                NSLog(@"%d",i);
            } else {
                [self.commentView.shortCommentReply addObject:@"a"];
                [self.commentView.shortCommentAuthorReply addObject:@"a"];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commentView.tableView reloadData];
        });
        } error:^(NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];
}

- (void)longComments:(NSString *)a {
    [[Manager sharedManager]NetWorkLongCommentsWithData:a and:^(CommentModel * _Nonnull mainViewNowModel) {
//            NSLog(@"%@",[mainViewNowModel.comments[0]content]);
        self->_commentView.longComment = [[NSMutableArray alloc]init];
        self->_commentView.longCommentImages = [[NSMutableArray alloc]init];
        self->_commentView.longCommentAuthor = [[NSMutableArray alloc]init];
        self->_commentView.longCommentTime = [[NSMutableArray alloc]init];
        self->_commentView.longCommentAuthorReply = [[NSMutableArray alloc]init];
        self->_commentView.longCommentReply = [[NSMutableArray alloc]init];
        self->_commentView.longCommentLikes = [[NSMutableArray alloc]init];
        for (int i = 0; i < mainViewNowModel.comments.count; i++) {
            [self.commentView.longComment addObject:[mainViewNowModel.comments[i]content]];
            [self.commentView.longCommentImages addObject:[mainViewNowModel.comments[i]avatar]];
            [self.commentView.longCommentAuthor addObject:[mainViewNowModel.comments[i]author]];
            [self.commentView.longCommentTime addObject:[mainViewNowModel.comments[i]time]];
            [self.commentView.longCommentLikes addObject:[mainViewNowModel.comments[i]likes]];

            if ([mainViewNowModel.comments[i]reply_to] != nil) {
                if ([[[mainViewNowModel.comments[i]reply_to]error_msg] isEqual:@"抱歉，原点评已经被删除"]) {
                    [self.commentView.longCommentReply addObject:@"抱歉，原点评已经被删除"];
                    [self.commentView.longCommentAuthorReply addObject:@""];
                } else {
                [self.commentView.longCommentReply addObject:[mainViewNowModel.comments[i]reply_to].content];
                [self.commentView.longCommentAuthorReply addObject:[mainViewNowModel.comments[i]reply_to].author];
             }
            } else {
                [self.commentView.longCommentReply addObject:@"a"];
                [self.commentView.longCommentAuthorReply addObject:@"a"];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commentView.tableView reloadData];
        });
        } error:^(NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];
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
