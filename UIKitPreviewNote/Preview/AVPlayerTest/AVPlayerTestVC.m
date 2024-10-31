//
//  AVPlayerTestVC.m
//  UIKitPreviewNote
//
//  Created by EDY on 2024/6/5.
//

#import "AVPlayerTestVC.h"
#import <AVFoundation/AVFoundation.h>
#import "AVPlayerTestVC+other.h"

@interface AVPlayerTestVC ()

@property (weak, nonatomic) IBOutlet UIView *viewPlay;

@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UISlider *sliderProgress;
@property (weak, nonatomic) IBOutlet UILabel *lbCurTime;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;

/// 播放器，需要#import <AVFoundation/AVFoundation.h>
@property (nonatomic, strong) AVPlayer *avPlayer;
/// 播放画布，需要设置正确的frame
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
/// 定时器，更新播放进度
@property (nonatomic, strong) id timeObserver;

@end

@implementation AVPlayerTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置播放控件
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.viewPlay.layer insertSublayer:playerLayer atIndex:0];
    _playerLayer = playerLayer;
    
    self.sliderProgress.minimumValue = 0;
    self.sliderProgress.maximumValue = 1;
    self.sliderProgress.value = 0;
    self.sliderProgress.continuous = NO;//收松开再回调
    
    // Add Kvo
    // 监听播放速度，用于判断播放状态：播放中or暂停中
    [self.avPlayer addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    // 添加定期时间观察者以更新播放进度
    __weak typeof(self) weakSelf = self;
    self.timeObserver = [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1.0, NSEC_PER_SEC) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        [weakSelf updatePlaybackProgress:time];
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.playerLayer.frame = self.viewPlay.bounds;
}

// 更新播放进度的方法
- (void)updatePlaybackProgress:(CMTime)currentTime {
    
    float currentSeconds = CMTimeGetSeconds(currentTime);
    self.lbCurTime.text = [self switchSecondsToMinute:CMTimeGetSeconds(currentTime)];
    
    float totalSeconds = CMTimeGetSeconds(self.avPlayer.currentItem.duration);
    if (currentSeconds >= 0 && totalSeconds > 0) {
        float progress = currentSeconds / totalSeconds;
        NSLog(@"当前播放进度: %.2f%%", progress * 100);
        // 你可以在这里更新进度条或其他 UI 元素
        self.sliderProgress.value = progress;
    }
}

// Mark: KVO
// 实现观察者回调方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"rate"] && object == self.avPlayer) {
        float rate = [change[NSKeyValueChangeNewKey] floatValue];
        if (rate == 0) {
            [self.btnPlay setTitle:@"暂停中" forState:UIControlStateNormal];
        } else if (rate == 1) {
            [self.btnPlay setTitle:@"播放中" forState:UIControlStateNormal];
        } else {
            [self.btnPlay setTitle:@"未知" forState:UIControlStateNormal];
        }
    }  else if ([keyPath isEqualToString:@"status"] && object == self.avPlayer.currentItem) {
        AVPlayerStatus status= [change[NSKeyValueChangeNewKey] intValue];
        AVPlayerItem *playerItem = object;
        if(status == AVPlayerStatusReadyToPlay){
            
            self.lbTime.text = [self switchSecondsToMinute:CMTimeGetSeconds(playerItem.duration)];
        } else {
            NSLog(@"播放失败");
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

// 移除观察者
- (void)dealloc {
    [self.avPlayer removeObserver:self forKeyPath:@"rate"];
    if (self.timeObserver) {
        [self.avPlayer removeTimeObserver:self.timeObserver];
        self.timeObserver = nil;
    }
}

// Mark: - Action

- (void)playUrlStr: (NSString*)urlStr {
    
    if (self.avPlayer.currentItem) {
        [self.avPlayer.currentItem removeObserver:self forKeyPath:@"status"];
    }
    
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[self convertUrlStr:urlStr]];
    // 监听状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];

    [self.avPlayer replaceCurrentItemWithPlayerItem:playerItem];
    
    [self.avPlayer play];
}

/// 点击播放or暂停
- (IBAction)clickPlay:(id)sender {
    if (self.avPlayer.rate == 0) {
        [self.avPlayer play];
    } else if (self.avPlayer.rate == 1) {
        [self.avPlayer pause];
    } else {
        
    }
}

/// 拖动进度条
- (IBAction)dragProgress:(UISlider*)sender {
    NSLog(@"dragProgress=%f", sender.value);
    CGFloat progress = sender.value;
}

/// 点击播放地址1
- (IBAction)clickSwUrl1:(id)sender {
    [self playUrlStr:@"https://xxxxxrecord.mp4"];
}

/// 点击播放地址2
- (IBAction)clickSwUrl2:(id)sender {
    [self playUrlStr:@"https://xxxxrecord.mp4"];
}

// MARK: - Getter

- (AVPlayer *)avPlayer {
    if (_avPlayer == nil) {
        _avPlayer = [[AVPlayer alloc] init];
        //设置全局音频
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [audioSession setActive:YES error:nil];
    }
    return _avPlayer;
}

@end
