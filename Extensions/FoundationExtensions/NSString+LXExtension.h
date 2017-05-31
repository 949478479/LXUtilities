//
//  NSString+LXExtension.h
//
//  Created by 从今以后 on 15/9/17.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import UIKit;
#import "LXMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LXExtension)

///--------------
/// @name 文本范围
///--------------

- (CGSize)lx_sizeWithBoundingSize:(CGSize)size font:(UIFont *)font;

///--------------
/// @name 文本校验
///--------------

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

///--------------
/// @name 加密处理
///--------------

- (NSString *)lx_MD5;
- (NSString *)lx_SHA1;
- (NSString *)lx_SHA224;
- (NSString *)lx_SHA256;
- (NSString *)lx_SHA384;
- (NSString *)lx_SHA512;

///-----------
/// @name 其他
///-----------

/// 根据字符串生成URL
- (nullable NSURL *)lx_URL;

/// 将非字母、数字、下划线的字符替换为下划线。开头的数字也会被替换为下划线。
- (NSString *)lx_alphanumericString;

/// 根据 JSON 对象生成 JSON 字符串
+ (nullable instancetype)lx_stringWithJSONObject:(id)obj;
+ (nullable instancetype)lx_stringWithJSONObject:(id)obj prettyPrinted:(BOOL)prettyPrinted;

/// 根据 JSON 字符串生成相应的 JSON 对象
- (nullable id)lx_JSONObject;
- (nullable id)lx_JSONObjectWithOptions:(NSJSONReadingOptions)options;

@end

LX_OVERLOADABLE
NS_INLINE NSRange LXMaxRange(NSString *string) {
    return (NSRange){0,string.length};
}

NS_ASSUME_NONNULL_END
