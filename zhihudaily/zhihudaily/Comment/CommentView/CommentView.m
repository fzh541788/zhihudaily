//
//  ContentView.m
//  zhihudaily
//
//  Created by young_jerry on 2020/11/2.
//

#import "CommentView.h"
#import "CommentSonTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CommentView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self addSubview:_tableView];
    _didSecondChange = NO;
    _didChange = NO;
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 300;
    
    // 去除多余黑线问题
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.tableView.bounds),0)];
    _tableView.tableFooterView = v;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tag = 111;
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_NumberOfShortComments > 20) {
        return 20 + _NumberOfLongComments;
    }
    return _NumberOfComments;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 40;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
       CommentSonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
       if (!cell) {
           cell = [[CommentSonTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
           cell.foldButton.hidden = YES;
           cell.longFoldButton.hidden = YES;
           [cell.foldButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
           [cell.longFoldButton addTarget:self action:@selector(pressLongButton:) forControlEvents:UIControlEventTouchUpInside];
           cell.longCommentNumberOfLikes.text = @"";
           cell.shortCommentNumberOfLikes.text = @"";
       }

       else if (indexPath.row < _NumberOfLongComments ) {
            cell.longCommentLabel.text = _longComment[indexPath.row];
            [cell.longCommentImageView sd_setImageWithURL:[NSURL URLWithString:[_longCommentImages objectAtIndex:indexPath.row ]]];
            cell.longCommentAuthorLabel.text = _longCommentAuthor[indexPath.row];
           
           NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
           [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
           NSString * timeStampString = _longCommentTime[indexPath.row];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStampString doubleValue]];
           NSString *timeStr = [stampFormatter stringFromDate:date];
        
            cell.longCommentTime.text = timeStr;
            cell.longCommentTime.textColor = [UIColor grayColor];
            cell.longCommentNumberOfLikes.textColor = [UIColor grayColor];
           if (![_longCommentLikes[indexPath.row] isEqual:@"0"]) {
               cell.longCommentNumberOfLikes.text = _longCommentLikes[indexPath.row];
//               NSLog(@"%@",cell.shortCommentNumberOfLikes.text);
           }
           if ([_longCommentAuthorReply[indexPath.row] isEqual:@"a"]) {
               cell.longCommentReplyLabel.text = @"";
           } else {
               if ([_longCommentReply[indexPath.row] isEqual:@"抱歉，原点评已经被删除"]) {
                   NSString *str = [NSString stringWithFormat:@"%@%@", _shortCommentAuthorReply[indexPath.row - _NumberOfLongComments],_shortCommentReply[indexPath.row - _NumberOfLongComments]];
                   NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
                   NSRange range1 = NSMakeRange(0, [str length]);
                   [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.00f] range:range1];
                   [cell.shortCommentReplyLabel setAttributedText:noteStr];
               } else {
               NSString *str = [NSString stringWithFormat:@"//%@：%@", _longCommentAuthorReply[indexPath.row],_longCommentReply[indexPath.row]];
               NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
               NSRange range1 = NSMakeRange(0, [str length]);
               [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.00f] range:range1];
               [cell.longCommentReplyLabel setAttributedText:noteStr];
           }
        }
           NSInteger count = [self textHeightFromTextString:cell.longCommentLabel.text width:388 fontSize:15].height / cell.longCommentLabel.font.lineHeight;
           if (count <= 2) {
                   cell.longFoldButton.hidden = YES;
           } else {
                   cell.longFoldButton.hidden = NO;
           }
        }
       else if (indexPath.row >= _NumberOfLongComments) {
            cell.shortCommentLabel.text = _shortComment[indexPath.row - _NumberOfLongComments];
            [cell.shortCommentImageView sd_setImageWithURL:[NSURL URLWithString:[_shortCommentImages objectAtIndex:indexPath.row - _NumberOfLongComments]]];
            cell.shortCommentAuthorLabel.text = _shortCommentAuthor[indexPath.row - _NumberOfLongComments];
           //时间戳转化成时间
           
           NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
           [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
           NSString * timeStampString = _shortCommentTime[indexPath.row - _NumberOfLongComments];
               NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStampString doubleValue]];
           NSString *timeStr = [stampFormatter stringFromDate:date];
           
            cell.shortCommentTime.text = timeStr;
            cell.shortCommentTime.textColor = [UIColor grayColor];
           cell.shortCommentNumberOfLikes.textColor = [UIColor grayColor];
           if (![_shortCommentLikes[indexPath.row - _NumberOfLongComments] isEqual:@"0"]) {
               cell.shortCommentNumberOfLikes.text = _shortCommentLikes[indexPath.row - _NumberOfLongComments];
//               NSLog(@"%@",cell.shortCommentNumberOfLikes.text);
           }
            if ([_shortCommentAuthorReply[indexPath.row - _NumberOfLongComments] isEqual:@"a"]) {
                cell.shortCommentReplyLabel.text = @"";
            } else {
                if ([_shortCommentReply[indexPath.row - _NumberOfLongComments] isEqual:@"抱歉，原点评已经被删除"]) {
                    NSString *str = [NSString stringWithFormat:@"%@%@", _shortCommentAuthorReply[indexPath.row - _NumberOfLongComments],_shortCommentReply[indexPath.row - _NumberOfLongComments]];
                    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
                    NSRange range1 = NSMakeRange(0, [str length]);
                    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.00f] range:range1];
                    [cell.shortCommentReplyLabel setAttributedText:noteStr];
                } else {
                NSString *str = [NSString stringWithFormat:@"//%@：%@", _shortCommentAuthorReply[indexPath.row - _NumberOfLongComments],_shortCommentReply[indexPath.row - _NumberOfLongComments]];
                    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
                    NSRange range1 = NSMakeRange(0, [str length]);
                    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.00f] range:range1];
                    [cell.shortCommentReplyLabel setAttributedText:noteStr];
                    NSInteger count = [self textHeightFromTextString:str width:388 fontSize:15].height / cell.shortCommentReplyLabel.font.lineHeight;
                    if (count <= 2) {
                            cell.foldButton.hidden = YES;
                    } else {
                            cell.foldButton.hidden = NO;
                    }
                }

            }
        }
    
    return cell;
}

