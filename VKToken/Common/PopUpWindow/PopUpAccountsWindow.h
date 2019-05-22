//
//  PopUpAccountsWindow.h
//  VKToken
//
//  Created by vankiachain on 2018/2/7.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopUpAccountsWindowDelegate<NSObject>
- (void )popUpAssestWindowdidSelectItem:(id)sender;

@end
@interface PopUpAccountsWindow : UIView

@end
