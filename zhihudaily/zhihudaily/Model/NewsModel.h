//
//  NewsModel.h
//  zhihudaily
//
//  Created by young_jerry on 2020/10/19.
//
@protocol StoriesModel
@end

@protocol Top_StoriesModel
@end

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface StoriesModel : JSONModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSString *ga_prefix;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *image_hue;
@property (nonatomic, copy) NSString *id;
@end

@interface Top_StoriesModel : JSONModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *ga_prefix;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *image_hue;
@property (nonatomic, copy) NSString *id;
@end

@interface NewsModel : JSONModel
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSArray<StoriesModel> *stories;
@property (nonatomic, copy) NSArray<Top_StoriesModel> *top_stories;
//
- (void)sendNSNotification;

@end

NS_ASSUME_NONNULL_END
