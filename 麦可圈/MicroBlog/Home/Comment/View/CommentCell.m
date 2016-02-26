//
//  CommentCell.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/19.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "CommentCell.h"
#import "CommentLayout.h"
#import "NSDate+TimeAgo.h"
#import "WXLabel.h"

@implementation CommentCell

- (void)awakeFromNib {
    
}

- (void)setCommentLayout:(CommentLayout *)commentLayout
{
    if (_commentLayout != commentLayout) {
        _commentLayout = commentLayout;
        
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_commentLayout.commentModel.user.profile_image_url]];
        self.name.text = _commentLayout.commentModel.user.screen_name;
        self.time.text = [self parseDateStr:_commentLayout.commentModel.created_at];
        self.comment.text = _commentLayout.commentModel.text;
        _comment.wxLabelDelegate = self;
        self.comment.numberOfLines = 0;
    }

    
}


-(NSString *)parseDateStr:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *format = @"E M d HH:mm:ss Z yyyy";
    [formatter setDateFormat:format];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    
    NSDate *date = [formatter dateFromString:dateStr];
    return [date timeAgo];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - WXLabel Delegate
//返回正则表达式匹配的字符串
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel {
    
    NSString *regEx1 = @"http://([a-zA-Z0-9_.-]+(/)?)+";
    NSString *regEx2 = @"@[\\w.-]{2,30}";
    NSString *regEx3 = @"#[^#]+#";
    
    NSString *regEx =
    [NSString stringWithFormat:@"(%@)|(%@)|(%@)", regEx1, regEx2, regEx3];
    
    return regEx;
}

- (NSString *)imagesOfRegexStringWithWXLabel:(WXLabel *)wxLabel
{
    return @"\\[\\w+\\]{1,30}";
}

- (void)toucheEndWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:context]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:context]];
    }
}

//设置链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel {
    
    return [[ThemeManager defultManager] changeColor:@"Link_color"];
}

@end
