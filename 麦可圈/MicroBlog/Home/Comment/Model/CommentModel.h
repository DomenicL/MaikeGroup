//
//  CommentModel.h
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/19.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "JSONModel.h"
#import "UserModel.h"
#import "HomeModel.h"

@interface CommentModel : JSONModel

@property(nonatomic, copy)NSString      *created_at;
@property(nonatomic, assign)long        id;
@property(nonatomic, copy)NSString      *text;
@property(nonatomic, copy)NSString      *source;
@property(nonatomic, strong)UserModel   *user;
@property(nonatomic, copy)NSString      *mid;
@property(nonatomic, copy)NSString      *idstr;
@property(nonatomic, strong)HomeModel  *status;

@end