-(CGSize)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size {
    //计算 label需要的宽度和高度
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    CGSize size1 = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]}];
    return CGSizeMake(size1.width, rect.size.height);
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)pressButton:(UIButton *)button {
    CommentSonTableViewCell *cell = (CommentSonTableViewCell *)[[button superview] superview];
    //button加到tableView上 要获取此时的cell 那么button.superView 就是contentView 再superView 就是cell
    if (cell.shortCommentReplyLabel.numberOfLines == 2) {
        cell.shortCommentReplyLabel.numberOfLines = 0;
    } else {
        cell.shortCommentReplyLabel.numberOfLines = 2;
    }
    if (_didChange) {
        [button setTitle:@"展示更多" forState:UIControlStateNormal];
    } else {
        [button setTitle:@"收起" forState:UIControlStateNormal];
    }
    _didChange = !_didChange;
    [_tableView reloadData];
}

- (void)pressLongButton:(UIButton *)button {
    CommentSonTableViewCell *cell = (CommentSonTableViewCell *)[[button superview] superview];
    //button加到tableView上 要获取此时的cell 那么button.superView 就是contentView 再superView 就是cell
    if (cell.longCommentLabel.numberOfLines == 2) {
        cell.longCommentLabel.numberOfLines = 0;
    } else {
        cell.longCommentLabel.numberOfLines = 2;
    }
    if (_didSecondChange) {
        [button setTitle:@"展示更多" forState:UIControlStateNormal];
    } else {
        [button setTitle:@"收起" forState:UIControlStateNormal];
    }
    _didSecondChange = !_didSecondChange;
    [_tableView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
