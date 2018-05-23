//
//  ZWWMusicInfo.m
//  MediaTest
//
//  Created by mac on 2018/5/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWMusicInfo.h"

@implementation ZWWMusicInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (NSArray *)loadMusicInfo{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"music.plist" ofType:nil];
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *musicList = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dict in dataList) {
        ZWWMusicInfo *info = [[ZWWMusicInfo alloc]init];
        [info setValuesForKeysWithDictionary:dict];
        [musicList addObject:info];
    }
    return [musicList copy];
}

@end
