//
//  EllipseControl.m
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/12/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//
//Source code largely adapted from TBCircularSlider : https://github.com/ariok/TB_CircularSlider
//

#import "EllipseControl.h"

#define SQR(x) ( (x) * (x) )

@implementation EllipseControl
const int PADDING = 5;
const int knobRadius = 10;
int verticalDiamater;
int horizontalDiameter;
int verticalRadius;
int horizontalRadius;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setOpaque:NO];
        verticalDiamater =self.frame.size.height/2;
        verticalRadius = verticalDiamater/2;
        self.currentAngle=360;
        horizontalDiameter =self.frame.size.width-(PADDING*2);
        horizontalRadius = horizontalDiameter/2;
    }
    return self;
    
}

#pragma mark touch controls
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    CGPoint lastPoint = [touch locationInView:self];
    [self moveKnob:lastPoint];
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
}


#pragma mark rendering

- (void)drawRect:(CGRect)rect {
     CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *arc = [UIBezierPath bezierPathWithOvalInRect:
                         CGRectMake(PADDING,
                                    (self.frame.size.height/2 - self.frame.size.height/4),
                                    horizontalDiameter, verticalDiamater)];
    [[UIColor blackColor] setStroke];
    [arc stroke];
    
    [self drawKnob:ctx];
}

- (void) drawKnob:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    CGPoint knobCenter = [self angleToPoint:self.currentAngle];
    [[UIColor blackColor]set];
    CGContextFillEllipseInRect(ctx, CGRectMake(knobCenter.x, knobCenter.y, knobRadius, knobRadius));
    CGContextRestoreGState(ctx);
}

-(void)moveKnob:(CGPoint)lastPoint{
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2 - PADDING, self.frame.size.height/2 - PADDING);
    float angle = [self angleFromNorth:centerPoint secondPoint:lastPoint flipped:NO];
    int angleInt = floor(angle);
    self.currentAngle = 360 - angleInt;
    //refresh display
    [self setNeedsDisplay];
}

#pragma mark calculations

- (CGPoint) angleToPoint:(int)angle{
    CGPoint result;
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2 - PADDING, self.frame.size.height/2 - PADDING);
    float radians = [self toRadians:-angle];
    result.y = round(centerPoint.y +  verticalRadius * sin(radians)) ;
    result.x = round(centerPoint.x + horizontalRadius * cos(radians));
    NSLog(@"x: %2f , y: %2f",result.x, result.y);
    return result;
}

-(float) toRadians:(int)degree{
    return ((M_PI* (degree))/180);
}

-(float) toDegree:(float)radians{
    return ((180 * (radians))/M_PI);
}

- (float) angleFromNorth:(CGPoint) p1 secondPoint:(CGPoint)p2 flipped:(BOOL)flipped {
    CGPoint v = CGPointMake(p2.x-p1.x,p2.y-p1.y);
    float vmag = sqrt(SQR(v.x) + SQR(v.y)), result = 0;
    v.x /= vmag;
    v.y /= vmag;
    double radians = atan2(v.y,v.x);
    result = [self toDegree:radians];
    return (result >=0 ? result : result + 360.0);
}

@end
