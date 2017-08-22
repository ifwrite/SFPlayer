//
//  ViewController.m
//  SFPlayerExample
//
//  Created by swifterfit on 2017/8/22.
//  Copyright © 2017年 swifterfit. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "SFPlayerView.h"
#import "SFPlayerModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //    self.ss_autorotate = YES;
    SFPlayerModel *playerModel = [[SFPlayerModel alloc] init];
    playerModel.videoUrl = [NSURL URLWithString:@"http://opbaqvgi8.bkt.clouddn.com/pl/0/b04a180b961b5e663382585757e8fc096d2695bf.m3u8"];
    SFPlayerView *playerView = [[SFPlayerView alloc] initWithModel:playerModel];
    [self.view addSubview:playerView];

    [playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(self.view.mas_width).multipliedBy(9.0f/16.0f);
    }];
    [playerView play];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
