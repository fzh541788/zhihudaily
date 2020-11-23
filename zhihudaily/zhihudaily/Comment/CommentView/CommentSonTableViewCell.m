//
//  CommentSonTableViewCell.m
//  zhihudaily
//
//  Created by young_jerry on 2020/11/3.
//

#import "CommentSonTableViewCell.h"
#import "Masonry.h"

@implementation CommentSonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _longCommentLabel = [[UILabel alloc]init];
    //自动换行
    _longCommentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _longCommentLabel.font = [UIFont systemFontOfSize:15];
    //设置行数
    _longCommentLabel.numberOfLines = 2;
    [self.contentView addSubview:_longCommentLabel];
    
    _longCommentImageView = [[UIImageView alloc]init];
    _longCommentImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_longCommentImageView];
    
    _longCommentAuthorLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_longCommentAuthorLabel];

    _longCommentTime = [[UILabel alloc]init];
    _longCommentTime.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_longCommentTime];
    
    _longCommentReplyLabel = [[UILabel alloc]init];
    _longCommentReplyLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _longCommentReplyLabel.font = [UIFont systemFontOfSize:15];
    _longCommentReplyLabel.numberOfLines = 0;
    [self.contentView addSubview:_longCommentReplyLabel];
    
    _shortCommentLabel = [[UILabel alloc]init];
    //自动换行
    _shortCommentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _shortCommentLabel.font = [UIFont systemFontOfSize:15];
    //设置行数
    _shortCommentLabel.numberOfLines = 0;
    [self.contentView addSubview:_shortCommentLabel];
    
    _shortCommentImageView = [[UIImageView alloc]init];
    _shortCommentImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_shortCommentImageView];
    
    _shortCommentAuthorLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_shortCommentAuthorLabel];

    _shortCommentTime = [[UILabel alloc]init];
    _shortCommentTime.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_shortCommentTime];
    
    _shortCommentReplyLabel = [[UILabel alloc]init];
    _shortCommentReplyLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _shortCommentReplyLabel.font = [UIFont systemFontOfSize:15];
    _shortCommentReplyLabel.numberOfLines = 2;
    [self.contentView addSubview:_shortCommentReplyLabel];
    
    _shortCommentNumberOfLikes = [[UILabel alloc]init];
    _shortCommentNumberOfLikes.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_shortCommentNumberOfLikes];
    
    _longCommentNumberOfLikes = [[UILabel alloc]init];
    _longCommentNumberOfLikes.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_longCommentNumberOfLikes];
    
    self.foldButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_foldButton setTitle:@"展开全文" forState:UIControlStateNormal];
    [_foldButton setTintColor:[UIColor grayColor]];
    [self.contentView addSubview:_foldButton];
    [_foldButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.shortCommentTime.mas_top);
                make.right.equalTo(self.contentView.mas_right).offset(-180);
                make.height.equalTo(@20);
                make.width.equalTo(@80);
    }];
    
    self.longFoldButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_longFoldButton setTitle:@"展开全文" forState:UIControlStateNormal];
    [_longFoldButton setTintColor:[UIColor grayColor]];
    [self.contentView addSubview:_longFoldButton];
    [_longFoldButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.longCommentTime.mas_top);
                make.right.equalTo(self.contentView.mas_right).offset(-180);
                make.height.equalTo(@20);
                make.width.equalTo(@80);
    }];
    
    self.likeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_likeButton setImage:[UIImage imageNamed:@"dianzan-2.png"] forState:UIControlStateNormal];
    [_likeButton setTintColor:[UIColor grayColor]];
    [self.contentView addSubview:_likeButton];
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.longCommentTime.mas_top).offset(-10);
                make.right.equalTo(self.contentView.mas_right).offset(-80);
                make.height.equalTo(@40);
                make.width.equalTo(@40);
    }];
  
    
    self.messageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_messageButton setImage:[UIImage imageNamed:@"changyongicon-.png"] forState:UIControlStateNormal];
    [_messageButton setTintColor:[UIColor grayColor]];
    [self.contentView addSubview:_messageButton];
    [_messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.longCommentTime.mas_top).offset(-10);
                make.right.equalTo(self.contentView.mas_right).offset(-30);
                make.height.equalTo(@40);
                make.width.equalTo(@40);
    }];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_longCommentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(27.0).priority(500);
        make.size.mas_equalTo(CGSizeMake(32.0, 32.0));
        make.left.equalTo(self.contentView.mas_left).offset(20.0);
    }];
    _longCommentImageView.layer.cornerRadius = self.longCommentImageView.frame.size.width / 2;
    
    [_longCommentAuthorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(27.0);
        make.left.equalTo(self.longCommentImageView.mas_left).offset(40);
        make.right.equalTo(self.contentView.mas_right).offset(-20.0);
    }];
    
    [_longCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.longCommentImageView.mas_bottom).offset(15.0);
        make.left.equalTo(self.longCommentImageView.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-20.0);
    }];
    
    [_longCommentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15.0);
        make.left.equalTo(self.longCommentImageView.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-20.0);
    }];
    
    [_longCommentReplyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.longCommentLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.longCommentTime.mas_top).offset(-10);
        make.left.equalTo(self.longCommentImageView.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-20.0);
    }];
    
    [_shortCommentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(27.0).priority(500);
        make.size.mas_equalTo(CGSizeMake(32.0, 32.0));
        make.left.equalTo(self.contentView.mas_left).offset(20.0);
    }];
    _shortCommentImageView.layer.cornerRadius = self.longCommentImageView.frame.size.width / 2;
    
    [_shortCommentAuthorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(27.0);
        make.left.equalTo(self.shortCommentImageView.mas_left).offset(40);
    }];
    
    [_shortCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shortCommentImageView.mas_bottom).offset(15.0);
        make.left.equalTo(self.shortCommentImageView.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-20.0);
    }];

    
    [_shortCommentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15.0);
        make.height.mas_equalTo(20);
        make.left.equalTo(self.shortCommentImageView.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-20.0);
    }];
    
    
    [_shortCommentReplyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shortCommentLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.shortCommentTime.mas_top).offset(-10);
        make.left.equalTo(self.shortCommentImageView.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-20.0);
    }];
    
    [_longCommentNumberOfLikes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.longCommentTime.mas_top).offset(-10);
        make.right.equalTo(self.contentView.mas_right).offset(-40);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];

    [_shortCommentNumberOfLikes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.longCommentTime.mas_top).offset(-10);
        make.right.equalTo(self.contentView.mas_right).offset(-40);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
}
@end
