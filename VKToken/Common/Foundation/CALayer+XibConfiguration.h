//
//  CALayer+XibConfiguration.h
//  VKToken
//
//  Created by vankiachain on 2017/11/29.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (XibConfiguration)
// This assigns a CGColor to borderColor.

@property(nonatomic, assign) UIColor *borderUIColor;
@property(nonatomic, assign) UIColor *shadowUIColor;
@end
