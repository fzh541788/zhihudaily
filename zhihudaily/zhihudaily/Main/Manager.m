//
//  Manager.m
//  zhihudaily
//
//  Created by young_jerry on 2020/10/19.
//

#import "Manager.h"
static Manager *manager = nil;
@implementation Manager

+ (instancetype)sharedManager{
    if (!manager){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [Manager new];
        });
    }
    return manager;
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    NSURLCredential *card = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential,card);
}

-(void)NetWorkTestWithData:(SucceedBlock)succeedBlock error:(ErrorBlock)errorBlock{
    NSString *json = @"http://news-at.zhihu.com/api/4/news/latest";
    json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *testUrl = [NSURL URLWithString:json];
    
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
    NSURLSession *testSession=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionDataTask *testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error == nil) {
            NewsModel *country = [[NewsModel alloc] initWithData:data error:nil];
            succeedBlock(country);
        } else {
            errorBlock(error);
        }
//        self->_stories = country.stories[0];
        
        }];
    //任务启动
        [testDataTask resume];
}

-(void)NetWorkBeforeWithData:(NSString *)a and:(SucceedBlock)succeedBlock error:(ErrorBlock)errorBlock{
    NSString *json = [NSString stringWithFormat:@"http://news.at.zhihu.com/api/4/news/before/%@",a];
//    NSLog(@"%@",json);
    json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *testUrl = [NSURL URLWithString:json];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
    NSURLSession *testSession=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionDataTask *testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NewsModel *country = [[NewsModel alloc] initWithData:data error:nil];
            succeedBlock(country);
        } else {
            errorBlock(error);
        }
//        self->_stories = country.stories[0];
//        NSLog(@"%@",self->_stories.title);
        }];
    //任务启动
        [testDataTask resume];
}

-(void)NetWorkLongCommentsWithData:(NSString *)a and:(SucceedLongCommentsBlock)succeedBlock error:(ErrorBlock)errorBlock{
    NSString *json = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/story/%@/long-comments",a];
    json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *testUrl = [NSURL URLWithString:json];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
    NSURLSession *testSession=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionDataTask *testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            CommentModel *country = [[CommentModel alloc] initWithData:data error:nil];
            succeedBlock(country);
        } else {
            errorBlock(error);
        }
//        self->_stories = country.stories[0];
//        NSLog(@"%@",self->_stories.title);
        }];
    //任务启动
        [testDataTask resume];
}

-(void)NetWorkShortCommentsWithData:(NSString *)a and:(SucceedShortCommentsBlock)succeedBlock error:(ErrorBlock)errorBlock{
    NSString *json = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/story/%@/short-comments",a];
    json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *testUrl = [NSURL URLWithString:json];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
    NSURLSession *testSession=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionDataTask *testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            ShortCommentModel *country = [[ShortCommentModel alloc] initWithData:data error:nil];
            succeedBlock(country);
        } else {
            errorBlock(error);
        }
//        self->_stories = country.stories[0];
//        NSLog(@"%@",self->_stories.title);
        }];
    //任务启动
        [testDataTask resume];
}

- (void)NetWorkNumberOfCommentsWithData:(NSString *)a and:(SucceedNumberBlock)succeedBlock error:(ErrorBlock)errorBlock{
    NSString *json = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/story-extra/%@",a];
    json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *testUrl = [NSURL URLWithString:json];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
    NSURLSession *testSession=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionDataTask *testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            numberCommentModel *country = [[numberCommentModel alloc] initWithData:data error:nil];
            succeedBlock(country);
        } else {
            errorBlock(error);
        }
//        self->_stories = country.stories[0];
//        NSLog(@"%@",self->_stories.title);
        }];
    //任务启动
        [testDataTask resume];
}

- (void)NetWorkCollectWithData:(NSString *)a and:(SucceedCollectBlock)succeedBlock error:(ErrorBlock)errorBlock{
//    NSLog(@"%@",a);
    NSString *json = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/%@",a];
    json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *testUrl = [NSURL URLWithString:json];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
    NSURLSession *testSession=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionDataTask *testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            CollectModel *country = [[CollectModel alloc] initWithData:data error:nil];
            succeedBlock(country);
//            NSLog(@"%@",country.title);
        } else {
            errorBlock(error);
        }
//        self->_stories = country.stories[0];
//        NSLog(@"%@",self->_stories.title);
        }];
    //任务启动
        [testDataTask resume];
}

@end
