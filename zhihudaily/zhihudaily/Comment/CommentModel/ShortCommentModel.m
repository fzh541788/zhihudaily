//
//  ShortCommentModel.m
//  zhihudaily
//
//  Created by young_jerry on 2020/11/6.
//

#import "ShortCommentModel.h"
@implementation ShortReplyModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}
@end

@implementation SecondCommentModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation ShortCommentModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
