//
//  ZWWTableViewController.m
//  MediaTest
//
//  Created by mac on 2018/5/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWTableViewController.h"
#import "ZWWTableViewController+method.h"
#import "ZWWPlayAudioManager.h"
#import "ZWWPlayLocalAudioViewController.h"
#import "ZWWPlayUrlAudioViewController.h"
#import "ZWWMediaViewController.h"
#import "ZWWMPMoviePlayerViewController.h"
#import "ZWWAVPlayerLayerViewController.h"
@interface ZWWTableViewController ()

@property (nonatomic, strong) NSArray  *titleArr;


@end

@implementation ZWWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArr = @[@"播放音效",@"播放本地音乐",@"播放网络音乐",@"视频播放器:MPMoviePlayerController",@"视频播放器:AV(MPMovie)PlayerViewController",@"视频播放器:AVPlayerLayer"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"baseCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _titleArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell" forIndexPath:indexPath];
    cell.textLabel.text = _titleArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{//需要框架AudioToolbox.framework
//            [self playAudio];
            //播放音效单例
            [[ZWWPlayAudioManager sharedManager]playAlertAudio:@"10054.wav"];
            break;
        }
        case 1:{
            ZWWPlayLocalAudioViewController *playLocalAudioVC = [[ZWWPlayLocalAudioViewController alloc]initWithNibName:@"ZWWPlayLocalAudioViewController" bundle:nil];
            [self.navigationController pushViewController:playLocalAudioVC animated:YES];
            break;
        }
        case 2:{
            ZWWPlayUrlAudioViewController *playUrlAudioVC = [[ZWWPlayUrlAudioViewController alloc]initWithNibName:@"ZWWPlayUrlAudioViewController" bundle:nil];
            [self.navigationController pushViewController:playUrlAudioVC animated:YES];
            break;
        }
        case 3:{
            ZWWMediaViewController *mediaVC = [[ZWWMediaViewController alloc]init];
            [self.navigationController pushViewController:mediaVC animated:YES];
            break;
        }
        case 4:{
            ZWWMPMoviePlayerViewController *moviePlayerVC = [[ZWWMPMoviePlayerViewController alloc]initWithNibName:@"ZWWMPMoviePlayerViewController" bundle:nil];
            [self.navigationController pushViewController:moviePlayerVC animated:YES];
            break;
        }
            
        case 5:{
            ZWWAVPlayerLayerViewController *moviePlayerLayerVC = [[ZWWAVPlayerLayerViewController alloc]initWithNibName:@"ZWWAVPlayerLayerViewController" bundle:nil];
            [self.navigationController pushViewController:moviePlayerLayerVC animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
