//
//  ViewController.m
//  zhihudaily
//
//  Created by young_jerry on 2020/10/19.
//

#import "ViewController.h"
#import "NewsViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/*
 
 UINavigationBar *navigationBar = [[self navigationController] navigationBar];
 CGRect frame = [navigationBar frame];
 frame.size.height = 82.0f;
 [navigationBar setFrame:frame];
 */

- (void)viewDidAppear:(BOOL)animated{
    
    
    NewsViewController *newsViewController = [[NewsViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:newsViewController];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    

    [self presentViewController:nav animated:YES completion:nil];
}

@end
