//
//  ExpandHitAreaButton.m
//  VKToken
//
//  Created by vankiachain on 2018/10/17.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "ExpandHitAreaButton.h"

@implementation ExpandHitAreaButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(CGRectInset(self.bounds, -20, -20), point)) {
        return YES;
    }
    return NO;
}


@end
