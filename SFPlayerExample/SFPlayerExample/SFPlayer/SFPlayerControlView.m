//
//  SFPlayerControlView.m
//  SFPlayerExample
//
//  Created by swifterfit on 2017/8/22.
//  Copyright © 2017年 swifterfit. All rights reserved.
//

#import "SFPlayerControlView.h"
#import <Masonry.h>

#define kControlViewBgColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0]

@interface SFPlayerControlView ()

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *bottomView;

@property (strong, nonatomic) UIButton *playBtn;
@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UILabel *duringLabel;
@property (strong, nonatomic) UISlider *duringSlider;
@property (strong, nonatomic) UIButton *fullScreenBtn;

@end

@implementation SFPlayerControlView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.topView];
        [self addSubview:self.bottomView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.leading.trailing.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.bottom.trailing.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];

        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
        singleTap.numberOfTouchesRequired = 1;  //触摸点个数
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
        doubleTap.numberOfTouchesRequired = 1;
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    return self;
}

- (void)singleTapAction:(UITapGestureRecognizer *)sender {
    [self sf_controlViewShowOrNot];
}

- (void)doubleTapAction:(UITapGestureRecognizer *)sender {
    [self playAction:self.playBtn];
}

- (void)backAction:(UIButton *)sender {

}
- (void)playAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    //播放隐藏controlPanel
    sender.isSelected ? [self hideControlPanelView] : nil;
    if ([self.delegate respondsToSelector:@selector(sf_controlView:playAction:)]) {
        [self.delegate sf_controlView:self playAction:sender];
    }
}

- (void)fullScreenAction:(UIButton *)sender {

}
- (void)showControlPanelView {
    [self autoHideControlPanelView];
    if (!self.bottomView.isHidden) { return; }
    [UIView animateWithDuration:0.2 animations:^{
        self.topView.alpha = 1;
        self.bottomView.alpha = 1;
    } completion:^(BOOL finished) {
        self.topView.hidden = NO;
        self.bottomView.hidden = NO;
    }];
}
- (void)hideControlPanelView {
    if (self.bottomView.isHidden) { return; }
    [UIView animateWithDuration:0.2 animations:^{
        self.topView.alpha = 0;
        self.bottomView.alpha = 0;
    } completion:^(BOOL finished) {
        self.topView.hidden = YES;
        self.bottomView.hidden = YES;
    }];
}

#warning todo
- (void)autoHideControlPanelView {
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self hideControlPanelView];
    //    });
}

#pragma mark -
#pragma mark - public method
- (void)sf_controlViewShowOrNot {
    self.topView.isHidden ? [self showControlPanelView] : [self hideControlPanelView];
}

- (void)sf_controlViewPlayState:(BOOL)isPlaying {
    self.playBtn.selected = isPlaying;

    //播放中自动隐藏panel
    if (isPlaying && !self.bottomView.hidden) {
        [self autoHideControlPanelView];
    }
}

#pragma mark -
#pragma mark - lazy load
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = kControlViewBgColor;

        self.backBtn = [[UIButton alloc] init];
        [self.backBtn setImage:[UIImage imageNamed:@"SFPlayer.bundle/bbi_arrow_back_white"] forState:UIControlStateNormal];
        [self.backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:self.backBtn];
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.leading.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    }
    return _topView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = kControlViewBgColor;

        self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.playBtn setImage:[UIImage imageNamed:@"SFPlayer.bundle/player_ctrl_icon_play"] forState:UIControlStateNormal];
        [self.playBtn setImage:[UIImage imageNamed:@"SFPlayer.bundle/player_ctrl_icon_pause"] forState:UIControlStateSelected];
        self.playBtn.adjustsImageWhenHighlighted = NO;   //高亮灰色取消
        [self.playBtn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:self.playBtn];
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(_bottomView);
        }];

        self.duringLabel = [[UILabel alloc] init];
        self.duringLabel.textColor = [UIColor whiteColor];
        self.duringLabel.font = [UIFont systemFontOfSize:10];
        [_bottomView addSubview:self.duringLabel];
        [self.duringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.playBtn.mas_trailing).with.offset(10);
            make.centerY.mas_equalTo(_bottomView);
        }];
        self.duringLabel.text = @"20:13/01:21";

        self.duringSlider = [[UISlider alloc] init];
        [_bottomView addSubview:self.duringSlider];
        [self.duringSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.duringLabel.mas_trailing).with.offset(10);
            make.centerY.mas_equalTo(_bottomView);
            make.trailing.mas_equalTo(_bottomView.mas_trailing).with.offset(-55);
        }];

        self.fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.fullScreenBtn setImage:[UIImage imageNamed:@"SFPlayer.bundle/player_icon_fullscreen"] forState:UIControlStateNormal];
        [self.fullScreenBtn addTarget:self action:@selector(fullScreenAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:self.fullScreenBtn];
        [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(_bottomView);
        }];
    }
    return _bottomView;
}

@end
