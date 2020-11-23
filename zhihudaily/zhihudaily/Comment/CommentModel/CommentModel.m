//
//  ContentModel.m
//  zhihudaily
//
//  Created by young_jerry on 2020/11/2.
//

#import "CommentModel.h"

@implementation LongReplyModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}

@end

@implementation LongCommentModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation CommentModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
