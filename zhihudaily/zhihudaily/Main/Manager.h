//
//  Manager.h
//  zhihudaily
//
//  Created by young_jerry on 2020/10/19.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"
#import "numberCommentModel.h"
#import "CommentModel.h"
#import "CollectModel.h"
#import "ShortCommentModel.h"
//块定义 定义一个block 类型的变量 SuccesBlock  为输入参数 其需要参数类型是id 返回值是第二个括号 的块
//这样就可以利用 SuccesBlock进行参数的传递或者是编辑。
typedef void (^SucceedBlock)(NewsModel * _Nonnull mainViewNowModel);
typedef void (^SucceedCollectBlock)(CollectModel * _Nonnull mainViewNowModel);
typedef void (^SucceedNumberBlock)(numberCommentModel * _Nonnull mainViewNowModel);
typedef void (^SucceedLongCommentsBlock)(CommentModel * _Nonnull mainViewNowModel);
typedef void (^SucceedShortCommentsBlock)(ShortCommentModel * _Nonnull mainViewNowModel);
//失败返回error
typedef void (^ErrorBlock)(NSError * _Nonnull error);

NS_ASSUME_NONNULL_BEGIN

@interface Manager : NSObject<NSURLSessionDelegate>

+ (instancetype)sharedManager;
- (void)NetWorkLongCommentsWithData:(NSString *)a and:(SucceedLongCommentsBlock)succeedBlock error:(ErrorBlock)errorBlock;
- (void)NetWorkShortCommentsWithData:(NSString *)a and:(SucceedShortCommentsBlock)succeedBlock error:(ErrorBlock)errorBlock;
- (void)NetWorkNumberOfCommentsWithData:(NSString *)a and:(SucceedNumberBlock)succeedBlock error:(ErrorBlock)errorBlock;
- (void)NetWorkTestWithData:(SucceedBlock) succeedBlock error:(ErrorBlock) errorBlock;
- (void)NetWorkBeforeWithData:(NSString *)a and:(SucceedBlock)succeedBlock error:(ErrorBlock)errorBlock;
- (void)NetWorkCollectWithData:(NSString *)a and:(SucceedCollectBlock)succeedBlock error:(ErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END
