//
//  FSLineChart.m
//  FSLineChart
//
//  Created by Zhaoxiaoyun on 16/11/2014.
//  Copyright (c) 2014 Arthur GUIBERT. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "FSLineChart.h"
#import "UIColor+FSPalette.h"

@interface FSLineChart ()

@property (nonatomic, strong) NSMutableArray* data;

@property (nonatomic) CGFloat min;
@property (nonatomic) CGFloat max;
@property (nonatomic) CGMutablePathRef initialPath;
@property (nonatomic) CGMutablePathRef newPath;

@end

@implementation FSLineChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setDefaultParameters];
    }
    return self;
}

- (void)setChartData:(NSArray *)chartData start:(NSString*)hour
{
    _data = [NSMutableArray arrayWithArray:chartData];
    timeStart=hour;
    hourStart=[[hour substringWithRange:NSMakeRange(11,2)] intValue]+2;
    
    [self computeBounds];
    
    CGFloat minBound = MIN(_min, 0);
    CGFloat maxBound = MAX(_max, 0);
    NSString *txt=@"";
    // No data
    if(isnan(_max)) {
        _max = 1;
    }
    
    [self strokeChart];
    
    float max=0;
    for(int i=0;i<_data.count;i++){
        if([_data[i] floatValue]>max){
            max=[_data[i] floatValue];
        }
    }
    if(_labelForValue) {
        for(int i=0;i<_verticalGridStep;i++) {
            CGPoint p = CGPointMake(_margin + (_valueLabelPosition == ValueLabelRight ? _axisWidth : 0), _axisHeight + _margin - (i + 1) * _axisHeight / _verticalGridStep);
            
            NSString* text = _labelForValue(minBound + (maxBound - minBound) / _verticalGridStep * (i + 1));
            
            if(!text)
                continue;
            
            CGRect rect = CGRectMake(_margin, p.y + 2, self.frame.size.width - _margin * 2 - 4.0f, 14);
            
            float width =
            [text
             boundingRectWithSize:rect.size
             options:NSStringDrawingUsesLineFragmentOrigin
             attributes:@{ NSFontAttributeName:_valueLabelFont }
             context:nil]
            .size.width;
            
            NSLog(@"%@！！",text);
            if([text floatValue]<0.1){
                text=@"";
                if(i== _verticalGridStep-1){
                    text=[self decimalwithFormat:@"0.00" floatV:max];
                }
            }
            if([txt isEqualToString:text]){
                text=@"";
            }
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - width - 8, p.y + 2, width + 30, 14)];
            label.text = text;
            label.font = _valueLabelFont;
            label.textColor = _valueLabelTextColor;
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = _valueLabelBackgroundColor;
            txt=text;
            NSLog(@"%@~~%@",text,[self decimalwithFormat:@"0.00" floatV:max]);
            [self addSubview:label];
        }
    }
    
    if(_labelForIndex) {
        float scale = 1.0f;
        int q = (int)_data.count / _horizontalGridStep;
        scale = (CGFloat)(q * _horizontalGridStep) / (CGFloat)(_data.count - 1);
        
        for(int i=0;i<_horizontalGridStep + 3;i++) {
            NSInteger itemIndex = q * i;
            
            itemIndex=itemIndex-24+hourStart;
            if(itemIndex<0){
                itemIndex+=24;
            }
            if(itemIndex >= _data.count)
            {
                itemIndex = _data.count - 1;
            }
            
            
            NSString* text = _labelForIndex(itemIndex);
            // NSLog(@"8888 %@",text);
            if(!text)
                continue;
            
            CGPoint p = CGPointMake(_margin + i * (_axisWidth / _horizontalGridStep) * scale, _axisHeight + _margin);
            // NSLog(@"8888 %f,   %f",p.x,p.y);
            CGRect rect = CGRectMake(_margin, p.y + 2, self.frame.size.width - _margin * 2 - 4.0f, 14);
            
            float width =
            [text
             boundingRectWithSize:rect.size
             options:NSStringDrawingUsesLineFragmentOrigin
             attributes:@{ NSFontAttributeName:_indexLabelFont }
             context:nil]
            .size.width;
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - 4.0f, p.y + 2, width + 2, 14)];
            label.text = text;
            label.font = _indexLabelFont;
            label.textColor = _indexLabelTextColor;
            label.backgroundColor = _indexLabelBackgroundColor;
            
            [self addSubview:label];
            
        }
    }
    
    [self setNeedsDisplay];
}
- (NSString *) decimalwithFormat:(NSString *)format floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}

- (void)drawRect:(CGRect)rect
{
    [self drawGrid];
}

