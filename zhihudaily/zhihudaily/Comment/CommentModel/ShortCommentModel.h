//
//  ShortCommentModel.h
//  zhihudaily
//
//  Created by young_jerry on 2020/11/6.
//
@protocol SecondCommentModel
@end
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShortReplyModel : JSONModel
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) long status;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *error_msg;
@end

@interface SecondCommentModel : JSONModel
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) ShortReplyModel *reply_to;
@end

@interface ShortCommentModel : JSONModel
@property (nonatomic, copy) NSArray<SecondCommentModel> *comments;
@end

NS_ASSUME_NONNULL_END
