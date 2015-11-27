//
//  RMButon.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/27/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMButton.h"

@import QuartzCore;

@protocol _RMButtonDelegate <NSObject>

- (void)_button:(UIButton*)button setHighlighted:(BOOL)highlighted;

@end

@interface _RMButton : UIButton
@property (nonatomic, weak) id<_RMButtonDelegate> delegate;
@end

@implementation _RMButton

- (void)setHighlighted:(BOOL)highlighted
{

    [super setHighlighted:highlighted];
    
    [self.delegate _button:self setHighlighted:highlighted];
}



@end


@interface RMButton ()<_RMButtonDelegate>
@property (nonatomic) UIVisualEffectView* visualEffectView;
@property (nonatomic) UIVisualEffectView* visualVibrancyEffectView;
@property (nonatomic) _RMButton* button;

@property (nonatomic) UIBlurEffect* backgroundBlurEffect;
@property (nonatomic) UIVibrancyEffect* backgroundVibrancyEffect;


@property (nonatomic) UIBlurEffect* backgroundHighlightedBlurEffect;
@property (nonatomic) UIVibrancyEffect* backgroundHighlightedVibrancyEffect;

@end


@implementation RMButton

#pragma mark - UIView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _backgroundBlurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _backgroundVibrancyEffect = [UIVibrancyEffect effectForBlurEffect:_backgroundBlurEffect];
        
        _backgroundHighlightedBlurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _backgroundHighlightedVibrancyEffect = [UIVibrancyEffect effectForBlurEffect:_backgroundHighlightedBlurEffect];
        
        _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:_backgroundBlurEffect];
        _visualEffectView.frame = self.bounds;
       
        
        _visualVibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:_backgroundVibrancyEffect];
        _visualVibrancyEffectView.frame = self.bounds;
        
        
        [self addSubview:_visualEffectView];
        [self addSubview:_visualVibrancyEffectView];
        
        _button =  [[_RMButton alloc] initWithFrame:self.bounds];
        _button.delegate = self;
        
        [self addSubview:_button];
        
        [_visualVibrancyEffectView.contentView addSubview:_button];
    }
    
    return self;
}




- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.visualEffectView.frame = self.bounds;
    self.visualVibrancyEffectView.frame = self.bounds;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return [self.button sizeThatFits:size];
}


- (void)setBlurEffect:(nullable UIBlurEffect *)title forState:(UIControlState)state
{
    
}

#pragma mark - - (void)_button:(UIButton*)button setHighlighted:(BOOL)highlighted;
- (void)_button:(UIButton*)button setHighlighted:(BOOL)highlighted
{
   
        if (highlighted)
        {
            self.visualEffectView.effect = self.backgroundHighlightedBlurEffect;
            self.visualVibrancyEffectView.effect = self.backgroundHighlightedVibrancyEffect;
        } else {
            self.visualEffectView.effect = self.backgroundBlurEffect;
            self.visualVibrancyEffectView.effect = self.backgroundVibrancyEffect;
        }
}

#pragma mark - UIControl

- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self.button addTarget:target action:action forControlEvents:controlEvents];
}


#pragma mark - UIButton

- (void)setTitle:(nullable NSString *)title forState:(UIControlState)state
{
    [self.button setTitle:title forState:state];
    [self setNeedsLayout];
}

- (void)setTitleColor:(nullable UIColor *)color forState:(UIControlState)state {
    [self.button setTitleColor:color forState:state];
    [self setNeedsLayout];
}

- (void)setTitleShadowColor:(nullable UIColor *)color forState:(UIControlState)state
{
    [self.button setTitleShadowColor:color forState:state];
    [self setNeedsLayout];
}

- (void)setImage:(nullable UIImage *)image forState:(UIControlState)state
{
    [self.button setImage:image forState:state];
    [self setNeedsLayout];
}

- (void)setBackgroundImage:(nullable UIImage *)image forState:(UIControlState)state
{
    [self.button setBackgroundImage:image forState:state];
    [self setNeedsLayout];
}

- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(UIControlState)state
{
    [self.button setAttributedTitle:title forState:state];
    [self setNeedsLayout];
}

// TODO needs delegate for this methods
- (CGRect)backgroundRectForBounds:(CGRect)bounds
{
    return [self.button backgroundRectForBounds:bounds];
}
- (CGRect)contentRectForBounds:(CGRect)bounds
{
    return [self.button contentRectForBounds:bounds];
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return [self.button titleRectForContentRect:contentRect];
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return [self.button imageRectForContentRect:contentRect];
}

@end
