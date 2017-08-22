//
//  SFPlayerView.m
//  SFPlayerExample
//
//  Created by swifterfit on 2017/8/22.
//  Copyright © 2017年 swifterfit. All rights reserved.
//

#import "SFPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>
#import "SFPlayerModel.h"
#import "SFPlayerControlView.h"

@interface SFPlayerView ()<SFPlayerControlViewDelegate>

@property (strong, nonatomic) SFPlayerControlView *controlView;
@property (strong, nonatomic) SFPlayerModel *playerModel;
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVURLAsset *urlAsset;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;

@end

@implementation SFPlayerView

#pragma mark -
#pragma mark - life cycle
- (instancetype)initWithModel:(SFPlayerModel *)playerModel {
    if (self = [super init]) {
        self.playerModel = playerModel;
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.controlView];
        [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [self setupPlayer];
        [self addNotifications];
    }

    return self;
}

- (void)dealloc {
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}

#pragma mark -
#pragma mark - privarte methods
- (void)setupPlayer {
    self.urlAsset = [AVURLAsset assetWithURL:self.playerModel.videoUrl];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.layer insertSublayer:self.playerLayer atIndex:0];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)deviceOrientationDidChangeNotification {
    NSLog(@"orientation: %ld", [UIDevice currentDevice].orientation);
}

#pragma mark -
#pragma mark - add notifications
- (void)addNotifications {
    //设备旋转通知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationDidChangeNotification)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

#pragma mark -
#pragma mark - public methods
- (void)play {
    [self.controlView sf_controlViewPlayState:YES];
    [self.player play];
}

- (void)pause {
    [self.controlView sf_controlViewPlayState:NO];
    [self.player pause];
}

#pragma mark -
#pragma mark - SFPlayerControlViewDelegate
- (void)sf_controlView:(SFPlayerControlView *)controlView playAction:(UIButton *)sender {
    sender.selected ? [self play] : [self pause];
}

#pragma mark -
#pragma mark - lazy load
- (SFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [[SFPlayerControlView alloc] init];
        _controlView.delegate = self;
    }
    return _controlView;
}

@end
