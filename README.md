custom_delegate_background_changer
==================================

What is a Delegate?
Technically speaking, a delegate is just an object that acts on behalf of another object. 

The delegating object is typically a framework object, and the delegate is typically a custom controller object. In a managed memory environment, the delegating object maintains a weak reference to its delegate, and delegate itself maintains a strong reference.

okay, talk is cheap. Let's see it in action!
First, create a new file, I call it BgSlider. make it subclass of UISlider.
open up your BgSlider.h file.
add following code:

@class BgSlider; 
// Declaring my own class, the compiler will yell at you without it. 

@protocol BgSliderDelegate <NSObject> // must be subclass of NSObject! The NSObject protocol contains a method called respondsToSelector:, Calling a method that isn't implemented by the delegate object will cause your application to crash.

// declaring my methods
@optional
-(void)BgSliderDidChange:(BgSlider *)BgSlider withValue:(CGFloat)value;
@required
-(CGFloat)startPositionForBgSlider:(BgSlider *)BgSlider;
@end

@interface BgSlider : UISlider
@property (nonatomic, weak) id <BgSliderDelegate> sliderDelegate; // must be weak if you are using ARC!

// making Custom initializer. 
- (id)initWithFrame:(CGRect)frame withDelegate:(id<BgSliderDelegate>)delegate;
@end

open up your BgSlider.m 
Creating a custom initializer is the key! Setting the delegate during initialization allows the delegate method to be called immediately.
note: initializer is called before anything drawn on the screen.

- (id)initWithFrame:(CGRect)frame withDelegate:(id<BgSliderDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Set delegate
        self.sliderDelegate = delegate; // Set delegate object!
        self.value = [_sliderDelegate startPositionForBgSlider:self]; // set value
        self.minimumTrackTintColor = [UIColor darkGrayColor]; // set  slider track color
    }
    return self;
}

add the following method.
each time a slider peg moves, a message is sent to the delegate object.

- (void)setValue:(float)value animated:(BOOL)animated
{
    //### Must call super class when overriding the value
    [super setValue:value animated:animated];
    
    if (self.sliderDelegate != nil && [self.sliderDelegate respondsToSelector:@selector(BgSliderDidChange:withValue:)]){
		[[self sliderDelegate] BgSliderDidChange:self withValue:value];
	}
    
}

Here is your ViewController.h file.
@interface ViewController : UIViewController <BgSliderDelegate>

Implement following methods in your ViewController.m file.

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

build and run!
Enjoy!

Your feedback is welcomed!
Thanks!



