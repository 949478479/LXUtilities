//
//  NSString+LXExtension.m
//
//  Created by 从今以后 on 15/9/17.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import <CommonCrypto/CommonHMAC.h>
#import "NSString+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 正则

@implementation NSString (LXRegularExpression)

- (BOOL)lx_evaluateWithRegExp:(NSString *)regExp {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp] evaluateWithObject:self];
}

- (BOOL)lx_isMoney {
    return [self lx_evaluateWithRegExp:@"^(([1-9]\\d*)|(0))(\\.\\d{1,2})?$"];
}

- (BOOL)lx_isDigit {
    return [self lx_evaluateWithRegExp:@"^\\d+$"];
}

- (BOOL)lx_isChinese {
    return [self lx_evaluateWithRegExp:@"^[\\u4e00-\\u9fa5]+$"];
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
    return [self lx_evaluateWithRegExp:@"^1([38]\\d|4[579]|5[012356789]|7[0135678])\\d{8}$"];
}

- (BOOL)lx_isEmail
{
    /*
     邮件地址一般是: 字母, 数字, "_". 有的还能有 ".", "-". 一般4-18字符.各种邮箱要求不一...
     域名几乎都是 abc.com, abc.cn, 123.com, 123.cn 这种形式.
     */
    return [self lx_evaluateWithRegExp:@"^([a-zA-Z0-9\\.\\-_]+)@([a-zA-Z0-9]+)\\.(com|cn)$"];
}

- (BOOL)lx_isIDCardNumber
{
    /*
     身份证前6位为地域编码，前两位为省级行政区域代码，取值如下：

     11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",33:"浙江",34:"

     安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州"

     ,53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"

     身份证15位编码规则：dddddd yymmdd xx p
     dddddd：6位地区编码
     yymmdd: 出生年月日，如：920815
     xx: 顺序编码，系统产生，无法确定
     p: 性别，奇数为男，偶数为女
     
     (^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$) 用于匹配15位身份证号
     [1-9]\\d{7} 表示6位地域编码以及2位年份，这里并未对前两位省份编码进行更细致地检查
     ((0\\d)|(1[0-2])) 表示月，最大为 12，因此第一位只能是 0，1 两个数之一，如果是 1，则第二位只能是 0 或 1 或 2
     (([0|1|2]\\d)|3[0-1]) 表示日，最大为 31，因此第一位只能是 0，1，2，3 中的某个数，如果第一位是 3，则第二位只能是 0 或 1
     \\d{3} 表示后三位为任意数字

     身份证18位编码规则：dddddd yyyymmdd xxx y
     dddddd：6位地区编码
     yyyymmdd: 出生年(四位年)月日，如：19910215
     xxx：顺序编码，系统产生，无法确定，奇数为男，偶数为女
     y: 校验码，该位数值可通过前17位计算获得

     (^[1-9]\\d{5}((19)|(20))\\d{2}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$) 用于匹配18位身份证号
     
     [1-9]\\d{5} 表示前6位地区编码，这里并未对前两位进行更细致地检查
     ((19)|(20))\\d{2} 表示年份，只可能在 1900~2100 之间，因此前两位只能是 19 或 20
     ((0\\d)|(1[0-2])) 表示月，最大为 12，因此第一位只能是 0，1 两个数之一，如果是 1，则第二位只能是 0 或 1 或 2
     (([0|1|2]\\d)|3[0-1]) 表示日，最大为 31，因此第一位只能是 0，1，2，3 中的某个数，如果第一位是 3，则第二位只能是 0 或 1
     ((\\d{4})|\\d{3}[Xx]) 表示最后4位数字编码，或者3位数字编码最后一位是X或x
     */

    NSString *regularExpression = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}((19)|(20))\\d{2}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";

    // 验证格式是否符合
    if (![self lx_evaluateWithRegExp:regularExpression]) {
        return NO;
    }

    // 验证前两位省份编码是否有效
    int provinceNo = [[self substringToIndex:2] intValue];
    int provinceNos[] = { 11, 12, 13, 14, 15, 21, 22, 23, 31, 32, 33, 34, 35, 36, 37, 41, 42, 43, 44, 45, 46, 50, 51, 52, 53, 54, 61, 62, 63, 64, 65, 71, 81, 82, 91 };

    BOOL isValid = NO;
    for (int i = 0; i < 35; ++i) {
        if (provinceNo == provinceNos[i]) {
            isValid = YES;
            break;
        }
    }

    if (!isValid) {
        return NO;
    }

    // 15位身份证无校验位，因此只能再做些基本的日期有效性判断了
    if (self.length == 15) {

        int yearComponent = [[self substringWithRange:(NSRange){6,2}] intValue];
        int monthComponent = [[self substringWithRange:(NSRange){8,2}] intValue];
        int dayComponent = [[self substringWithRange:(NSRange){10,2}] intValue];

        // 两种可能的年份均非闰年时，则2月不可能大于28天
        if (monthComponent == 2) {
            int year1 = 1900 + yearComponent;
            int year2 = 2000 + yearComponent;
            BOOL condition1 = (!(year1 % 4) && (year1 % 100)) || !(year1 % 400);
            BOOL condition2 = (!(year2 % 4) && (year2 % 100)) || !(year2 % 400);
            if ((!condition1 && !condition2) && (dayComponent > 28)) {
                return NO;
            }
        }

        int smallMonth[] = { 4, 6, 9, 11 };
        for (int i = 0; i < 4; ++i) {
            if (monthComponent == smallMonth[i]) {
                if (dayComponent > 30) {
                    return NO;
                }
            }
        }

        return YES;
    }

    // 校验18位身份证的校验位
    int idCardWi[] = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    int idCardY[] = { 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 };

    int idCardWiSum = 0;
    for (int i = 0; i < 17; ++i) {
        idCardWiSum += [[self substringWithRange:(NSRange){i,1}] intValue] * idCardWi[i];
    }

    int idCardMod = idCardWiSum % 11;
    NSString *idCardLast = [self substringFromIndex:17];

    if (idCardMod == 2) {
        if ([idCardLast isEqualToString:@"X"] || [idCardLast isEqualToString:@"x"]) {
            return YES;
        }
        return NO;
    }

    return [idCardLast intValue] == idCardY[idCardMod];
}

