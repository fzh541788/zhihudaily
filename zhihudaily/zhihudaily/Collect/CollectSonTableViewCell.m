//
//  CollectSonTableViewCell.m
//  zhihudaily
//
//  Created by young_jerry on 2020/11/21.
//

#import "CollectSonTableViewCell.h"
#import "Masonry.h"
@implementation CollectSonTableViewCell

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
    
    _newsTitle = [[UILabel alloc]init];
    _newsTitle.lineBreakMode = NSLineBreakByCharWrapping;
    //设置行数
    _newsTitle.numberOfLines = 0;
    [self.contentView addSubview:_newsTitle];
    
    _newsImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_newsImageView];
    
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_newsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(250, 80));
    }];
    
    [_newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(21);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
}
@end
