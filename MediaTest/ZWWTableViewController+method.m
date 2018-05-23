//
//  ZWWTableViewController+method.m
//  MediaTest
//
//  Created by mac on 2018/5/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWTableViewController+method.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation ZWWTableViewController (method)


- (void)playAudio{
    
    //导入音效文件
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"10054.wav" withExtension:nil];
    
    SystemSoundID soundID = 0;
    //创建音效
    //AudioServicesCreateSystemSoundID执行完之后，如果soundID = 0，说明音效分配失败，如果soundID不为0，说明音效分配成功
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
    
    //每次都会有新的地址
    NSLog(@"音效地址==%d",soundID);
    
    //播放音效
//    AudioServicesPlaySystemSound(soundID);
    
    //音效+震动
    AudioServicesPlayAlertSound(soundID);
    
}

@end
