//
//  LXMacro.h
//
//  Created by 从今以后 on 15/10/12.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#pragma mark - 执行 block 的宏 -

#define LX_BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

#pragma mark - 忽略警告宏 -

///----------------
/// @name 忽略警告宏
///----------------

#define STRINGIFY(S) #S

#define LX_DIAGNOSTIC_IGNORED(warning) _Pragma(STRINGIFY(clang diagnostic ignored #warning))

#define LX_DIAGNOSTIC_PUSH _Pragma("clang diagnostic push")

#define LX_DIAGNOSTIC_POP _Pragma("clang diagnostic pop")

#define LX_DIAGNOSTIC_PUSH_IGNORED(warning) \
LX_DIAGNOSTIC_PUSH \
LX_DIAGNOSTIC_IGNORED(warning) \

#pragma mark - LOG 宏 -

///-------------
/// @name LOG 宏
///-------------

#ifdef DEBUG

/**
 *  附带 文件名、行号、函数名的 LOG 宏。
 */

#define LX_FORMAT_WARNING -Wcstring-format-directive

#define LXLog(format, ...) \
LX_DIAGNOSTIC_PUSH_IGNORED(LX_FORMAT_WARNING) \
NSLog(@"[%@ : %d] %s\n\n%@\n\n", \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
__LINE__, \
__FUNCTION__, \
[NSString stringWithFormat:(format), ##__VA_ARGS__]) \
LX_DIAGNOSTIC_POP

/**
 *  打印 CGRect。
 */
#define LXLogRect(rect) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wcstring-format-directive\"") \
LXLog(@"%s => %@", #rect, NSStringFromCGRect(rect)) \
_Pragma("clang diagnostic pop")

/**
 *  打印 CGSize。
 */
#define LXLogSize(size) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wcstring-format-directive\"") \
LXLog(@"%s => %@", #size, NSStringFromCGSize(size)) \
_Pragma("clang diagnostic pop")

/**
 *  打印 CGPoint。
 */
#define LXLogPoint(point) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wcstring-format-directive\"") \
LXLog(@"%s => %@", #point, NSStringFromCGPoint(point)) \
_Pragma("clang diagnostic pop")

/**
 *  打印 NSRange。
 */
#define LXLogRange(range) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wcstring-format-directive\"") \
LXLog(@"%s => %@", #range, NSStringFromRange(range)) \
_Pragma("clang diagnostic pop")

/**
 *  打印 UIEdgeInsets。
 */
#define LXLogInsets(insets) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wcstring-format-directive\"") \
LXLog(@"%s => %@", #insets, NSStringFromUIEdgeInsets(insets)) \
_Pragma("clang diagnostic pop")

/**
 *  打印 NSIndexPath。
 */
#define LXLogIndexPath(indexPath) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wcstring-format-directive\"") \
LXLog(@"%s => %lu - %lu", #indexPath, [indexPath indexAtPosition:0], [indexPath indexAtPosition:1]) \
_Pragma("clang diagnostic pop")

#pragma mark - 调试宏 -

///------------
/// @name 调试宏
///------------

#define LX_BENCHMARKING_BEGIN CFTimeInterval begin = CACurrentMediaTime();
#define LX_BENCHMARKING_END   CFTimeInterval end   = CACurrentMediaTime(); printf("运行时间: %g 秒\n", end - begin);

#pragma mark -

#else

#define LXLog(format, ...)
#define LXLogRect(rect)
#define LXLogSize(size)
#define LXLogPoint(point)
#define LXLogRange(range)
#define LXLogInsets(insets)
#define LXLogIndexPath(indexPath)

#define LX_BENCHMARKING_BEGIN
#define LX_BENCHMARKING_END

#endif

#pragma mark - 单例宏 -

///------------
/// @name 单例宏
///------------

/**
 *  生成单例接口的宏。
 *
 *  单例使用 dispatch_once 函数实现,禁用了 +allocWithZone: 和 -copyWithZone: 方法。
 *
 *  @param methodName 单例方法名。
 */
#define LX_SINGLETON_INTERFACE(methodName) + (instancetype)methodName;

/**
 *  生成单例实现的宏。
 */
#define LX_SINGLETON_IMPLEMENTTATION(methodName) \
\
+ (instancetype)methodName \
{ \
static id sharedInstance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
sharedInstance = [[super allocWithZone:NULL] init]; \
}); \
return sharedInstance; \
} \
\
+ (instancetype)allocWithZone:(__unused struct _NSZone *)zone \
{ \
NSAssert(NO, @"使用单例方法直接获取单例~"); \
return [self methodName]; \
} \
\
- (id)copyWithZone:(__unused NSZone *)zone \
{ \
NSAssert(NO, @"使用单例方法直接获取单例~"); \
return self; \
}
