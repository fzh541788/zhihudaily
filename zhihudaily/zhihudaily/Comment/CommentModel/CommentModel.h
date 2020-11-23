//
//  ContentModel.h
//  zhihudaily
//
//  Created by young_jerry on 2020/11/2.
//
@protocol LongCommentModel
@end
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LongReplyModel : JSONModel
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) long status;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *error_msg;
@end

@interface LongCommentModel : JSONModel
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) LongReplyModel *reply_to;
@end

@interface CommentModel : JSONModel
@property (nonatomic, copy) NSArray<LongCommentModel> *comments;
@end

NS_ASSUME_NONNULL_END
