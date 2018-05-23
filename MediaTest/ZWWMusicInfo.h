//
//  ZWWMusicInfo.h
//  MediaTest
//
//  Created by mac on 2018/5/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWWMusicInfo : NSObject

@property (nonatomic, copy)  NSString       *music_url;
@property (nonatomic, copy)  NSString       *title;
@property (nonatomic, copy)  NSString       *artist;
@property (nonatomic, copy)  NSString       *pic;
@property (nonatomic, copy)  NSString       *content;

+ (NSArray *)loadMusicInfo;
@end
