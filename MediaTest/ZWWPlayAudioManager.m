//
//  ZWWPlayAudioManager.m
//  MediaTest
//
//  Created by mac on 2018/5/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWPlayAudioManager.h"


@interface ZWWPlayAudioManager ()
@property (nonatomic, strong) NSMutableDictionary *dic;
@end
@implementation ZWWPlayAudioManager

+ (instancetype)sharedManager{
    static ZWWPlayAudioManager *audioManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioManager = [[ZWWPlayAudioManager alloc]init];
    });
    return audioManager;
}

//存放音效SystemSoundID，避免每次都生成新的地址存放音效文件
- (NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [[NSMutableDictionary alloc]init];
    }
    return _dic;
}

- (SystemSoundID)getSoundID:(NSString *)fileName{
    
    if ([[self.dic valueForKey:fileName]intValue]) {
        return [[self.dic valueForKey:fileName]intValue];
    }
    
    //音效文件
    NSURL *url = [[NSBundle mainBundle]URLForResource:fileName withExtension:nil];
    
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
    
    //存储音效
    [self.dic setObject:@(soundID) forKey:fileName];
    return soundID;
}

- (void)playSystemAudio:(NSString *)fileName{
    SystemSoundID soundID = [self getSoundID:fileName];
    NSLog(@"音效地址==%d",soundID);
    AudioServicesPlaySystemSound(soundID);
}


- (void)playAlertAudio:(NSString *)fileName{
    SystemSoundID soundID = [self getSoundID:fileName];
    NSLog(@"音效地址==%d",soundID);
    AudioServicesPlaySystemSound(soundID);
}

@end
