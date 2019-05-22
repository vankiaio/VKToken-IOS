//
//  VKTMappingImportAccountHeaderView.m
//  VKToken
//
//  Created by vankiachain on 2018/5/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "VKTMappingImportAccountHeaderView.h"

@interface VKTMappingImportAccountHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet BaseTextView *tipTextView;
@end


@implementation VKTMappingImportAccountHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.tipTextView.placeholder = NSLocalizedString(@"该功能仅适用于VKT映射获得的私钥，且每个映射获得的私钥只能创建一个的VKT账号。", nil);
}

- (IBAction)importAccount:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(importVKTMappingAccountBtnDidClick)]) {
        [self.delegate importVKTMappingAccountBtnDidClick];
    }
}

@end