- (void)drawGrid
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(ctx);
    CGContextSetLineWidth(ctx, _axisLineWidth);
    CGContextSetStrokeColorWithColor(ctx, [_axisColor CGColor]);
    
    // draw coordinate axis
    CGContextMoveToPoint(ctx, _margin, _margin);
    CGContextAddLineToPoint(ctx, _margin, _axisHeight + _margin + 3);
    CGContextStrokePath(ctx);
    
    //CGContextMoveToPoint(ctx, _margin, _axisHeight + _margin);
    //CGContextAddLineToPoint(ctx, _axisWidth + _margin, _axisHeight + _margin);
    //CGContextStrokePath(ctx);
    
    float scale = 1.0f;
    int q = (int)_data.count / _horizontalGridStep;
    scale = (CGFloat)(q * _horizontalGridStep) / (CGFloat)(_data.count - 1);
    
    
    CGFloat minBound = MIN(_min, 0);
    CGFloat maxBound = MAX(_max, 0);
    
    // draw grid
    if(_drawInnerGrid) {
        for(int i=0;i<_horizontalGridStep;i++) {
            CGContextSetStrokeColorWithColor(ctx, [_innerGridColor CGColor]);
            CGContextSetLineWidth(ctx, _innerGridLineWidth);
            
            CGPoint point = CGPointMake((1 + i) * _axisWidth / _horizontalGridStep * scale + _margin, _margin);
            
            CGContextMoveToPoint(ctx, point.x, point.y);
            CGContextAddLineToPoint(ctx, point.x, _axisHeight + _margin);
            CGContextStrokePath(ctx);
            
            CGContextSetStrokeColorWithColor(ctx, [_axisColor CGColor]);
            CGContextSetLineWidth(ctx, _axisLineWidth);
            CGContextMoveToPoint(ctx, point.x - 0.5f, _axisHeight + _margin);
            CGContextAddLineToPoint(ctx, point.x - 0.5f, _axisHeight + _margin + 3);
            CGContextStrokePath(ctx);
        }
        
        for(int i=0;i<_verticalGridStep + 1;i++) {
            // If the value is zero then we display the horizontal axis
            CGFloat v = maxBound - (maxBound - minBound) / _verticalGridStep * i;
            
            if(v == 0) {
                CGContextSetLineWidth(ctx, _axisLineWidth);
                CGContextSetStrokeColorWithColor(ctx, [_axisColor CGColor]);
            } else {
                CGContextSetStrokeColorWithColor(ctx, [_innerGridColor CGColor]);
                CGContextSetLineWidth(ctx, _innerGridLineWidth);
            }
            
            CGPoint point = CGPointMake(_margin, (i) * _axisHeight / _verticalGridStep + _margin);
            
            CGContextMoveToPoint(ctx, point.x, point.y);
            CGContextAddLineToPoint(ctx, _axisWidth + _margin, point.y);
            CGContextStrokePath(ctx);
        }
    }
    
}

- (void)strokeChart
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    UIBezierPath *noPath = [UIBezierPath bezierPath];
    UIBezierPath* fill = [UIBezierPath bezierPath];
    UIBezierPath* noFill = [UIBezierPath bezierPath];
    
    
    CGFloat minBound = MIN(_min, 0);
    CGFloat maxBound = MAX(_max, 0);
    
    CGFloat scale = _axisHeight / (maxBound - minBound);
    
    noPath = [self getLinePath:0 withSmoothing:_bezierSmoothing close:NO ];
    path = [self getLinePath:scale withSmoothing:_bezierSmoothing close:NO];
    
    noFill = [self getLinePath:0 withSmoothing:_bezierSmoothing close:YES];
    fill = [self getLinePath:scale withSmoothing:_bezierSmoothing close:YES];
    
    if(_fillColor) {
        CAShapeLayer *fillLayer = [CAShapeLayer layer];
        fillLayer.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y + minBound * scale, self.bounds.size.width, self.bounds.size.height);
        fillLayer.bounds = self.bounds;
        fillLayer.path = fill.CGPath;
        fillLayer.strokeColor = nil;
        fillLayer.fillColor = _fillColor.CGColor;
        fillLayer.lineWidth = 0;
        fillLayer.lineJoin = kCALineJoinRound;
        
        [self.layer addSublayer:fillLayer];
        
        CABasicAnimation *fillAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        fillAnimation.duration = _animationDuration;
        fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        fillAnimation.fillMode = kCAFillModeForwards;
        fillAnimation.fromValue = (id)noFill.CGPath;
        fillAnimation.toValue = (id)fill.CGPath;
        [fillLayer addAnimation:fillAnimation forKey:@"path"];
    }
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y + minBound * scale, self.bounds.size.width, self.bounds.size.height);
    pathLayer.bounds = self.bounds;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [_color CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = _lineWidth;
    pathLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:pathLayer];
    
    if(_fillColor) {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnimation.duration = _animationDuration;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = (__bridge id)(noPath.CGPath);
        pathAnimation.toValue = (__bridge id)(path.CGPath);
        [pathLayer addAnimation:pathAnimation forKey:@"path"];
    } else {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = _animationDuration;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        [pathLayer addAnimation:pathAnimation forKey:@"path"];
    }
    
}

