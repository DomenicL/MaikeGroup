//
//  HomeTableCell.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/13.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "HomeTableCell.h"
#import "UserModel.h"
#import "ZoomImageView.h"

@implementation HomeTableCell

-(void)awakeFromNib
{
    _headImage.layer.cornerRadius = 5;
    _headImage.layer.borderWidth = 0.5;
    _headImage.layer.borderColor = [UIColor grayColor].CGColor;
    _headImage.layer.masksToBounds = YES;
    
    _reBackground.layer.cornerRadius = 5;
    _reBackground.layer.borderWidth = 0.5;
    _reBackground.layer.borderColor = [UIColor whiteColor].CGColor;
    _reBackground.layer.masksToBounds = YES;
    
}

-(void)layoutSubviews
{
    if (_weiboLayoutModel != nil) {
        NSURL *url = [NSURL URLWithString:self.weiboLayoutModel.homeModel.user.profile_image_url];
        
        [self.headImage sd_setImageWithURL:url];
        
        self.nickName.text = self.weiboLayoutModel.homeModel.user.screen_name;
        self.nickName.textColor = [[ThemeManager defultManager] changeColor:@"More_Item_Text_color"];

        self.time.textColor = [[ThemeManager defultManager] changeColor:@"More_Item_Text_color"];
//        正则表达式截取需要字段
        NSString *timeRegex = @"\\d\\d:\\d\\d:\\d\\d";
                NSArray *item1 = [self.weiboLayoutModel.homeModel.created_at componentsMatchedByRegex:timeRegex];
                for (NSString *result in item1) {
                    self.time.text = result;
                }
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        //日期的格式
//        NSString *format = @"E M d HH:mm:ss Z yyyy";
//        [formatter setDateFormat:format];
//        
//        //设置本地化时间
//        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//        [formatter setLocale:locale];
//        
//        NSDate *date = [formatter dateFromString:self.weiboLayoutModel.homeModel.createDate ];
//        self.time.text = [date descriptionWithLocale:locale];

        
        self.sourceLabel.textColor = [[ThemeManager defultManager] changeColor:@"More_Item_Text_color"];
        //正则表达式截取需要字段
        NSString *sourceRegex = @"nofollow\">\\b\\w+\\b";
        NSArray *item2 = [self.weiboLayoutModel.homeModel.source componentsMatchedByRegex:sourceRegex];
        for (NSString *result in item2) {
            NSString *str = [result substringWithRange:NSMakeRange(10, result.length- 10)];
            self.sourceLabel.text = [NSString stringWithFormat:@"来源:%@",str];
        }
        
        //自己微博文本图片内容
        self.content.text = self.weiboLayoutModel.homeModel.text;
        self.content.textColor = [[ThemeManager defultManager] changeColor:@"More_Item_Text_color"];
        self.content.wxLabelDelegate = self;
        
        for (int i = 0; i<self.weiboLayoutModel.homeModel.pic_urls.count; i++) {
            ZoomImageView *imgView = self.imageArray[i];
            NSString *imgUrlStr = self.weiboLayoutModel.homeModel.pic_urls[i][@"thumbnail_pic"];
            [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrlStr]];
            
            NSMutableString *lastString = [NSMutableString stringWithString:imgUrlStr];
            NSRange range = [lastString rangeOfString:@"thumbnail"];
            [lastString replaceCharactersInRange:range withString:@"large"];
            imgView.urlString = lastString;
            
            NSString *str = [imgUrlStr pathExtension];
            if ([str isEqualToString:@"gif"]) {
                imgView.isGif = YES;
            }else
            {
                imgView.isGif = NO;
            }
        }
        
//添加字符串属性
//        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.weiboLayoutModel.homeModel.text];
//        NSString *webRegex = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
//        
//        //创建正则表达式
//        NSRegularExpression *regexString = [[NSRegularExpression alloc] initWithPattern:webRegex options:NSRegularExpressionCaseInsensitive error:nil];
//        NSArray *item = [regexString matchesInString:self.weiboLayoutModel.homeModel.text options:NSMatchingReportProgress range:NSMakeRange(0, self.weiboLayoutModel.homeModel.text.length)];
//
//        //便利出符合的条件
//        for (NSTextCheckingResult *result in item) {
//        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:result.range];
//        [attrStr addAttribute:NSLinkAttributeName value:[self.weiboLayoutModel.homeModel.text substringWithRange:result.range] range:result.range];
//        }
//        self.content.attributedText = attrStr;
 
        
//        NSURL *imageURL = [NSURL URLWithString:self.weiboLayoutModel.homeModel.thumbnailImage];
//        [self.myImage sd_setImageWithURL:imageURL];
        
        //被转发文本图片内容
        NSString *wholeText = [NSString stringWithFormat:@"@%@:%@",self.weiboLayoutModel.homeModel.retweeted_status.user.name,self.weiboLayoutModel.homeModel.retweeted_status.text];
        self.retext.text = wholeText;
        self.retext.numberOfLines = 0;
        self.retext.textColor = [UIColor darkGrayColor];
        self.retext.wxLabelDelegate = self;
        
        for (int i = 0; i<self.weiboLayoutModel.homeModel.retweeted_status.pic_urls.count; i++) {
            ZoomImageView *reimgView = self.reImageArray[i];
            NSString *reimgUrlStr = self.weiboLayoutModel.homeModel.retweeted_status.pic_urls[i][@"thumbnail_pic"];
            [reimgView sd_setImageWithURL:[NSURL URLWithString:reimgUrlStr]];
            NSMutableString *lastString = [NSMutableString stringWithString:reimgUrlStr];
            NSRange range = [lastString rangeOfString:@"thumbnail"];
            [lastString replaceCharactersInRange:range withString:@"large"];
            reimgView.urlString = lastString;
        }
        
//        NSURL *reImageURL = [NSURL URLWithString:self.weiboLayoutModel.homeModel.reWeibo.thumbnailImage];
//        [self.reImage sd_setImageWithURL:reImageURL];
        
        self.content.numberOfLines = 0;
        [self.comment setTitle:[NSString stringWithFormat:@"评论:%i",_weiboLayoutModel.homeModel.comments_count] forState:UIControlStateNormal];
        
        [self.repost setTitle:[NSString stringWithFormat:@"转发:%d",_weiboLayoutModel.homeModel.reposts_count] forState:UIControlStateNormal];
        [self.perfer setTitle:[NSString stringWithFormat:@"赞:%d",_weiboLayoutModel.homeModel.attitudes_count] forState:UIControlStateNormal];
    }
}

