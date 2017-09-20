//
//  NSString+LXExtension.h
//
//  Created by 从今以后 on 15/9/17.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import UIKit;
#import "LXMacro.h"

NS_ASSUME_NONNULL_BEGIN

LX_OVERLOADABLE
NS_INLINE NSRange LXMaxRange(NSString *string) {
    return (NSRange){0,string.length};
}


#pragma mark - 正则

///-----------
/// @name 正则
///-----------

@interface NSString (LXRegularExpression)

- (BOOL)lx_isMoney;
- (BOOL)lx_isDigit;
- (BOOL)lx_isEmail;
- (BOOL)lx_isChinese;
- (BOOL)lx_isPhoneNumber;
- (BOOL)lx_isIDCardNumber;
- (BOOL)lx_onlyContainsAlphanumericUnderline;

- (BOOL)lx_isEmpty;
- (BOOL)lx_hasCharacters;

- (BOOL)lx_evaluateWithRegExp:(NSString *)regExp;

@end


#pragma mark - 哈希

///-----------
/// @name 哈希
///-----------

@interface NSString (LXHash)

- (NSString *)lx_MD5;
- (NSString *)lx_SHA1;
- (NSString *)lx_SHA224;
- (NSString *)lx_SHA256;
- (NSString *)lx_SHA384;
- (NSString *)lx_SHA512;

- (NSString *)lx_HMACMD5WithKey:(NSString *)key;
- (NSString *)lx_HMACSHA1WithKey:(NSString *)key;
- (NSString *)lx_HMACSHA224WithKey:(NSString *)key;
- (NSString *)lx_HMACSHA256WithKey:(NSString *)key;
- (NSString *)lx_HMACSHA384WithKey:(NSString *)key;
- (NSString *)lx_HMACSHA512WithKey:(NSString *)key;

@end


#pragma mark - JSON

///------------
/// @name JSON
///------------

@interface NSString (LXJSON)

/// 根据 JSON 对象生成 JSON 字符串
+ (nullable instancetype)lx_stringWithJSONObject:(id)obj;
+ (nullable instancetype)lx_stringWithJSONObject:(id)obj prettyPrinted:(BOOL)prettyPrinted;

/// 根据 JSON 字符串生成相应的 JSON 对象
- (nullable id)lx_JSONObject;
- (nullable id)lx_JSONObjectWithOptions:(NSJSONReadingOptions)options;

@end


#pragma mark - URL

///----------
/// @name URL
///----------

@interface NSString (LXURL)

/// 根据字符串生成URL
- (nullable NSURL *)lx_URL;

@end


#pragma mark - 绘图

///-----------
/// @name 绘图
///-----------

@interface NSString (LXDrawing)

- (CGSize)lx_sizeWithBoundingSize:(CGSize)size font:(UIFont *)font;

@end


#pragma mark - 其他

///-----------
/// @name 其他
///-----------

@interface NSString (LXOther)

/// 将非字母、数字、下划线的字符替换为下划线。开头的数字也会被替换为下划线。
- (NSString *)lx_alphanumericString;

@end

NS_ASSUME_NONNULL_END
