//
//  SPFCircularCAShapeLayer.m
//  Leumi
//
//  Created by Reinier Melian on 09/10/15.
//  Copyright (c) 2016 Strands Inc. All rights reserved.
//

#import "CircularCAShapeLayer.h"


@implementation CircularCAShapeLayer

//Angle Macros
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )

@synthesize radius,startDegreeAngle,amountOfDegreeValue,xOffSet,yOffSet;

-(instancetype)initWithRadius:(float)argRadius startDegree:(float)argStart amountDegree:(float)argAmount
{
    self = [self init];
    if(self)
    {
        radius = argRadius;
        startDegreeAngle = argStart;
        amountOfDegreeValue = argAmount;
        xOffSet = 0;
        yOffSet = 0;
        //By default the anchor point will be 0,0
        //self.anchorPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.anchorPoint = CGPointMake(0, 0);
    }
    return self;
}

-(void)addHead:(UIView *)pHead
{
    _head = pHead;
    if(_head != nil)
    {
        [self addSublayer:_head.layer];
        _head.center = CGPathGetCurrentPoint(self.path);
    }
}

+(CircularCAShapeLayer*)layerWith:(float)argRadius startDegree:(float)argStart amountDegree:(float)argAmount
{
    return [[CircularCAShapeLayer alloc]initWithRadius:argRadius startDegree:argStart amountDegree:argAmount];
}

-(CGPoint)center
{
    CGPoint centerPoint = CGPointMake(self.anchorPoint.x + self.frame.size.width/2 + xOffSet, self.anchorPoint.y + self.frame.size.height/2 + yOffSet);
    return centerPoint;
}

-(float)currentEndDegreeValue
{
    return self.startDegreeAngle + self.amountOfDegreeValue;
}

-(void)layoutSublayers
{
    [super layoutSublayers];
    //self.anchorPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.anchorPoint = CGPointMake(0,0);
    self.path = [self circularPathWithLayer:self];
    if(_head != nil)
    {
        _head.center = CGPathGetCurrentPoint(self.path);
    }
}

- (CGPathRef) circularPathWithLayer:(CircularCAShapeLayer*)layer
{
    UIBezierPath *circularLine = [UIBezierPath bezierPathWithArcCenter:[layer center] radius:layer.radius startAngle:ToRad(layer.startDegreeAngle) endAngle:ToRad(layer.startDegreeAngle + layer.amountOfDegreeValue) clockwise:YES];
    
    return [circularLine CGPath];
}


- (void)animateEndDegreeValueTo:(float)amountDegree
{
    // first reduce the view to 1/100th of its original dimension
    CGAffineTransform trans = CGAffineTransformScale(_head.transform, 0.01, 0.01);
    _head.transform = trans;	// do it instantly, no animation
    // now return the view to normal dimension, animating this tranformation
    [UIView animateWithDuration:0.5 animations:^{
        _head.transform = CGAffineTransformScale(_head.transform, 100.0, 100.0);
    }completion:^(BOOL finished) {
        
        [self pathValuesWithVariance:amountDegree finishCallback:^(NSArray*pathValues) {
            CAKeyframeAnimation *morph = [CAKeyframeAnimation animationWithKeyPath:@"path"];
            morph.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            morph.values = pathValues;
            morph.duration = 1;
            morph.removedOnCompletion = NO;
            morph.fillMode = kCAFillModeForwards;
            morph.delegate = self;
            [self addAnimation:morph forKey:@"return"];
            
            if(self.head != nil)
            {
                NSMutableArray * pathPoints = [NSMutableArray array];
                for (id path in pathValues) {
                    CGPathRef pathRef = (__bridge CGPathRef)path;
                    CGPoint currentPoint = CGPathGetCurrentPoint(pathRef);
                    [pathPoints addObject:[NSValue valueWithCGPoint:currentPoint]];
                }
                //CGPathRef last = (__bridge CGPathRef)([pathValues lastObject]);
                CAKeyframeAnimation *morph2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
                morph2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
                morph2.values = pathPoints;
                morph2.duration = 1;
                //morph2.timeOffset = 0.5;
                morph2.removedOnCompletion = NO;
                morph2.fillMode = kCAFillModeForwards;
                morph2.calculationMode = kCAAnimationPaced;
                morph2.delegate = self;
                [_head.layer addAnimation:morph2 forKey:@"return2"];
            }
            
        }];

    }];

    
    }

- (void)pathValuesWithVariance:(float)amountDegree  finishCallback:(void(^)(NSArray*pathValues))finish
{
    
    float variance = amountDegree - self.amountOfDegreeValue;
    int numberOfSteps = ABS(variance);
    //angle will decrease
    
    NSMutableArray * values = [NSMutableArray array];
    for (int i = 0; i < numberOfSteps; i++) {
        if(variance > 0)
        {
            [values addObject:(id)[self circularPathModifiyingStartAngle:0 modifiyingAmountAngle:1 modifiyingRadius:0]];
        }else
        {
            [values addObject:(id)[self circularPathModifiyingStartAngle:0 modifiyingAmountAngle:-1 modifiyingRadius:0]];
        }
    }
    
    finish([NSArray arrayWithArray:values]);
}


/**
 Calculate and return a CGPathRef representing an Arc modifiying the start angle in argValue amount and amount of degree that arc represent in argAmount center in the layer center and modifying the radius of arc
 
 @return a CGPathRef representing the path after change the startDegreeAngle and amountOfDegreeValue
 @param argValue define how much the startDegreeAngle will change
 @param argAmount define how much the amountOfDegreeValue will change
 @param argRadius define how much the radius will change
 */
- (CGPathRef) circularPathModifiyingStartAngle:(float)argValue modifiyingAmountAngle:(float)argAmount modifiyingRadius:(float)argRadius
{
    self.startDegreeAngle += argValue;
    self.amountOfDegreeValue += argAmount;
    self.radius +=argRadius;
    UIBezierPath *circularLine = [UIBezierPath bezierPathWithArcCenter:[self center] radius:self.radius startAngle:ToRad(self.startDegreeAngle) endAngle:ToRad(self.startDegreeAngle + self.amountOfDegreeValue) clockwise:YES];
    return [circularLine CGPath];
}



@end