- (BOOL)lx_onlyContainsAlphanumericUnderline {
    return [self lx_evaluateWithRegExp:@"^[a-zA-Z0-9_]+$"];
}

- (BOOL)lx_isEmpty {
    return self.length == 0;
}

- (BOOL)lx_hasCharacters {
    return self.length > 0;
}

@end

#pragma mark - 哈希

@implementation NSString (LXHash)

typedef unsigned char *LX_DigestAlgorithmFunction(const void *data, CC_LONG len, unsigned char *md);

- (NSString *)lx_digestWithAlgorithmFunction:(LX_DigestAlgorithmFunction)function digestLength:(CC_LONG)digestLength
{
    const char *data = self.UTF8String;
    uint8_t buffer[digestLength];
    function(data, (CC_LONG)strlen(data), buffer);
    NSMutableString *output = [NSMutableString stringWithCapacity:digestLength * 2];
    for (CC_LONG i = 0; i < digestLength; i++) {
        [output appendFormat:@"%02x", buffer[i]];
    }
    return output.copy;
}

- (NSString *)lx_MD5 {
    return [self lx_digestWithAlgorithmFunction:CC_MD5 digestLength:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)lx_SHA1 {
    return [self lx_digestWithAlgorithmFunction:CC_SHA1 digestLength:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)lx_SHA224 {
    return [self lx_digestWithAlgorithmFunction:CC_SHA224 digestLength:CC_SHA224_DIGEST_LENGTH];
}

- (NSString *)lx_SHA256 {
    return [self lx_digestWithAlgorithmFunction:CC_SHA256 digestLength:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)lx_SHA384 {
    return [self lx_digestWithAlgorithmFunction:CC_SHA384 digestLength:CC_SHA384_DIGEST_LENGTH];
}

- (NSString *)lx_SHA512 {
    return [self lx_digestWithAlgorithmFunction:CC_SHA512 digestLength:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)lx_HMACWithAlgorithm:(CCHmacAlgorithm)algorithm digestLength:(CC_LONG)digestLength key:(NSString *)key
{
    const char *data = self.UTF8String;
    const char *__key = key.UTF8String;
    uint8_t buffer[digestLength];
    CCHmac(algorithm, __key, strlen(__key), data, strlen(data), buffer);
    NSMutableString *output = [NSMutableString stringWithCapacity:digestLength * 2];
    for (CC_LONG i = 0; i < digestLength; i++) {
        [output appendFormat:@"%02x", buffer[i]];
    }
    return output.copy;
}

- (NSString *)lx_HMACMD5WithKey:(NSString *)key {
    return [self lx_HMACWithAlgorithm:kCCHmacAlgMD5 digestLength:CC_MD5_DIGEST_LENGTH key:key];
}

- (NSString *)lx_HMACSHA1WithKey:(NSString *)key {
    return [self lx_HMACWithAlgorithm:kCCHmacAlgSHA1 digestLength:CC_SHA1_DIGEST_LENGTH key:key];
}

- (NSString *)lx_HMACSHA224WithKey:(NSString *)key {
    return [self lx_HMACWithAlgorithm:kCCHmacAlgSHA224 digestLength:CC_SHA224_DIGEST_LENGTH key:key];
}

- (NSString *)lx_HMACSHA256WithKey:(NSString *)key {
    return [self lx_HMACWithAlgorithm:kCCHmacAlgSHA256 digestLength:CC_SHA256_DIGEST_LENGTH key:key];
}

- (NSString *)lx_HMACSHA384WithKey:(NSString *)key {
    return [self lx_HMACWithAlgorithm:kCCHmacAlgSHA384 digestLength:CC_SHA384_DIGEST_LENGTH key:key];
}

- (NSString *)lx_HMACSHA512WithKey:(NSString *)key {
    return [self lx_HMACWithAlgorithm:kCCHmacAlgSHA512 digestLength:CC_SHA512_DIGEST_LENGTH key:key];
}

@end

#pragma mark - JSON

@implementation NSString (LXJSON)

+ (nullable instancetype)lx_stringWithJSONObject:(id)obj {
    return [self lx_stringWithJSONObject:obj prettyPrinted:NO];
}

+ (nullable instancetype)lx_stringWithJSONObject:(id)obj prettyPrinted:(BOOL)prettyPrinted
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:prettyPrinted error:NULL];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (nullable id)lx_JSONObject {
    return [self lx_JSONObjectWithOptions:0];
}

- (nullable id)lx_JSONObjectWithOptions:(NSJSONReadingOptions)options
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:options error:NULL];
}

@end

#pragma mark - URL

@implementation NSString (LXURL)

- (nullable NSURL *)lx_URL {
    return [NSURL URLWithString:self];
}

@end

#pragma mark - 绘图

@implementation NSString (LXDrawing)

- (CGSize)lx_sizeWithBoundingSize:(CGSize)size font:(UIFont *)font
{
    NSParameterAssert(font);
    return CGRectIntegral([self boundingRectWithSize:size
                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                          attributes:@{ NSFontAttributeName : font }
                                             context:nil]).size;
}

@end

#pragma mark - 其他

@implementation NSString (LXOther)

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

@end

NS_ASSUME_NONNULL_END
