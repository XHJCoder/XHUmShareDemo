//
//  XHCustomShareView.m
//  XHUmShareDemo
//
//  Created by huahua on 16/4/12.
//  Copyright © 2016年 jxh. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView(Additions)


- (void)setSize:(CGSize)size;
{
    CGPoint origin = [self frame].origin;
    
    [self setFrame:CGRectMake(origin.x, origin.y, size.width, size.height)];
}

- (CGSize)size;
{
    return [self frame].size;
}

- (CGFloat)left;
{
    return CGRectGetMinX([self frame]);
}

- (void)setLeft:(CGFloat)x;
{
    CGRect frame = [self frame];
    frame.origin.x = x;
    [self setFrame:frame];
}

- (CGFloat)top;
{
    return CGRectGetMinY([self frame]);
}

- (void)setTop:(CGFloat)y;
{
    CGRect frame = [self frame];
    frame.origin.y = y;
    [self setFrame:frame];
}

- (CGFloat)right;
{
    return CGRectGetMaxX([self frame]);
}

- (void)setRight:(CGFloat)right;
{
    CGRect frame = [self frame];
    frame.origin.x = right - frame.size.width;
    
    [self setFrame:frame];
}

- (CGFloat)bottom;
{
    return CGRectGetMaxY([self frame]);
}

- (void)setBottom:(CGFloat)bottom;
{
    CGRect frame = [self frame];
    frame.origin.y = bottom - frame.size.height;
    
    [self setFrame:frame];
}

- (CGFloat)centerX;
{
    return [self center].x;
}

- (void)setCenterX:(CGFloat)centerX;
{
    [self setCenter:CGPointMake(centerX, self.center.y)];
}

- (CGFloat)centerY;
{
    return [self center].y;
}

- (void)setCenterY:(CGFloat)centerY;
{
    [self setCenter:CGPointMake(self.center.x, centerY)];
}

- (CGFloat)width;
{
    return CGRectGetWidth([self frame]);
}

- (void)setWidth:(CGFloat)width;
{
    CGRect frame = [self frame];
    frame.size.width = width;
    [self setFrame:CGRectStandardize(frame)];
}

- (CGFloat)height;
{
    return CGRectGetHeight([self frame]);
}

- (void)setHeight:(CGFloat)height;
{
    CGRect frame = [self frame];
    frame.size.height = height;
	
    [self setFrame:CGRectStandardize(frame)];
}


+(id)getView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject]; 
}

- (UIViewController *)superviewcontroller
{
    UIViewController * controller = nil;
    
    id next = [self nextResponder];
    
    while (![next isKindOfClass:[UIViewController class]])
    {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[UIViewController class]])
    {
        controller = (UIViewController *)next;
    }
    return controller;
}


#pragma mark - Border radius

/**
 *  @brief 设置圆角
 *
 *  @param cornerRadius 圆角半径
 */
- (void)rounded:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

/**
 *  @brief 设置圆角和边框
 *
 *  @param cornerRadius 圆角半径
 *  @param borderWidth  边框宽度
 *  @param borderColor  边框颜色
 */
- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.masksToBounds = YES;
}

/**
 *  @brief 设置边框
 *
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor
{
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.masksToBounds = YES;
}

#pragma mark - 更新约束
-(void)updateViewContraint:(NSLayoutAttribute)attribute value:(CGFloat)value{
    NSArray* constrains = self.constraints;
    for (NSLayoutConstraint* constraint in constrains) {
        if (constraint.firstAttribute == attribute) {
            constraint.constant = value;
        }
    }
}

@end
