//
//  ZWWMediaViewController.m
//  MediaTest
//
//  Created by mac on 2018/5/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWMediaViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface ZWWMediaViewController ()

//注意1：一定要声明为全局变量
//MPMoviePlayerController:继承自NSObject，无法直接Present，需要框架MediaPlayer.Framework
@property (nonatomic, strong) MPMoviePlayerController *player;

@end

@implementation ZWWMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (MPMoviePlayerController *)player{
    if (!_player) {
        NSURL *url = [NSURL URLWithString:KLocalMP4Url];
        _player = [[MPMoviePlayerController alloc]initWithContentURL:url];
        _player.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight*0.5);
        [self.view addSubview:_player.view];
    }
    return _player;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _player = nil;
}

- (IBAction)startPlayMovie:(id)sender {

    //注意2：要记得开启播放
    [self.player play];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
