//
//  NewsModel.m
//  zhihudaily
//
//  Created by young_jerry on 2020/10/19.
//

#import "NewsModel.h"

@implementation Top_StoriesModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation StoriesModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation NewsModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
