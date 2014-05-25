//
//  BgSlider.m
//  CustomDelegate
//
//  Created by willie shi on 5/25/14.
//  Copyright (c) 2014 8land games studio. All rights reserved.
//

#import "BgSlider.h"

@implementation BgSlider

- (id)initWithFrame:(CGRect)frame withDelegate:(id<BgSliderDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Set delegate
        self.sliderDelegate = delegate;
        self.value = [_sliderDelegate startPositionForBgSlider:self];
        self.minimumTrackTintColor = [UIColor darkGrayColor];
    }
    return self;
}

- (void)setValue:(float)value animated:(BOOL)animated
{
    //### Must call super class when overriding the value
    [super setValue:value animated:animated];
    
    if (self.sliderDelegate != nil && [self.sliderDelegate respondsToSelector:@selector(BgSliderDidChange:withValue:)]){
		[[self sliderDelegate] BgSliderDidChange:self withValue:value];
	}
    
}


@end
