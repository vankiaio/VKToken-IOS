//
//  PasswordView.m
//  VKToken
//
//  Created by Lee on 2019/6/13.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#import "PasswordView.h"
//#import "UIColor+Hex.h"
//#import "LocalizedHelper.h"

#define levelViewW 10
#define levelViewH 5
#define space 5

@interface PasswordView()

@property (nonatomic, strong) UILabel *strongLabel;

@property (nonatomic, strong) NSMutableArray *viewArray;

@end

@implementation PasswordView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            CGFloat viewY = (frame.size.height - (3 * 2 + levelViewH * 4))/2;
            UIView *levelView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame)-levelViewW, viewY + (levelViewH + 2) * i, levelViewW, levelViewH)];
            levelView.backgroundColor = [UIColor colorWithRGBHex:0xD8D8D8];
            levelView.tag = 2001 + i;
            [tempArray addObject:levelView];
        }
        
        _viewArray = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = tempArray.count-1; i >= 0; i--) {
            [self addSubview:tempArray[i]];
            [_viewArray addObject:tempArray[i]];
        }
        
        _strongLabel = [[UILabel alloc] initWithFrame:CGRectMake(space, 0, frame.size.width-space*2-levelViewW, frame.size.height)];
        _strongLabel.font = [UIFont systemFontOfSize:14.0];
        _strongLabel.text = @"";
        _strongLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_strongLabel];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
}

- (void)showPasswordViewEffectWith:(PasswordEnum)strongType{
    self.strongType = strongType;
    switch (strongType) {
        case eEmptyPassword: {
            for (int i = 0; i < 4; i ++) {
                UIView *temp = _viewArray[i];
                temp.backgroundColor = [UIColor colorWithRGBHex:0xd8d8d8];
            }
            _strongLabel.text = @"";
        }
            break;
        case eWeakPassword:{
            for (int i = 0; i < 4; i ++) {
                UIView *temp = _viewArray[i];
                temp.backgroundColor = [UIColor colorWithRGBHex:i<1?0xF3474D:0xd8d8d8];
            }
            _strongLabel.text = NSLocalizedString(@"weak", nil);
            _strongLabel.textColor = [UIColor colorWithRGBHex:0xF3474D];
        }
            break;
        case eSosoPassword:{
            for (int i = 0; i < 4; i ++) {
                UIView *temp = _viewArray[i];
                temp.backgroundColor = [UIColor colorWithRGBHex:i<2?0x2890FE:0xd8d8d8];
            }
            _strongLabel.text = NSLocalizedString(@"normal", nil);
            _strongLabel.textColor = [UIColor colorWithRGBHex:0x2890FE];
        }
            break;
        case eGoodPassword:{
            for (int i = 0; i < 4; i ++) {
                UIView *temp = _viewArray[i];
                temp.backgroundColor = [UIColor colorWithRGBHex:i<3?0x4CE4C4:0xd8d8d8];
            }
            _strongLabel.text = NSLocalizedString(@"good", nil);
            _strongLabel.textColor = [UIColor colorWithRGBHex:0x4CE4C4];
        }
            break;
        case eSafePassword:{
            for (int i = 0; i < 4; i ++) {
                UIView *temp = _viewArray[i];
                temp.backgroundColor = [UIColor colorWithRGBHex:0x4ED8B5];
            }
            _strongLabel.text = NSLocalizedString(@"safe", nil);
            _strongLabel.textColor = [UIColor colorWithRGBHex:0x4ED8B5];
        }
        default:
            break;
    }
}

@end
