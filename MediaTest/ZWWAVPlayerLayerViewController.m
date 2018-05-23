//
//  ZWWAVPlayerLayerViewController.m
//  MediaTest
//
//  Created by mac on 2018/5/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWAVPlayerLayerViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ZWWAVPlayerLayerViewController ()

@property (nonatomic, strong) AVPlayer *player;


@end

@implementation ZWWAVPlayerLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //用VPlayerLayer可以实现用AVPlayer 在局部播放画面，而不用AVPlayerViewController默认的全屏播放视频画面
    
}

- (AVPlayer *)player {
    if (!_player) {
        NSURL *url = [NSURL URLWithString:KLocalMP4Url];
        AVPlayerItem *playItem = [AVPlayerItem playerItemWithURL:url];
        _player = [AVPlayer playerWithPlayerItem:playItem];
        
        //以上只能实现播放音质，无法播放视频画面
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
        layer.frame = CGRectMake(0, 0, KScreenWidth, 400);
        [self.view.layer addSublayer:layer];
    }
    return _player;
}

- (IBAction)startPlayMovie:(id)sender {
    
    
    [self.player play];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
