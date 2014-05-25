//
//  ViewController.m
//  CustomDelegate
//
//  Created by willie shi on 5/25/14.
//  Copyright (c) 2014 8land games studio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self addSlider];
}

-(void)addSlider{
    CGFloat sliderColorPosition = 0.3f;
    self.view.backgroundColor = [UIColor colorWithRed:sliderColorPosition green:sliderColorPosition blue:sliderColorPosition alpha:1.0f];
    
    // ### Instaniate sliders from RGB Values
    CGRect redSliderFrame = CGRectMake(20.0f, 180.0f, 280.0f, 30.0f);
    BgSlider *redSlider = [[BgSlider alloc] initWithFrame:redSliderFrame withDelegate:self];
    redSlider.tag = 1;
    [self.view addSubview:redSlider];
    
    CGRect greenSliderFrame = CGRectMake(20.0f, 230.0f, 280.0f, 30.0f);
    BgSlider *greenSlider = [[BgSlider alloc] initWithFrame:greenSliderFrame withDelegate:self];
    greenSlider.tag = 2;
    [self.view addSubview:greenSlider];
    
    CGRect blueSliderFrame = CGRectMake(20.0f, 280.0f, 280.0f, 30.0f);
    BgSlider *blueSlider = [[BgSlider alloc] initWithFrame:blueSliderFrame withDelegate:self];
    blueSlider.tag = 3;
    [self.view addSubview:blueSlider];
}

-(CGFloat)startPositionForBgSlider:(BgSlider *)BgSlider{
    CGFloat startPos = 0.5f;
    return startPos;
}

-(void)BgSliderDidChange:(BgSlider *)BgSlider withValue:(CGFloat)value{
    if (BgSlider.tag == 1) { //Red Slider
        CGColorRef bgColor = self.view.backgroundColor.CGColor;
        const CGFloat *colorsPointer = CGColorGetComponents(bgColor);
        CGFloat currentGreen = colorsPointer[1];
        CGFloat currentBlue = colorsPointer[2];
        self.view.backgroundColor = [UIColor colorWithRed:value green:currentGreen blue:currentBlue alpha:1.0f];

    }
    if (BgSlider.tag == 2) { //Green Slider
        
        CGColorRef bgColor = self.view.backgroundColor.CGColor;
        const CGFloat *colorsPointer = CGColorGetComponents(bgColor);
        CGFloat currentRed = colorsPointer[0];
        CGFloat currentBlue = colorsPointer[2];
        self.view.backgroundColor = [UIColor colorWithRed:currentRed green:value blue:currentBlue alpha:1.0f];
        
    }
    if (BgSlider.tag == 3) { //Blue Slider
        
        CGColorRef bgColor = self.view.backgroundColor.CGColor;
        const CGFloat *colorsPointer = CGColorGetComponents(bgColor);
        CGFloat currentRed = colorsPointer[0];
        CGFloat currentGreen = colorsPointer[1];
        self.view.backgroundColor = [UIColor colorWithRed:currentRed green:currentGreen blue:value alpha:1.0f];
    }

}

@end
