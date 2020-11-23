//
//  numberCommentModel.h
//  zhihudaily
//
//  Created by young_jerry on 2020/11/4.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface numberCommentModel : JSONModel

@property (nonatomic, copy) NSString *long_comments;
@property (nonatomic, copy) NSString *popularity;
@property (nonatomic, copy) NSString *short_comments;
@property (nonatomic, copy) NSString *comments;

@end

NS_ASSUME_NONNULL_END
