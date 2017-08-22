//
//  SFPlayerControlViewDelegate.h
//  SFPlayerExample
//
//  Created by swifterfit on 2017/8/22.
//  Copyright © 2017年 swifterfit. All rights reserved.
//

#ifndef SFPlayerControlViewDelegate_h
#define SFPlayerControlViewDelegate_h


#endif /* SFPlayerControlViewDelegate_h */

@class SFPlayerControlView;

@protocol SFPlayerControlViewDelegate <NSObject>

@optional;
- (void)sf_controlView:(SFPlayerControlView *)controlView playAction:(UIButton *)sender;

@end
