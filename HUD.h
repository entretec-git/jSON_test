//
//  HUD.h
//  BeatGuide
//
//  Created by Marin Todorov on 22/04/2012.
//
// This code is distributed under the terms and conditions of the MIT license.
//
// Copyright (c) 2011 Marin Todorov


#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface HUD : NSObject

+(MBProgressHUD*)showUIBlockingIndicator;
+(MBProgressHUD*)showUIBlockingIndicatorWithText:(NSString*)str;
+(MBProgressHUD*)showUIBlockingIndicatorWithText:(NSString*)str withTimeout:(int)seconds;

+(MBProgressHUD*)showUIBlockingProgressIndicatorWithText:(NSString*)str andProgress:(float)progress;

+(MBProgressHUD*)showAlertWithTitle:(NSString*)titleText text:(NSString*)text;
+(MBProgressHUD*)showAlertWithTitle:(NSString*)titleText text:(NSString*)text target:(id)t action:(SEL)sel;

+(void)hideUIBlockingIndicator;

@end
