# 解决问题

### 简单封装了一个UITextView，简单的创建就可以很好的使用一些功能（输入提示、字数统计、键盘遮盖上推）
#### 1.给UITextView增加了一个placeholder输入提示语
#### 2.给UITextView增加了一个输入字数统计（可不显示）
#### 3.当键盘遮住输入框时，可以设置其上推的数值

### 主要代码如下：
#### _textView_bot = [[MyTextView alloc] initWithFrame:CGRectMake(10, 300, 300, 200) placeholderLab:@"输入啊啊啊啊啊啊" labFont:13 maxLabNum:40 alertMge:@"输超了，哥把多的字给删了！" addSub:self.view];

#### _textView_bot.upTheView = ^(){//预留输入时调用口
#### 
#### };
#### _textView_bot.downTheView = ^(){//预留输入完成时调用口
#### 
#### };

![image](https://github.com/biyu6/MyTextView/blob/master/yanshi.gif)
