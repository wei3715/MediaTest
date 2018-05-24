//
//  ZWWPlayUrlAudioViewController.m
//  MediaTest
//
//  Created by mac on 2018/5/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWPlayUrlAudioViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZWWMusicInfo.h"
#import "UIImageView+WebCache.h"
@interface ZWWPlayUrlAudioViewController ()

@property (nonatomic, strong) NSArray       *musicList;     //音乐列表数据
@property (nonatomic, strong) AVPlayer      *player;        //播放器
@property (nonatomic, strong) AVPlayerItem  *playerItem;          //播放条目
@property (nonatomic, assign) NSInteger     currentIndex;   //播放条目
@property (weak, nonatomic) IBOutlet UIImageView *bigBlurIV;
@property (weak, nonatomic) IBOutlet UIImageView *topSmallIV;
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;

@end

@implementation ZWWPlayUrlAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSArray *)musicList{
    if (!_musicList) {
        _musicList = [ZWWMusicInfo loadMusicInfo];
    }
    return _musicList;
}

- (AVPlayer *)player{
    if (!_player) {
        ZWWMusicInfo *musicInfo = self.musicList[self.currentIndex];
        NSURL *musicUrl = [NSURL URLWithString:musicInfo.music_url];
        [self createPlayerItemWithUrl:musicUrl];
        _player = [AVPlayer playerWithPlayerItem:self.playerItem];
    }
    return _player;
}

- (void)createPlayerItemWithUrl:(NSURL *)url{
    if (self.playerItem) {
        [self.playerItem removeObserver:self forKeyPath:@"status"];
    }
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    self.playerItem = item;
    //kvo监听itme状态变化
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}

//上一首
- (IBAction)preMusic:(UIButton *)sender {
    NSInteger index = (self.currentIndex - 1)<0?(self.musicList.count-1):(self.currentIndex-1);
    [self replaceCurrentPlayerItem:index];
}

//下一首
- (IBAction)nextMusic:(id)sender {
    
    NSInteger index = (self.currentIndex + 1)%(self.musicList.count);
    [self replaceCurrentPlayerItem:index];
}

//播放/暂停
- (IBAction)startAndPauseMusic:(UIButton *)sender {
    ZWWMusicInfo *musicInfo = self.musicList[self.currentIndex];
    sender.selected = !sender.selected;
    if (sender.selected) {//播放
        [self.player play];
        [self.bigBlurIV sd_setImageWithURL:[NSURL URLWithString:musicInfo.pic]];
    } else {//暂停
        [self.player pause];
    }
}

- (void)replaceCurrentPlayerItem:(NSInteger)index{
    ZWWMusicInfo *musicInfo = self.musicList[index];
    NSURL *musicUrl = [NSURL URLWithString:musicInfo.music_url];
    [self createPlayerItemWithUrl:musicUrl];
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    self.currentIndex = index;
    [self.bigBlurIV sd_setImageWithURL:[NSURL URLWithString:musicInfo.pic]];
}

//kvo 变化是调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        
        if (self.playerItem.status == AVPlayerItemStatusReadyToPlay) {
             //可以准备播放
            //设置音乐总体时间
            self.timeSlider.maximumValue = CMTimeGetSeconds(self.playerItem.duration);
            NSLog(@"时间总值==%lf",self.timeSlider.maximumValue);
            __weak typeof (self)weakSelf = self;
            
            //这里queue：也可以是 dispatch_get_global_queue(0, 0),不过weakSelf.timeSlider.value 这里更新UI的时候还需要再回到主线程才可以
            [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
                weakSelf.timeSlider.value = CMTimeGetSeconds(time);
            }];
        }
    } else if (self.playerItem.status == AVPlayerItemStatusFailed){
        NSLog(@"播放失败");
    }
}

- (void)dealloc{
   [self.playerItem removeObserver:self forKeyPath:@"status"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
