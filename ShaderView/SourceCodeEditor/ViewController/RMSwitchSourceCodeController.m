//
//  RMSwitchSourceCodeController.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/27/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMSwitchSourceCodeController.h"

#import "RDKeyboardObserver.h"

#import "RMVertexShaderCodeViewController.h"
#import "RMFragmentShaderCodeViewController.h"

// ------------
#import "RMGLTestRenderViewController.h"
#import "RMTestRenderScene.h"
// ------------


@interface RMSwitchSourceCodeController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, RDKeyboardObserverDelegate>

@property (nonatomic) UIPageViewController* pageViewController;

@property (nonatomic) UISegmentedControl* segmentedContorol;

@property (nonatomic, readonly) RMVertexShaderCodeViewController* vertexShaderCodeViewController;
@property (nonatomic, readonly) RMFragmentShaderCodeViewController* fragmentShaderCodeViewController;

@property (nonatomic) RDKeyboardObserver* keyboardObserver;

@end

@implementation RMSwitchSourceCodeController
@synthesize vertexShaderCodeViewController = _vertexShaderCodeViewController;
@synthesize fragmentShaderCodeViewController = _fragmentShaderCodeViewController;


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
    
    
    self.segmentedContorol = [[UISegmentedControl alloc] initWithItems:@[@"Vertex", @"Fragment"]];
    [self.segmentedContorol addTarget:self action:@selector(onSegmentedControll:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = self.segmentedContorol;
    
    
    [self setActiveController:self.vertexShaderCodeViewController];
    
    
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
    vc.render = [[RMTestRenderScene alloc] initWithVertexShader:vs fragmentShader:fs];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)onSegmentedControll:(UISegmentedControl*)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self setActiveController:self.vertexShaderCodeViewController];
            break;
            
        default:
            [self setActiveController:self.fragmentShaderCodeViewController];
            break;
    }
}

- (void)setActiveController:(UIViewController*)viewController
{
    
    if (viewController == self.vertexShaderCodeViewController)
    {
        self.segmentedContorol.selectedSegmentIndex = 0;
    } else if (viewController == self.fragmentShaderCodeViewController)
    {
        self.segmentedContorol.selectedSegmentIndex = 1;
    }
    
    if ([self.pageViewController.viewControllers lastObject] != viewController)
    {
        UIPageViewControllerNavigationDirection direction;
        if (viewController == self.fragmentShaderCodeViewController)
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
    if (viewController == self.fragmentShaderCodeViewController)
    {
        return self.vertexShaderCodeViewController;
        
    } else if (viewController == self.vertexShaderCodeViewController)
    {
        return self.fragmentShaderCodeViewController;
        
    }
    
    return nil;
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (viewController == self.fragmentShaderCodeViewController)
    {
        return self.vertexShaderCodeViewController;
        
    } else if (viewController == self.vertexShaderCodeViewController)
    {
        return self.fragmentShaderCodeViewController;
        
    }
    
    return nil;
}

#pragma mark - Protected
- (RMVertexShaderCodeViewController*)vertexShaderCodeViewController
{
    
    if (_vertexShaderCodeViewController == nil)
    {
        _vertexShaderCodeViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RMVertexShaderCodeViewController"];
    }
    return _vertexShaderCodeViewController;
}

- (RMFragmentShaderCodeViewController*)fragmentShaderCodeViewController
{
    if (_fragmentShaderCodeViewController == nil)
    {
        _fragmentShaderCodeViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RMFragmentShaderCodeViewController"];
    }
    return _fragmentShaderCodeViewController;
}



@end
