//
//  LXMacro.h
//
//  Created by 从今以后 on 15/10/12.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#pragma mark - 功能宏

///------------
/// @name 功能宏
///------------

/// 安全释放指针
#define LXFree(ptr) if (ptr) { free(ptr); ptr = NULL; }

/// 安全执行块
#define LX_BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); }

/// 触发断言
#define LX_FATAL_ERROR() NSAssert(NO, @"fatal error.")

/**
 在 dyld 加载完毕一个 Mach-O 文件(一个可执行文件或者一个库)后，会调用其中标记 LX_CONSTRUCTOR 的函数
 
 若有多个 LX_CONSTRUCTOR 函数且想控制优先级的话，可以写成 __attribute__((constructor(101)))，里面的数字越小优先级越高，1 ~ 100 为系统保留
 */
#define LX_CONSTRUCTOR __attribute__((constructor))
#define LX_CONSTRUCTOR_WITH_PRIORITY(priority) __attribute__((constructor(priority)))

/// 未使用返回值时提示警告
#define LX_UNUSED_RESULT_WARN __attribute__((warn_unused_result))

/// 标志子类继承这个方法时需要调用 super 实现
#define LX_REQUIRES_SUPER __attribute__((objc_requires_super))

/// 标记一个类不能被子类继承
#define LX_FINAL __attribute__((objc_subclassing_restricted))

/// 在退出当前作用域结束时执行块中代码
#define LX_ONEXIT void (^block)(void) __attribute__((cleanup(__LXBlockCleanUp), unused)) = ^
__attribute__((unused)) static void __LXBlockCleanUp(__strong void(^*block)(void)) { (*block)(); }

/// 改变类或协议在运行时的名字
#define LX_RUNTIME_NAME(name) __attribute__((objc_runtime_name(#name)))

/**
 用于 C 函数，可以定义若干个函数名相同，但参数不同的方法，调用时编译器会自动根据参数选择函数原型：

	LX_OVERLOADABLE void logAnything(id obj) {
 NSLog(@"%@", obj);
	}
	LX_OVERLOADABLE void logAnything(int number) {
 NSLog(@"%@", @(number));
	}
	LX_OVERLOADABLE void logAnything(CGRect rect) {
 NSLog(@"%@", NSStringFromCGRect(rect));
	}

	logAnything(233);
	logAnything(@[@"1", @"2"]);
	logAnything(CGRectMake(1, 2, 3, 4));
 */
#define LX_OVERLOADABLE __attribute__((overloadable))

/**
 为 struct 类型或是 union 类型添加 @(...) 语法糖支持，例如：

 typedef struct LX_BOXABLE {
 CGFloat x, y, width, height;
 } LXRect;

 LXRect rect = {1, 2, 3, 4};
 NSValue *value = @(rect);
 */
#define LX_BOXABLE __attribute__((objc_boxable))

#pragma mark - 忽略警告 -

///--------------
/// @name 忽略警告
///--------------

#define STRINGIFY(S) #S

#define LX_DIAGNOSTIC_PUSH_IGNORED(warning) \
\
_Pragma("clang diagnostic push") \
_Pragma(STRINGIFY(clang diagnostic ignored #warning))

#define LX_DIAGNOSTIC_POP _Pragma("clang diagnostic pop")

#pragma mark - 日志打印 -

///--------------
/// @name 日志打印
///--------------

#ifdef DEBUG

#define LXLog(format, ...) \
LX_DIAGNOSTIC_PUSH_IGNORED(-Wformat-security) \
printf("%s at %s:%d %s\n", \
__FUNCTION__, \
(strrchr(__FILE__, '/') ?: __FILE__ - 1) + 1, \
__LINE__, \
[[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String]) \
LX_DIAGNOSTIC_POP

#define LXLogRect(rect)           LXLog(@"%s => %@", #rect, NSStringFromCGRect(rect))
#define LXLogSize(size)           LXLog(@"%s => %@", #size, NSStringFromCGSize(size))
#define LXLogPoint(point)         LXLog(@"%s => %@", #point, NSStringFromCGPoint(point))
#define LXLogRange(range)         LXLog(@"%s => %@", #range, NSStringFromRange(range))
#define LXLogInsets(insets)       LXLog(@"%s => %@", #insets, NSStringFromUIEdgeInsets(insets))
#define LXLogIndexPath(indexPath) LXLog(@"%s => %lu - %lu", #indexPath, [indexPath indexAtPosition:0], [indexPath indexAtPosition:1])

#pragma mark - 计算代码执行耗时 -

///---------------------
/// @name 计算代码执行耗时
///--------------------

#define LX_BENCHMARKING_BEGIN CFTimeInterval lx_begin = CACurrentMediaTime();
#define LX_BENCHMARKING_END   CFTimeInterval lx_end   = CACurrentMediaTime(); printf("运行时间: %g 秒\n", lx_end - lx_begin);

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

#pragma mark - 单例 -

///-----------
/// @name 单例
///-----------

/// 使用 dispatch_once 函数实现，重写了 +allocWithZone:。
#define LX_SINGLETON_INTERFACE(methodName) + (instancetype)methodName;
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
    return [self methodName]; \
}
