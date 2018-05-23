//
//  ZWWMPMoviePlayerViewController.m
//  MediaTest
//
//  Created by mac on 2018/5/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWMPMoviePlayerViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface ZWWMPMoviePlayerViewController ()

@end

@implementation ZWWMPMoviePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//ios9过期
- (IBAction)startPlayMovieDeprecatedAction:(id)sender {
    
    NSURL *url = [NSURL URLWithString:KLocalMP4Url];
    MPMoviePlayerViewController *playerVC = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
    [self presentViewController:playerVC animated:YES completion:nil];
}

//ios9 不过期
- (IBAction)startPlayMovie:(id)sender {
    //AVPlayerViewController 需要框架AVKit,AVPlayerViewController不会再ios9之后过期，可以直接present出全界面
    AVPlayerViewController *avPlayerVC = [[AVPlayerViewController alloc]init];
    NSURL *url = [NSURL URLWithString:KLocalMP4Url];
    
    //AVPlayer 需要框架AVFoundation
    AVPlayer *player = [AVPlayer playerWithURL:url];
    avPlayerVC.player = player;
    [self presentViewController:avPlayerVC animated:YES completion:^{
        //打开页面即播放
        [player play];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