- (void)setDefaultParameters
{
    _color = [UIColor fsLightBlue];
    _fillColor = [_color colorWithAlphaComponent:0.25];
    _verticalGridStep = 3;
    _horizontalGridStep = 3;
    _margin = 5.0f;
    _axisWidth = self.frame.size.width - 2 * _margin;
    _axisHeight = self.frame.size.height - 2 * _margin;
    _axisColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    _innerGridColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    _drawInnerGrid = YES;
    _bezierSmoothing = NO;
    _bezierSmoothingTension = 0.2;
    _lineWidth = 1;
    _innerGridLineWidth = 0.5;
    _axisLineWidth = 1;
    _animationDuration = 0.5;
    
    // Labels attributes
    _indexLabelBackgroundColor = [UIColor clearColor];
    _indexLabelTextColor = [UIColor grayColor];
    _indexLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    
    _valueLabelBackgroundColor = [UIColor colorWithWhite:1 alpha:0.75];
    _valueLabelTextColor = [UIColor grayColor];
    _valueLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    _valueLabelPosition = ValueLabelRight;
}

- (void)computeBounds
{
    _min = MAXFLOAT;
    _max = -MAXFLOAT;
    
    for(int i=0;i<_data.count;i++) {
        NSNumber* number = _data[i];
        if([number floatValue] < _min)
            _min = [number floatValue];
        
        if([number floatValue] > _max)
            _max = [number floatValue];
    }
    
    // The idea is to adjust the minimun and the maximum value to display the whole chart in the view, and if possible with nice "round" steps.
    _max = [self getUpperRoundNumber:_max forGridStep:_verticalGridStep];
    
    if(_min < 0) {
        // If the minimum is negative then we want to have one of the step to be zero so that the chart is displayed nicely and more comprehensively
        float step;
        
        if(_verticalGridStep > 3) {
            step = fabs(_max - _min) / (float)(_verticalGridStep - 1);
        } else {
            step = MAX(fabs(_max - _min) / 2, MAX(fabs(_min), fabs(_max)));
        }
        
        step = [self getUpperRoundNumber:step forGridStep:_verticalGridStep];
        
        float newMin,newMax;
        
        if(fabs(_min) > fabs(_max)) {
            int m = ceilf(fabs(_min) / step);
            
            newMin = step * m * (_min > 0 ? 1 : -1);
            newMax = step * (_verticalGridStep - m) * (_max > 0 ? 1 : -1);
            
        } else {
            int m = ceilf(fabs(_max) / step);
            
            newMax = step * m * (_max > 0 ? 1 : -1);
            newMin = step * (_verticalGridStep - m) * (_min > 0 ? 1 : -1);
        }
        
        if(_min < newMin) {
            newMin -= step;
            newMax -=  step;
        }
        
        if(_max > newMax + step) {
            newMin += step;
            newMax +=  step;
        }
        
        
        _min = newMin;
        _max = newMax;
    }
}

- (CGFloat)getUpperRoundNumber:(CGFloat)value forGridStep:(int)gridStep
{
    if(value < 0)
        return 0;
    
    // We consider a round number the following by 0.5 step instead of true round number (with step of 1)
    CGFloat logValue = log10f(value);
    CGFloat scale = powf(10, floorf(logValue));
    CGFloat n = ceilf(value / scale * 4);
    
    int tmp = (int)(n) % gridStep;
    
    if(tmp != 0) {
        n += gridStep - tmp;
    }
    
    return n * scale / 4.0f;
}

- (void)setGridStep:(int)gridStep
{
    _verticalGridStep = gridStep;
    _horizontalGridStep = gridStep;
}

- (CGPoint)getPointForIndex:(NSInteger)idx withScale:(CGFloat)scale
{
    if(idx < 0 || idx >= _data.count)
        return CGPointZero;
    
    // Compute the point in the view from the data with a set scale
    NSNumber* number = _data[idx];
    return CGPointMake(_margin + idx * (_axisWidth / (_data.count - 1)), _axisHeight + _margin - [number floatValue] * scale);
}

