//
//  ProfileViewController.m
//  Heath
//
//  Created by 熊伟 on 16/4/7.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "ProfileViewController.h"
#import "iflyMSC/IFlyMSC.h"
#import "IATConfig.h"
#import "PopupView.h"

@interface ProfileViewController ()<IFlyRecognizerViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) IFlyRecognizerView * iFlyRecognizer;//带界面的识别对象
@property (nonatomic, strong) NSString *pcmFilePath;//音频文件路径
@property (nonatomic, strong) IFlyDataUploader *uploader;//数据上传对象
//@property (nonatomic, strong) PopupView *popUpView;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTextView];
    [self setUpFlyRecognizer];
    
}

- (void)setUpTextView {
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 69, self.view.bounds.size.width - 10, 260)];
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 5;
    [self.view addSubview:self.textView];
    
    self.uploader = [[IFlyDataUploader alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    _pcmFilePath = [[NSString alloc] initWithFormat:@"%@",[cachePath stringByAppendingPathComponent:@"asr.pcm"]];
    
    UIButton *starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    starBtn.frame = CGRectMake(100, 400, 50, 30);
    [starBtn setTitle:@"开始" forState:UIControlStateNormal];
    [starBtn addTarget:self action:@selector(starBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:starBtn];
    
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    endBtn.frame = CGRectMake(300, 400, 50, 30);
    [endBtn setTitle:@"完成" forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(endBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:endBtn];
    
    
}
//完成
- (void)endBtnClick:(UIButton *)endBtn {
    
}

//开始
- (void)starBtnClick:(UIButton *)starBtn {
    if (_iFlyRecognizer == nil) {
        [self setUpFlyRecognizer];
    }
    
    [_textView setText:@""];
    [_textView resignFirstResponder];
    
    [_iFlyRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    [_iFlyRecognizer setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    [_iFlyRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    [_iFlyRecognizer start];
}



- (void)setUpFlyRecognizer {
    if (_iFlyRecognizer == nil) {
        _iFlyRecognizer = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
        
        [_iFlyRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        [_iFlyRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
    }
    
    _iFlyRecognizer.delegate = self;
    
    if (_iFlyRecognizer != nil) {
        IATConfig *instance = [IATConfig sharedInstance];
        //设置最长录音时间
        [_iFlyRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iFlyRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iFlyRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iFlyRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        
        //设置采样率，推荐使用16k
        [_iFlyRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        //设置语言
        [_iFlyRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        //设置方言
        [_iFlyRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        //设置是否返回标点符号
        [_iFlyRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
        
    }
    
}

#pragma mark -- IFlySpeechRecognizerDelegate

- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast {
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    
    _textView.text = [NSString stringWithFormat:@"%@%@",_textView.text,result];
}

- (void)onError:(IFlySpeechError *)error {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
