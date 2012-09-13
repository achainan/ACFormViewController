//
//  ACFormViewController.m
//  Moveline
//
//  Created by Ajay Chainani on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACFormViewController.h"

@interface ACFormViewController ()

@end

@implementation ACFormViewController

@synthesize activeField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

# pragma mark Keyboard Notifications

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)setViewFrame:(CGRect)frame {
    
    [self theScrollView].frame = frame;
}

- (UIScrollView *)theScrollView {
    
    return nil;
}

- (CGRect)viewFrame {
    return [self theScrollView].frame;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *options = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    [[options objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[options objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[options objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView animateWithDuration:animationDuration delay:0 options:animationCurve animations:^{
        CGRect viewFrame = [self viewFrame];
        CGRect keyboardFrameEndRelative = [self.view.superview convertRect:keyboardEndFrame fromView:nil];
        viewFrame.size.height =  keyboardFrameEndRelative.origin.y-viewFrame.origin.y;
        [self setViewFrame:viewFrame];
        
    } completion:^(BOOL finished) {
    }];
}

- (void)keyboardDidShow:(NSNotification *)notification {
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *options = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    [[options objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[options objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[options objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationDuration:animationDuration];
    CGRect viewFrame = [self viewFrame];
    CGRect keyboardFrameEndRelative = [self.view.superview convertRect:keyboardEndFrame fromView:nil];
    viewFrame.size.height =  keyboardFrameEndRelative.origin.y-viewFrame.origin.y;
    [self setViewFrame:viewFrame];
    [UIView commitAnimations];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
