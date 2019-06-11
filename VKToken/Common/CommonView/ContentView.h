//
//  ContentView.h
//  DemoView
//
//  Created by lee on 08/02/2019.
//  Copyright © 2019 Vankia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentView;

typedef enum : NSUInteger {
    PrivateKeyShowMode,
    PrivateKeyConfirmMode,
} PrivateViewMode;

@protocol ContentViewDelegate <NSObject>

- (void)didClickConfirmPrivateKeyButton:(ContentView *)selfView andPrivateKeyButton:(UIButton *)button;

- (void)didClickContentPrivateKeyButton:(ContentView *)selfView andPrivateKeyButton:(UIButton *)button;

@end

@interface ContentView : UIView

@property (nonatomic, strong) NSArray *wordArray;

@property (nonatomic, assign) PrivateViewMode viewMode;

@property (nonatomic, weak) id<ContentViewDelegate>delegate;

- (CGFloat)createPrivateKeyButtonsWithArray:(NSArray *)privateKeyWord;

- (void)resetAllProperty;

@end
