//
//  CAShapeLayerTestView.m
//  SubLayersDemo
//
//  Created by KentonYu on 16/5/16.
//  Copyright © 2016年 KentonYu. All rights reserved.
//

#import "CAShapeLayerTestView.h"

@interface CAShapeLayerTestView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, strong) CAShapeLayer *fillRuleShapeLayer;
@property (nonatomic, strong) UIBezierPath *fillRulePath;

@property (nonatomic, strong) CAShapeLayer *dashLineShapeLayer;
@property (nonatomic, strong) UIBezierPath *dashLinePath;

@end

@implementation CAShapeLayerTestView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64.f, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 64.f);
        self.backgroundColor = [UIColor whiteColor];
        [self.layer addSublayer:self.shapeLayer];
        [self.layer addSublayer:self.fillRuleShapeLayer];
        [self.layer addSublayer:self.dashLineShapeLayer];
    }
    return self;
}


#pragma mark Getter

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = ({
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            layer.path        = self.path.CGPath;
            layer.lineWidth   = 2.f;
            layer.strokeColor = [UIColor greenColor].CGColor;
            layer.fillColor   = [UIColor redColor].CGColor;
// strokeStart 绘制起点 strokeEnd 绘制终点  取值是 0-1
            layer.strokeStart = 0;
            layer.strokeEnd   = 0.7f;
// 以下同 UIBezierPath
//            layer.lineCap =
//            layer.lineJoin =
//            当 lineJoin 为 kCALineJoinMiter 时，可以使用 miterLimit 设置最大斜接长度（两条线交汇处内角和外角之间的距离）
//            layer.miterLimit =
            layer;
        });
    }
    return _shapeLayer;
}

- (UIBezierPath *)path {
    if (!_path) {
        _path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 100.f, CGRectGetWidth([UIScreen mainScreen].bounds), 44.f) cornerRadius:22.f];
    }
    return _path;
}

- (UIBezierPath *)fillRulePath {
    if (!_fillRulePath) {
//        这里先绘制哪个 Path 效果一样
        _fillRulePath = [UIBezierPath bezierPathWithRect:CGRectMake(20.f, 200.f, CGRectGetWidth(self.frame)-40.f, 200.f)];
        [_fillRulePath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2.f, 300.f) radius:50.f startAngle:0 endAngle:2*M_PI clockwise:NO]];
    }
    return _fillRulePath;
}

- (CAShapeLayer *)fillRuleShapeLayer {
    if (!_fillRuleShapeLayer) {
        _fillRuleShapeLayer = ({
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            layer.path = self.fillRulePath.CGPath;
//            kCAFillRuleNonZero：默认值，非零规则，当这个点作任意方法的射线，然后看射线和路径的交点方向，选择一个作为基准方向，如果方向一致则加1，方向不一致则减1。为0时，点不在路径内。
//            kCAFillRuleEvenOdd：奇偶规则，当这个点作任意方法的射线，射线和路径的交点数量是奇数则认为点在内部。
            layer.fillRule = kCAFillRuleEvenOdd;
            layer.fillColor = [UIColor yellowColor].CGColor;
            layer;
        });
    }
    return _fillRuleShapeLayer;
}

- (UIBezierPath *)dashLinePath {
    if (!_dashLinePath) {
        _dashLinePath = ({
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(20.f, 180.f)];
            [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) - 20.f, 180.f)];
            path;
        });
    }
    return _dashLinePath;
}

- (CAShapeLayer *)dashLineShapeLayer {
    if (!_dashLineShapeLayer) {
        _dashLineShapeLayer = ({
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            layer.path = self.dashLinePath.CGPath;
            
//            设置虚线显示的起点距离，设置为8，则显示长度8之后的线
            layer.lineDashPhase   = 8;
//            @[@10, @20] (线条长度 + 空白长度 + ....) , 如果数组就一个元素，则间隔跟线条长度相等
            layer.lineDashPattern = @[@10, @20, @30, @60];
            layer.strokeColor = [UIColor greenColor].CGColor;
            layer.lineWidth   = 2.f;
            layer;
        });
    }
    return _dashLineShapeLayer;
}

@end
