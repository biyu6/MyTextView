//
//  MyViewController.m
//  MyTextView
//
//  Created by hc_hzc on 2016/10/17.
//  Copyright © 2016年 hc_hzc. All rights reserved.
//
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define RGBAUIColorFrom(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]


#import "MyViewController.h"
#import "MyTextView.h"
#import "Masonry.h"

@interface MyViewController ()
@property (nonatomic, strong)MyTextView *textView_top;
@property (nonatomic, strong)MyTextView *textView_bot;

@end
@implementation MyViewController
#pragma mark- init初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //上
    _textView_top = [[MyTextView alloc] initWithFrame:CGRectMake(10, 70, 300, 200) placeholderLab:@"请输入要输入的内容" labFont:15 maxLabNum:120 alertMge:@"\n字数输入多了哦~" addSub:self.view];
    _textView_top.backgroundColor = [UIColor cyanColor];
    
    //下
    _textView_bot = [[MyTextView alloc] initWithFrame:CGRectMake(10, 300, 300, 200) placeholderLab:@"输入啊啊啊啊啊啊" labFont:13 maxLabNum:40 alertMge:@"输超了，哥把多的字给删了！" addSub:self.view];
    _textView_bot.backgroundColor = [UIColor cyanColor];
    WS(ws);
    _textView_bot.upTheView = ^(){//让view往上推
        [ws upTheViewFrames];
    };
    _textView_bot.downTheView = ^(){
        [ws KBDisappear];
    };

//================此为扩展--让bot里输入的东西保存到本地，下次再带出来====================
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"wordSuffixTextStr"];
    if (str.length > 0) {
        _textView_bot.text = str;
        _textView_bot.placeholderLab.text = @"";
        _textView_bot.titleNumLab.attributedText = [_textView_bot yuanStr:[NSString stringWithFormat:@"%zd/40",_textView_bot.text.length] fengeStr:@"/" qianColor:RGBAUIColorFrom(0x999999, 1)];
    }
//================此为扩展--让bot里输入的东西保存到本地，下次再带出来====================
    
    
    //按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 520, 100, 30)];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark- 用户交互
- (void)upTheViewFrames{
    [UIView animateWithDuration:0.25 animations:^{//view往上推了85
        self.view.transform = CGAffineTransformMakeTranslation(0, -85);
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self KBDisappear];
}
- (void)KBDisappear{
    [UIView animateWithDuration:0.25 animations:^{//推完了之后再回到原位
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    [_textView_top resignFirstResponder];
    [_textView_bot resignFirstResponder];
}
- (void)clickBtn{
    [self KBDisappear];
    NSLog(@"top输入的内容为：%@==",_textView_top.text);
    NSLog(@"bot输入的内容为：%@==",_textView_bot.text);
    
    //================此为扩展--让bot里输入的东西保存到本地，下次再带出来====================
        [[NSUserDefaults standardUserDefaults] setObject: _textView_bot.text forKey:@"wordSuffixTextStr"];
        NSLog(@"bot输入的内容保存成功");
    //================此为扩展--让bot里输入的东西保存到本地，下次再带出来====================
}


@end
