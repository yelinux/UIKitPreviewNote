//
//  AVPlayerTestVC+other.m
//  UIKitPreviewNote
//
//  Created by EDY on 2024/6/5.
//

#import "AVPlayerTestVC+other.h"

@implementation AVPlayerTestVC (other)

- (NSURL*)convertUrlStr: (NSString*)urlStr {
    NSURL *requestUrl ;
    if ([urlStr hasPrefix:@"http"]) {
        requestUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlStr]];
    }else{
        requestUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@",urlStr]];
    }
    //判断是否需要转吗，如果需要则直接使用
    if (!requestUrl) {
        //中文转码
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        if ([urlStr containsString:@"http"]) {
            requestUrl = [NSURL URLWithString:urlStr];
        }else{
            requestUrl = [NSURL fileURLWithPath:urlStr];
        }
    }
    return requestUrl;
}

///时间转换
- (NSString*)switchSecondsToMinute:(float)seconds{
    
    NSString *minuteStr;
    NSString *secondStr;
    
    seconds = floor(seconds);
    NSInteger minute = seconds/60;
    //NSInteger hour = minute/60;
    NSInteger second = (int)seconds%60;
    
    if (second>9) {
        secondStr = [NSString stringWithFormat:@"%ld",second];
    }else{
        secondStr = [NSString stringWithFormat:@"0%ld",second];
    }
    
    if (minute>9.0) {
        minuteStr = [NSString stringWithFormat:@"%ld:%@",minute,secondStr];
    }else{
        minuteStr = [NSString stringWithFormat:@"0%ld:%@",minute,secondStr];
    }
    /*
    if (hour>0) {
        if (hour>9.0) {
            hour = [NSString stringWithFormat:@"%ld:%@",hour,minuteStr];
        }else{
            hour = [NSString stringWithFormat:@"0%ld:%@",hour,minuteStr];
        }
    }*/
    return minuteStr;
}

@end
