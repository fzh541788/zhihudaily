////
////  CollectManager.m
////  zhihudaily
////
////  Created by young_jerry on 2020/11/20.
////
//
//#import "CollectManager.h"
//
//@implementation CollectManager
//
//+ (instancetype)sharedManager {
//    if (!manager){
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            manager = [CollectManager new];
//        });
//    }
//    return manager;
//}
//
//- (void)creat {
//    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *fileName=[doc stringByAppendingPathComponent:@"agree.sqlite"];
//    self.dbPath = fileName;
//    NSLog(@"%@",fileName);
//    FMDatabase *db=[FMDatabase databaseWithPath:self.dbPath];
//    //3.打开数据库
//    if ([db open]) {
//           //4.创表
//           BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_agreeOrder (id TEXT);"];
//           if (result) {
//                        NSLog(@"创表成功");
//                    } else {
//                        NSLog(@"创表失败");
//                    }
//     }
//           self.db=db;
//}
//@end
