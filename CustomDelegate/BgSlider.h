//
//  BgSlider.h
//  CustomDelegate
//
//  Created by willie shi on 5/25/14.
//  Copyright (c) 2014 8land games studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class BgSlider;  // Declaring my own class, the compiler will yell at you without it.

@protocol BgSliderDelegate <NSObject>
@optional
-(void)BgSliderDidChange:(BgSlider *)BgSlider withValue:(CGFloat)value;
@required
-(CGFloat)startPositionForBgSlider:(BgSlider *)BgSlider;
@end

@interface BgSlider : UISlider
@property (nonatomic, weak) id <BgSliderDelegate> sliderDelegate;
- (id)initWithFrame:(CGRect)frame withDelegate:(id<BgSliderDelegate>)delegate;
@end
