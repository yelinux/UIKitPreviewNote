//
//  AVPlayerTestVC+other.h
//  UIKitPreviewNote
//
//  Created by EDY on 2024/6/5.
//

#import "AVPlayerTestVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface AVPlayerTestVC (other)

- (NSURL*)convertUrlStr: (NSString*)urlStr;

///时间转换
- (NSString*)switchSecondsToMinute:(float)seconds;

@end

NS_ASSUME_NONNULL_END
