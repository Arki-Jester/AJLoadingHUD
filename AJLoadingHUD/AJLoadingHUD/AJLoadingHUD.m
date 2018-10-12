//
//  AJLoadingHUD.m
//  AJLoadingHUD
//
//  Created by Arki-J on 2018/10/12.
//  Copyright © 2018 Arki-J. All rights reserved.
//
#define ThemeColor [UIColor colorWithRed:16/255.0 green:142/255.0 blue:233/255.0 alpha:1]
#define SpeedRate 0.6/60.0f

#import "AJLoadingHUD.h"
static CGFloat lineWidth = 3.0f;
@implementation AJLoadingHUD
{
    CGFloat _progress;
    UIView *_lineView;
    CAShapeLayer *_topLayer;
    CAShapeLayer *_bottomLayer;
    CGFloat _topStartAngle;
    CGFloat _topEndAngle;
    
    CGFloat _bottomStartAngle;
    CGFloat _bottomEndAngle;
    CADisplayLink *_link;
    
    BOOL _isMinus;
}

+(AJLoadingHUD*)showIn:(UIView*)view{
    [self hideIn:view];
    AJLoadingHUD *hud = [[AJLoadingHUD alloc] initWithFrame:view.bounds];
    [hud start];
    [view addSubview:hud];
    return hud;
}
+(AJLoadingHUD *)hideIn:(UIView *)view{
    AJLoadingHUD *hud = nil;
    for (AJLoadingHUD *subView in view.subviews) {
        if ([subView isKindOfClass:[AJLoadingHUD class]]) {
            [subView hide];
            [subView removeFromSuperview];
            hud = subView;
        }
    }
    return hud;
}
-(void)start{
    _link.paused = false;
}
-(void)hide{
    _link.paused = true;
    _progress = 0;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    _topLayer = [CAShapeLayer layer];
    _topLayer.bounds = CGRectMake(0, 0, 60, 60);
    _topLayer.position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0);
    _topLayer.fillColor = [UIColor clearColor].CGColor;
    _topLayer.strokeColor = ThemeColor.CGColor;
    _topLayer.lineWidth = lineWidth;
    _topLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_topLayer];
    
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayAction)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _link.paused = true;
    
    
    _bottomLayer = [CAShapeLayer layer];
    _bottomLayer.bounds = CGRectMake(0, 0, 60, 60);
    _bottomLayer.position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0);
    _bottomLayer.fillColor = [UIColor clearColor].CGColor;
    _bottomLayer.strokeColor = ThemeColor.CGColor;
    _bottomLayer.lineWidth = lineWidth;
    _bottomLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_bottomLayer];
    
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    _lineView.bounds = CGRectMake(0, 0, 0, lineWidth);
    _lineView.center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0);
    _lineView.backgroundColor = ThemeColor;
    _lineView.layer.cornerRadius = lineWidth/2;
    [self addSubview:_lineView];
    
    UIView *pointView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    pointView.bounds = CGRectMake(0, 0, lineWidth, lineWidth);
    pointView.center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0);
    pointView.backgroundColor = [UIColor whiteColor];
    pointView.layer.cornerRadius = lineWidth/2;
    [self addSubview:pointView];
}

-(void)displayAction{
    if (!_isMinus) {
        _progress += SpeedRate;
    }else{
        _progress -= SpeedRate;
    }
    
    if (_progress > 1) {
        _isMinus = YES;
    }else if(_progress<0){
        _progress = 0;
        _isMinus = NO;
    }
    [self updateLayerAnimation];
}
-(void)updateLayerAnimation{
    
    _lineView.frame = CGRectMake(0, 0, _progress*130, lineWidth);
    _lineView.center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0);
    
    if (!_isMinus) {
        _topStartAngle = M_PI;
        _topEndAngle = M_PI +_progress * M_PI;
        
        _bottomStartAngle = 0;
        _bottomEndAngle = _progress * M_PI;
    }else{
        CGFloat progress1 = (1 - _progress);
        _topEndAngle = M_PI*2;
        _topStartAngle = M_PI + progress1 * M_PI;
        
        _bottomStartAngle = progress1*M_PI;
        _bottomEndAngle = M_PI;
    }
    
    CGFloat radius = _topLayer.bounds.size.width/2.0f - lineWidth/2.0f;
    CGFloat centerX = _topLayer.bounds.size.width/2.0f;
    CGFloat centerY = _topLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:_topStartAngle endAngle:_topEndAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    _topLayer.path = path.CGPath;
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:_bottomStartAngle endAngle:_bottomEndAngle clockwise:YES];
    path2.lineCapStyle = kCGLineCapRound;
    _bottomLayer.path = path2.CGPath;
}
@end
