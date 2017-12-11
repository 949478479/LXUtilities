//
//  UILabel+LXExtension.m
//
//  Created by 从今以后 on 16/6/30.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "NSAttributedString+LXExtension.h"
#import "NSString+LXExtension.h"
#import "NSObject+LXExtension.h"
#import "UILabel+LXExtension.h"

@implementation UILabel (LXExtension)

+ (void)load {
    [self lx_exchangeMethodWithOriginalSelector:@selector(intrinsicContentSize) swizzledSelector:@selector(lx_intrinsicContentSize)];
}

- (BOOL)lx_hasText {
    return self.text.length > 0;
}

- (void)setLayerColor:(UIColor *)layerColor {
	self.layer.backgroundColor = layerColor.CGColor;
}

- (UIColor *)layerColor {
	return [UIColor colorWithCGColor:self.layer.backgroundColor];
}

- (void)setAdditionalContentSize:(CGSize)additionalContentSize {
    [self lx_setRetainAssociatedValue:[NSValue valueWithCGSize:additionalContentSize]
                               forKey:@selector(lx_additionalContentSize)];
}

- (CGSize)lx_additionalContentSize {
    return [[self lx_associatedValueForKey:_cmd] CGSizeValue];
}

- (CGSize)lx_intrinsicContentSize
{
    CGSize size = [self lx_intrinsicContentSize];
    CGSize additionalSize = [self lx_additionalContentSize];
    size.width += additionalSize.width;
    size.height += additionalSize.height;
    return size;
}

@end

#pragma mark - 触摸识别

static char _KVOContext;

@interface _KVOObserver : NSObject
@property (nonatomic, unsafe_unretained) UILabel *label;
@end

NS_INLINE NSAttributedString *_LXGetAttributedTextFromLabel(UILabel *label)
{
    NSMutableAttributedString *attributedText = label.attributedText.mutableCopy;
    NSLineBreakMode lineBreakMode = (label.numberOfLines == 0 ? NSLineBreakByWordWrapping : label.lineBreakMode);
    [attributedText enumerateAttribute:NSParagraphStyleAttributeName
                               inRange:LXMaxRange(attributedText)
                               options:kNilOptions
                            usingBlock:^(NSMutableParagraphStyle *style, NSRange range, BOOL * _Nonnull stop) {
                                style.lineBreakMode = lineBreakMode;
                            }];
    return attributedText;
}

@implementation UILabel (LXTouchExtension)

- (void)lx_refreshTextView {
    [self lx_setRetainAssociatedValue:nil forKey:@selector(lx_textView)];
}

- (UITextView *)lx_textView
{
    UITextView *textView = [self lx_associatedValueForKey:_cmd];
    if (!textView) {
        textView = [[UITextView alloc] initWithFrame:self.frame];
        textView.textContainer.maximumNumberOfLines = self.numberOfLines;
        textView.textContainerInset = UIEdgeInsetsZero;
        textView.textContainer.lineFragmentPadding = 0;
        textView.scrollEnabled = NO;
        textView.editable = NO;
        textView.attributedText = _LXGetAttributedTextFromLabel(self);
        [self lx_setRetainAssociatedValue:textView forKey:_cmd];

        _KVOObserver *observer = [_KVOObserver new];
        observer.label = self;
        [self addObserver:observer forKeyPath:@"text" options:kNilOptions context:&_KVOContext];
        [self addObserver:observer forKeyPath:@"frame" options:kNilOptions context:&_KVOContext];
        [self addObserver:observer forKeyPath:@"bounds" options:kNilOptions context:&_KVOContext];
        [self addObserver:observer forKeyPath:@"numberOfLines" options:kNilOptions context:&_KVOContext];
        [self addObserver:observer forKeyPath:@"attributedText" options:kNilOptions context:&_KVOContext];
        [self lx_setRetainAssociatedValue:observer forKey:&_KVOContext];
    }
    return textView;
}

- (NSArray<NSValue *> *)lx_rectsForCharacterRange:(NSRange)range
{
    UITextView *textView = [self lx_textView];
    NSMutableArray *rects = [NSMutableArray new];
    NSRange glyphRange = [textView.layoutManager glyphRangeForCharacterRange:range actualCharacterRange:NULL];
    [textView.layoutManager enumerateEnclosingRectsForGlyphRange:glyphRange
                                        withinSelectedGlyphRange:NSMakeRange(NSNotFound, 0)
                                                 inTextContainer:textView.textContainer
                                                      usingBlock:^(CGRect rect, BOOL * _Nonnull stop) {
                                                          [rects addObject:[NSValue valueWithCGRect:rect]];
                                                      }];
    return rects;
}

- (NSUInteger)lx_characterIndexForPoint:(CGPoint)point
{
    UITextView *textView = [self lx_textView];
    return [textView.layoutManager characterIndexForPoint:point
                                          inTextContainer:textView.textContainer
                 fractionOfDistanceBetweenInsertionPoints:NULL];
}

@end

@implementation _KVOObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context != &_KVOContext) {
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
    UILabel *label = object;
    UITextView *textView = [label lx_textView];
    
    if ([keyPath isEqualToString:@"bounds"]) {
        textView.bounds = label.bounds;
    } else if ([keyPath isEqualToString:@"frame"]) {
        textView.frame = label.frame;
    } else if ([keyPath isEqualToString:@"text"]) {
        textView.text = label.text;
    } else if ([keyPath isEqualToString:@"attributedText"]) {
        textView.attributedText = _LXGetAttributedTextFromLabel(label);
    } else if ([keyPath isEqualToString:@"numberOfLines"]) {
        textView.textContainer.maximumNumberOfLines = label.numberOfLines;
    }
}

- (void)dealloc
{
    [_label removeObserver:self forKeyPath:@"text"];
    [_label removeObserver:self forKeyPath:@"frame"];
    [_label removeObserver:self forKeyPath:@"bounds"];
    [_label removeObserver:self forKeyPath:@"numberOfLines"];
    [_label removeObserver:self forKeyPath:@"attributedText"];
}

@end
