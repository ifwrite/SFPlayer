//
//  SFPlayerControlView.h
//  SFPlayerExample
//
//  Created by swifterfit on 2017/8/22.
//  Copyright © 2017年 swifterfit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFPlayerControlViewDelegate.h"

@interface SFPlayerControlView : UIView

@property (weak, nonatomic) id<SFPlayerControlViewDelegate> delegate;

- (void)sf_controlViewPlayState:(BOOL)isPlaying;

@end
