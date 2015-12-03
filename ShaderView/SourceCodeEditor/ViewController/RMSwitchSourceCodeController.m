//
//  RMSwitchSourceCodeController.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/27/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMSwitchSourceCodeController.h"

#import "RDKeyboardObserver.h"

#import "RMSourceCodeViewController.h"
#import "RMSourceCodeStoryboard.h"
// ------------
#import "RMGLTestRenderViewController.h"
#import "RMTestPostEffectRenderScene.h"
// ------------


@interface RMSwitchSourceCodeController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, RDKeyboardObserverDelegate>

@property (nonatomic) UIPageViewController* pageViewController;

@property (nonatomic) UISegmentedControl* segmentedContorol;

@property (nonatomic, readonly) RMSourceCodeViewController* vertexShaderCodeViewController;
@property (nonatomic, readonly) RMSourceCodeViewController* fragmentShaderCodeViewController;

@property (nonatomic, readonly) NSArray<UIViewController*>* viewControllers;

@property (nonatomic) RDKeyboardObserver* keyboardObserver;

@end

@implementation RMSwitchSourceCodeController
@synthesize vertexShaderCodeViewController = _vertexShaderCodeViewController;
@synthesize fragmentShaderCodeViewController = _fragmentShaderCodeViewController;

@synthesize viewControllers = _viewControllers;

- (instancetype)init
{
    return [[UIStoryboard storyboardWithName:kRMSourceCodeStoryboardXibName bundle:nil] instantiateViewControllerWithIdentifier:kRMSwitchSourceCodeControllerReuseIdentifier];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.keyboardObserver = [[RDKeyboardObserver alloc] init];
    self.keyboardObserver.delegate = self;
    
    for (UIViewController *childViewController in [self childViewControllers])
    {
        if ([childViewController isKindOfClass:[UIPageViewController class]])
        {
            
            self.pageViewController = (UIPageViewController *)childViewController;
            
            self.pageViewController.dataSource = self;
            self.pageViewController.delegate = self;
            
            break;
        }
    }
    
    [self configureNavigationBar];
   
}


- (void)configureNavigationBar
{
    NSMutableArray* titles = [NSMutableArray arrayWithCapacity:self.viewControllers.count];
    
    for (UIViewController* vc in self.viewControllers)
    {
        if (vc.title)
        {
            [titles addObject:vc.title];
        } else {
            [titles addObject:@""];
        }
    }
    
    self.segmentedContorol = [[UISegmentedControl alloc] initWithItems:titles];
    [self.segmentedContorol addTarget:self action:@selector(onSegmentedControll:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = self.segmentedContorol;
    
    
    [self setActiveController:[self.viewControllers firstObject]];
    
    
    UIBarButtonItem* run = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(runShader:)];
    
    self.navigationItem.rightBarButtonItem = run;
}


- (IBAction)runShader:(id)sender
{
    
    NSString* vs = [self.vertexShaderCodeViewController sorceCode];
    
    if (vs == nil)
    {
        [self.vertexShaderCodeViewController view]; // Force load view
        vs = [self.vertexShaderCodeViewController sorceCode];
    }
    
    NSString* fs = [self.fragmentShaderCodeViewController sorceCode];
    
    if (fs == nil)
    {
        [self.fragmentShaderCodeViewController view]; // Force load view
        fs = [self.fragmentShaderCodeViewController sorceCode];
    }
    
    RMGLTestRenderViewController* vc = [[RMGLTestRenderViewController alloc] init];
    vc.render = [[RMTestPostEffectRenderScene alloc] initWithVertexShader:vs fragmentShader:fs];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)onSegmentedControll:(UISegmentedControl*)sender
{
     [self setActiveController:self.viewControllers[sender.selectedSegmentIndex]];
}

- (void)setActiveController:(UIViewController*)viewController
{
    self.segmentedContorol.selectedSegmentIndex = [self.viewControllers indexOfObject:viewController];
    
    if ([self.pageViewController.viewControllers lastObject] != viewController)
    {
        NSInteger currentIdx = [self.viewControllers indexOfObject:[self.pageViewController.viewControllers lastObject]];
        NSInteger index = [self.viewControllers indexOfObject:viewController];
        
        UIPageViewControllerNavigationDirection direction;
        if (currentIdx < index)
        {
            direction = UIPageViewControllerNavigationDirectionForward;
        } else {
            direction = UIPageViewControllerNavigationDirectionReverse;
        }
        
        [self.pageViewController setViewControllers:@[viewController] direction:direction animated:YES completion:nil];
    }
}

#pragma mark - RDKeyboardObserverDelegate <NSObject>

- (void)keyboardObserver:(RDKeyboardObserver*)observer keyboardWillShow:(RDKeyboard*)keyboard
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)keyboardObserver:(RDKeyboardObserver*)observer keyboardDidHide:(RDKeyboard*)keyboard
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
    [self setActiveController:[self.pageViewController.viewControllers lastObject]];
}

#pragma mark -  UIPageViewControllerDataSource <NSObject>

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    if (viewController == [self.viewControllers firstObject])
    {
        return [self.viewControllers lastObject];
    }
    
    if (viewController == [self.viewControllers lastObject])
    {
        return [self.viewControllers firstObject];
    }
    
    NSInteger index = [self.viewControllers indexOfObject:viewController] + 1;
    return self.viewControllers[index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (viewController == [self.viewControllers firstObject])
    {
        return [self.viewControllers lastObject];
    }
    
    if (viewController == [self.viewControllers lastObject])
    {
        return [self.viewControllers firstObject];
    }
    
    NSInteger index = [self.viewControllers indexOfObject:viewController] - 1;
    return self.viewControllers[index];
}

#pragma mark - Protected

- (NSArray<UIViewController*>*)viewControllers
{
    if (_viewControllers == nil)
    {
        _viewControllers = @[self.vertexShaderCodeViewController, self.fragmentShaderCodeViewController];
    }
    
    return _viewControllers;
}


- (RMSourceCodeViewController*)vertexShaderCodeViewController
{
    if (_vertexShaderCodeViewController == nil)
    {
        _vertexShaderCodeViewController = [[RMSourceCodeViewController alloc] init];
        _vertexShaderCodeViewController.title = @"Vertex";
        [_vertexShaderCodeViewController loadTextFileWithName:@"Julia" ofType:@"vert"];
    }
    return _vertexShaderCodeViewController;
}

- (RMSourceCodeViewController*)fragmentShaderCodeViewController
{
    if (_fragmentShaderCodeViewController == nil)
    {
        _fragmentShaderCodeViewController = [[RMSourceCodeViewController alloc] init];
        _fragmentShaderCodeViewController.title = @"Fragment";
        [_fragmentShaderCodeViewController loadTextFileWithName:@"Julia" ofType:@"frag"];
    }
    return _fragmentShaderCodeViewController;
}



@end