- (void)setWeiboLayoutModel:(WeiboLayoutFrame *)weiboLayoutModel
{
    if (_weiboLayoutModel != weiboLayoutModel) {
        _weiboLayoutModel = weiboLayoutModel;
        [self layoutSubviews];
        
        //调用set方法时给各框架赋值
        self.weiboView.frame = _weiboLayoutModel.weiboFrame;
        self.content.frame= _weiboLayoutModel.textFrame;
        self.reBackground.frame = _weiboLayoutModel.bkgFrame;
        //微博多图赋值

        self.retext.frame = _weiboLayoutModel.retweetTextFrame;


        
        
        self.repost.origin = CGPointMake(CGRectGetMinX(_weiboLayoutModel.weiboFrame), CGRectGetMaxY(_weiboLayoutModel.weiboFrame) + 5);
        self.comment.origin = CGPointMake(kSCreenWidth/2 - 41, CGRectGetMaxY(_weiboLayoutModel.weiboFrame) + 5);
        self.perfer.origin = CGPointMake(kSCreenWidth - 90, CGRectGetMaxY(_weiboLayoutModel.weiboFrame) + 5);
#warning 加判断！！！！！！
        for (int i = 0; i < self.imageArray.count; i++) {
            ZoomImageView *imgView = self.imageArray[i];
            imgView.frame = [self.weiboLayoutModel.imgFrameArr[i] CGRectValue];
            
            ZoomImageView *retweetImgView = self.reImageArray[i];
            retweetImgView.frame = [self.weiboLayoutModel.retweetImgFrameArr[i] CGRectValue];

        }
        
    }
}

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
        for (int i = 0; i < 9; i++) {
            ZoomImageView *imgView = [[ZoomImageView alloc] init];
            [_weiboView addSubview:imgView];
            
            [_imageArray addObject:imgView];
        }
    }
    return _imageArray;
}

- (NSMutableArray *)reImageArray
{
    if (!_reImageArray) {
        _reImageArray = [NSMutableArray array];
        for (int i = 0; i < 9; i++) {
            ZoomImageView *reimgView = [[ZoomImageView alloc] init];
            [_reBackground addSubview:reimgView];
            [_reImageArray addObject:reimgView];
        }
    }
    return _reImageArray;
}

//检索文本的正则表达式的字符串
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
{
    NSString *regex1 = @"@\\w+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#\\w+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}
//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel
{
    UIColor *color = [UIColor colorWithRed:100/255.0 green:151/255.0 blue:249/255.0 alpha:1];
    return color;
}
//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel
{
    UIColor *color = [UIColor redColor];
    return color;
}
//手指离开当前超链接文本响应的协议方法
- (void)toucheEndWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context
{
    NSURL *url = [NSURL URLWithString:context];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (NSString *)imagesOfRegexStringWithWXLabel:(WXLabel *)wxLabel
{
    return @"\\[\\w+\\]";
}

- (IBAction)repostButton:(id)sender {
}

- (IBAction)commentButton:(id)sender {
}

- (IBAction)perferButton:(id)sender {
}
@end
