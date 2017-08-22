//
//  SFPlayerView.h
//  SFPlayerExample
//
//  Created by swifterfit on 2017/8/22.
//  Copyright © 2017年 swifterfit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SFPlayerModel;

@interface SFPlayerView : UIView

- (instancetype)initWithModel:(SFPlayerModel *)playerModel;

- (void)play;
- (void)pause;

@end
