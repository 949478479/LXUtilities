//
//  NSString+LXExtension.m
//
//  Created by 从今以后 on 15/9/17.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSString+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSString (LXExtension)

#pragma mark - 文本范围 -

- (CGSize)lx_sizeWithBoundingSize:(CGSize)size font:(UIFont *)font
{
    NSParameterAssert(font != nil);
    return CGRectIntegral([self boundingRectWithSize:size
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{ NSFontAttributeName : font }
                                             context:nil]).size;
}

#pragma mark - 表单验证 -

- (BOOL)lx_evaluateWithRegularExpression:(NSString *)regularExpression
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpression] evaluateWithObject:self];
}

- (BOOL)lx_isDigit
{
    return [self lx_evaluateWithRegularExpression:@"^\\d+$"];
}

- (BOOL)lx_isChinese
{
    return [self lx_evaluateWithRegularExpression:@"^[\\u4e00-\\u9fa5]+$"];
}

- (BOOL)lx_isPhoneNumber
{
    /*
     三大运营商最新号段 2016.6
     移动号段：
     134 135 136 137 138 139 147 150 151 152 157 158 159 178 182 183 184 187 188
     联通号段：
     130 131 132 145 155 156 171 175 176 185 186
     电信号段：
     133 149 153 173 177 180 181 189
     虚拟运营商:
     170
     ------------------
     13x 系列: 130, 131, 132, 133, 134, 135, 136, 137, 138, 139. (全段)
     14x 系列: 145, 147, 149
     15x 系列: 150, 151, 152, 153, 155, 156, 157, 158, 159. (没有 154)
     17x 系列: 170, 171, 173, 175, 176, 177, 178.
     18x 系列: 180, 181, 182, 183, 184, 185, 186, 187, 188, 189. (全段)
     */
    return [self lx_evaluateWithRegularExpression:@"^1([38]\\d|4[579]|5[012356789]|7[0135678])\\d{8}$"];
}

- (BOOL)lx_isEmail
{
    /*
     邮件地址一般是: 字母, 数字, "_". 有的还能有 ".", "-". 一般4-18字符.各种邮箱要求不一...
     域名几乎都是 abc.com, abc.cn, 123.com, 123.cn 这种形式.
     */
    return [self lx_evaluateWithRegularExpression:@"^([a-zA-Z0-9\\.\\-_]+)@([a-zA-Z0-9]+)\\.(com|cn)$"];
}

- (BOOL)lx_isEmpty
{
    return [self isEqualToString:@""];
}

#pragma mark - 加密处理 -

typedef unsigned char *__LXDigestFunction(const void *data, CC_LONG len, unsigned char *md);

- (NSString *)lx_hashStringWithDigestLength:(CC_LONG)digestLength
                             digestFunction:(__LXDigestFunction)digestFunction
{
    const char *string = self.UTF8String;

    unsigned char digest[digestLength];

    digestFunction(string, (CC_LONG)strlen(string), digest);

	NSString *hashedString = [NSString stringWithFormat:
						   @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
						   digest[0], digest[1],
						   digest[2], digest[3],
						   digest[4], digest[5],
						   digest[6], digest[7],
						   digest[8], digest[9],
						   digest[10], digest[11],
						   digest[12], digest[13],
						   digest[14], digest[15]];

	return hashedString;
}

- (NSString *)lx_MD5
{
    return [self lx_hashStringWithDigestLength:CC_MD5_DIGEST_LENGTH digestFunction:CC_MD5];
}

- (NSString *)lx_SHA1
{
    return [self lx_hashStringWithDigestLength:CC_SHA1_DIGEST_LENGTH digestFunction:CC_SHA1];
}

- (NSString *)lx_SHA224
{
    return [self lx_hashStringWithDigestLength:CC_SHA224_DIGEST_LENGTH digestFunction:CC_SHA224];
}

- (NSString *)lx_SHA256
{
    return [self lx_hashStringWithDigestLength:CC_SHA256_DIGEST_LENGTH digestFunction:CC_SHA256];
}

- (NSString *)lx_SHA384
{
    return [self lx_hashStringWithDigestLength:CC_SHA384_DIGEST_LENGTH digestFunction:CC_SHA384];
}

- (NSString *)lx_SHA512
{
    return [self lx_hashStringWithDigestLength:CC_SHA512_DIGEST_LENGTH digestFunction:CC_SHA512];
}

#pragma mark - 其他 -

- (nullable NSURL *)lx_URL
{
    return [NSURL URLWithString:self];
}

- (NSString *)lx_alphanumericString
{
    NSParameterAssert(self.length > 0);
    
    NSMutableString *alphanumericString = self.mutableCopy;

    [alphanumericString replaceOccurrencesOfString:@"[^a-z0-9A-Z_]"
                                        withString:@"_"
                                           options:NSRegularExpressionSearch
                                             range:(NSRange){0,self.length}];

    [alphanumericString replaceOccurrencesOfString:@"[^a-zA-Z_]"
                                        withString:@"_"
                                           options:NSRegularExpressionSearch
                                             range:(NSRange){0,1}];
    return alphanumericString;
}

+ (nullable instancetype)lx_stringWithJSONObject:(id)obj
{
    return [self lx_stringWithJSONObject:obj prettyPrinted:NO];
}

+ (nullable instancetype)lx_stringWithJSONObject:(id)obj prettyPrinted:(BOOL)prettyPrinted
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj
                                                   options:prettyPrinted ? NSJSONWritingPrettyPrinted : 0
                                                     error:NULL];
    return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end

NS_ASSUME_NONNULL_END
