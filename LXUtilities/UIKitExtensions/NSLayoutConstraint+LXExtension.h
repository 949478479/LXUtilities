#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (LXExtension)

/**
 从约束体系中移除自身，创建并激活一个新约束，新约束所有属性和原约束一致（除了 multiplier 属性）

 @param multiplier 新的比例
 @return           新创建并激活的约束
 */
- (instancetype)lx_updateMultiplier:(CGFloat)multiplier NS_AVAILABLE(10_10, 8_0);

@end
 
