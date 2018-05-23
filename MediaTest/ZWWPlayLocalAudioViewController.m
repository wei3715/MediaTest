//
//  ZWWPlayLocalAudioViewController.m
//  MediaTest
//
//  Created by mac on 2018/5/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWPlayLocalAudioViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ZWWPlayLocalAudioViewController ()<AVAudioPlayerDelegate>
//音乐播放进度
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;

//本地音乐播放器
@property (strong, nonatomic) AVAudioPlayer   *player;

//监听音乐变化的时间定时器
@property (strong, nonatomic) CADisplayLink   *link;

@end

@implementation ZWWPlayLocalAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

-(AVAudioPlayer *)player{
    if (!_player) {
        NSURL *url = [[NSBundle mainBundle]URLForResource:@"体面" withExtension:@"mp3"];
        NSError *error = nil;
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        if (error) {
            NSLog(@"播放器初始化失败");
        }else {
            //初始化成功
            NSLog(@"播放器初始化成功");
            //设置这个属性后才可以改变音乐的播放速率，而且必须放在prepareToPlay之前设置
            _player.enableRate = YES;
            _player.delegate = self;
            //准备播放，缓冲数据，可以让播放更加流畅
            [_player prepareToPlay];
           
            //将音乐的总时长设置为滑块的最大值
            self.progressSlider.maximumValue = _player.duration;
        }
    }
    return _player;
}
//播放速率改变
- (IBAction)rateChanged:(UISlider *)sender {
    //速率范围设置为0.5-2.0，默认为1.0
    self.player.rate = sender.value;
}

//播放音量改变
- (IBAction)volumeChanged:(UISlider *)sender {
    //速率范围设置为0-2，默认为1.0
    self.player.volume = sender.value;
}

-(CADisplayLink *)link{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(change)];
    }
    return _link;
}

- (void)change{
    //获取当前的播放时间
    self.progressSlider.value = self.player.currentTime;
    
}

//拖动滑块
- (IBAction)timeChanged:(UISlider *)sender {
    //更改播放进度
    self.player.currentTime = sender.value;
}

//开始拖动滑块，手指按下滑块
- (IBAction)timeTouchDown:(id)sender {
    //暂停播放
    [self pauseMusic:nil];
}

//停止拖动滑块，手指离开滑块
- (IBAction)timeTouchUp:(id)sender {
    //继续播放
    [self startMusic:nil];
}

//停止
- (IBAction)stopMusic:(id)sender {
    [self.player stop];
    self.player = nil;
    //取消定时器
    [self.link invalidate];
    self.link = nil;
}
//开始
- (IBAction)startMusic:(id)sender {
    if (![self.player isPlaying]) {
        //添加时间定时器
        [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.player play];
    }
}

//暂停
- (IBAction)pauseMusic:(id)sender {
    if ([self.player isPlaying]) {
        [self.player pause];
        //取消定时器
        [self.link invalidate];
        self.link = nil;
    }
}


#pragma delegate
//播放结束
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"播放结束");
}

//播放失败
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error{
    NSLog(@"播放失败");
}

//播放中中断（音乐播放期间来电话）
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
    //暂停播放
    [self pauseMusic:nil];
}
//中断结束（打完电话回到音乐播放器）
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags{
    //继续播放
    [self startMusic:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