- (UIBezierPath*)getLinePath:(float)scale withSmoothing:(BOOL)smoothed close:(BOOL)closed
{
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    if(smoothed) {
        for(int i=0;i<_data.count - 1;i++) {
            CGPoint controlPoint[2];
            CGPoint p = [self getPointForIndex:i withScale:scale];
            
            NSString *type=[[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
            if([type isEqualToString:@"spm"]){
                //坐标点点击事件,大于150的可查看视频
                if([_data[i] floatValue]>150){
                    CGPoint point = p;
                    if(p.y<270){
                        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                        btn.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.5];
                        btn.tag = i;
                        btn.frame = CGRectMake(point.x - 10, point.y - 10, 20, 20);
                        btn.layer.cornerRadius =20/2.0;
                        btn.layer.masksToBounds = 20/2.0;
                        [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
                        [self addSubview:btn];
                    }
                }
            }
            
            // Start the path drawing
            if(i == 0)
                [path moveToPoint:p];
            
            CGPoint nextPoint, previousPoint, m;
            
            // First control point
            nextPoint = [self getPointForIndex:i + 1 withScale:scale];
            previousPoint = [self getPointForIndex:i - 1 withScale:scale];
            m = CGPointZero;
            
            if(i > 0) {
                m.x = (nextPoint.x - previousPoint.x) / 2;
                m.y = (nextPoint.y - previousPoint.y) / 2;
            } else {
                m.x = (nextPoint.x - p.x) / 2;
                m.y = (nextPoint.y - p.y) / 2;
            }
            
            controlPoint[0].x = p.x + m.x * _bezierSmoothingTension;
            controlPoint[0].y = p.y + m.y * _bezierSmoothingTension;
            
            // Second control point
            nextPoint = [self getPointForIndex:i + 2 withScale:scale];
            previousPoint = [self getPointForIndex:i withScale:scale];
            p = [self getPointForIndex:i + 1 withScale:scale];
            m = CGPointZero;
            
            if(i < _data.count - 2) {
                m.x = (nextPoint.x - previousPoint.x) / 2;
                m.y = (nextPoint.y - previousPoint.y) / 2;
            } else {
                m.x = (p.x - previousPoint.x) / 2;
                m.y = (p.y - previousPoint.y) / 2;
            }
            
            controlPoint[1].x = p.x - m.x * _bezierSmoothingTension;
            controlPoint[1].y = p.y - m.y * _bezierSmoothingTension;
            
            [path addCurveToPoint:p controlPoint1:controlPoint[0] controlPoint2:controlPoint[1]];
        }
        
    } else {
        for(int i=0;i<_data.count;i++) {
            if(i > 0) {
                [path addLineToPoint:[self getPointForIndex:i withScale:scale]];
            } else {
                [path moveToPoint:[self getPointForIndex:i withScale:scale]];
            }
        }
    }
    
    if(closed) {
        // Closing the path for the fill drawing
        [path addLineToPoint:[self getPointForIndex:_data.count - 1 withScale:scale]];
        [path addLineToPoint:[self getPointForIndex:_data.count - 1 withScale:0]];
        [path addLineToPoint:[self getPointForIndex:0 withScale:0]];
        [path addLineToPoint:[self getPointForIndex:0 withScale:scale]];
    }
    
    return path;
}
- (void)clicked:(id)sender
{
    @try {
        int hour=hourStart+(int)[sender tag];
        if(hour>=24){
            NSString *dateString =[timeStart substringToIndex:10];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [formatter dateFromString:dateString];
            NSDate *tomorrow = [NSDate dateWithTimeInterval:60 * 60 * 24 sinceDate:date];
            
            clickTime=[[formatter stringFromDate:tomorrow] stringByAppendingFormat:@" %02d",hour-24];
        }
        else{
            clickTime=[[timeStart substringToIndex:11] stringByAppendingFormat:@"%d",hour];
        }
        [self getClickTime];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getDate" object:[self getClickTime]];
        
    }
    @catch (NSException *exception) {
        NSLog(@"plotting label is not available for this point");
    }
}

//获取点击坐标的时间
-(NSDate*)getClickTime{
    //显示格式：yyyy-mm-dd hh
    //  NSLog(@"choose time:%@",clickTime);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[clickTime stringByAppendingString:@":00:00"]];
    NSTimeInterval  interval =8*60*60;
    date = [date initWithTimeInterval:interval sinceDate:date];
    //显示格式：yyyy-mm-dd HH:mm:ss
    //NSLog(@"choose date:%@", date);
    return date;
}

@end