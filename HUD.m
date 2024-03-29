//
//  HUD.m
//  BeatGuide
//
// This code is distributed under the terms and conditions of the MIT license.
//
// Copyright (c) 2011 Marin Todorov
//


#import "HUD.h"
#import "QuartzCore/QuartzCore.h"

static UIView* lastViewWithHUD = nil;

@interface GlowButton : UIButton <MBProgressHUDDelegate>

@end

@implementation GlowButton
{
    NSTimer* timer;
    float glowDelta;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //effect
        self.layer.shadowColor = [UIColor whiteColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(1,1);
        self.layer.shadowOpacity = 0.9;
        
        glowDelta = 0.2;
        timer = [NSTimer timerWithTimeInterval:0.05
                                        target:self
                                      selector:@selector(glow)
                                      userInfo:nil
                                       repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    return self;
}

-(void)glow
{
    if (self.layer.shadowRadius>7.0 || self.layer.shadowRadius<0.1) {
        glowDelta *= -1;
    }
    self.layer.shadowRadius += glowDelta;
}

-(void)dealloc
{
    [timer invalidate];
    timer = nil;
}

@end

@implementation HUD

+(UIView*)rootView
{
    //return [UIApplication sharedApplication].keyWindow.rootViewController.view;

        UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        while (topController.presentedViewController) {
            topController = topController.presentedViewController;
        }
        
    return topController.view;
}

+(MBProgressHUD*)showUIBlockingIndicator
{
    return [self showUIBlockingIndicatorWithText:nil];
}

+(MBProgressHUD*)showUIBlockingIndicatorWithText:(NSString*)str
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    //show the HUD
    UIView* targetView = [self rootView];
    if (targetView==nil) return nil;

    lastViewWithHUD = targetView;
    
    [MBProgressHUD hideHUDForView:targetView animated:YES];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
	if (str!=nil) {
        hud.labelText = str;
    } else {
        hud.labelText = @"Loading...";
    }
    
    return hud;
}

+(MBProgressHUD*)showUIBlockingIndicatorWithText:(NSString*)str withTimeout:(int)seconds
{
    MBProgressHUD* hud = [self showUIBlockingIndicatorWithText:str];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    hud.customView = [[UIView alloc] initWithFrame:CGRectMake(0,0,37,37)];
    hud.mode = MBProgressHUDModeDeterminate;
    [hud hide:YES afterDelay:seconds];
    return hud;
}

+(MBProgressHUD*)showAlertWithTitle:(NSString*)titleText text:(NSString*)text
{
    return [self showAlertWithTitle:titleText text:text target:nil action:NULL];
}

+(MBProgressHUD*)showAlertWithTitle:(NSString*)titleText text:(NSString*)text target:(id)t action:(SEL)sel
{
    [HUD hideUIBlockingIndicator];
    
    //show the HUD
    UIView* targetView = [self rootView];
    if (targetView==nil) return nil;
    
    lastViewWithHUD = targetView;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    
    //set the text
    hud.labelText = titleText;
    hud.detailsLabelText = text;
    
    //set the close button
    GlowButton* btnClose = [GlowButton buttonWithType:UIButtonTypeCustom];
    if (t!=nil && sel!=NULL) {
        [btnClose addTarget:t action:sel forControlEvents:UIControlEventTouchUpInside];
    } else {
        [btnClose addTarget:hud action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIImage* imgClose = [UIImage imageNamed:@"btnCheck.png"];
    [btnClose setImage:imgClose forState:UIControlStateNormal];
    [btnClose setFrame:CGRectMake(0,0,imgClose.size.width,imgClose.size.height)];
    
    //hud settings
    hud.customView = btnClose;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;    
}

+(void)hideUIBlockingIndicator
{
    [MBProgressHUD hideHUDForView:lastViewWithHUD animated:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


+(MBProgressHUD*)showUIBlockingProgressIndicatorWithText:(NSString*)str andProgress:(float)progress
{
    [HUD hideUIBlockingIndicator];
    
    //show the HUD
    UIView* targetView = [self rootView];
    if (targetView==nil) return nil;
    
    lastViewWithHUD = targetView;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    
    //set the text
    hud.labelText = str;

    hud.mode = MBProgressHUDModeDeterminate;
    hud.progress = progress;
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

@end