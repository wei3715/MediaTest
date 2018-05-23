//
//  ZWWPlayAudioManager.h
//  MediaTest
//
//  Created by mac on 2018/5/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
@interface ZWWPlayAudioManager : NSObject

+ (instancetype)sharedManager;

//获取音效文件
- (SystemSoundID)getSoundID:(NSString *)fileName;

//播放音效
- (void)playSystemAudio:(NSString *)fileName;

//震动+播放音效
- (void)playAlertAudio:(NSString *)fileName;
@end
