//
// CircularCAShapeLayer.h
//
//  Created by Reinier Melian on 09/10/15.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 This class represent a circular shape with center in superview.center
*/
IB_DESIGNABLE
@interface CircularCAShapeLayer : CAShapeLayer <CAAnimationDelegate>

@property (nonatomic,assign) float startDegreeAngle;  //start of arc in degrees
@property (nonatomic,assign) float amountOfDegreeValue; //amount of degrees that arc must show
@property (nonatomic,assign) float radius;

@property (nonatomic,assign) float xOffSet; //x offset from center of superview
@property (nonatomic,assign) float yOffSet; //y offset from center of superview

@property (nonatomic,strong) UIView * head;

-(instancetype)initWithRadius:(float)argRadius startDegree:(float)argStart amountDegree:(float)argAmount;
+(CircularCAShapeLayer*)layerWith:(float)argRadius startDegree:(float)argStart amountDegree:(float)argAmount;

-(void)addHead:(UIView *)pHead;

-(float)currentEndDegreeValue;

-(CGPoint)center;

- (void)animateEndDegreeValueTo:(float)amountDegree;

@end
