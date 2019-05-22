//
//  VKTMappingImportAccountHeaderView.h
//  VKToken
//
//  Created by vankiachain on 2018/5/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseView.h"

@protocol VKTMappingImportAccountHeaderViewDelegate<NSObject>
- (void)importVKTMappingAccountBtnDidClick;
@end


@interface VKTMappingImportAccountHeaderView : BaseView
@property(nonatomic, weak) id<VKTMappingImportAccountHeaderViewDelegate> delegate;


@property (weak, nonatomic) IBOutlet UITextField *privateKeyTF;

@end
