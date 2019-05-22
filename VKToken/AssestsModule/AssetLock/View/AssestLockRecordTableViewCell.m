//
//  AssestLockRecordTableViewCell.m
//  VKToken
//
//  Created by vankiachain on 2018/2/7.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "AssestLockRecordTableViewCell.h"

@interface AssestLockRecordTableViewCell()
@property(nonatomic, strong) BaseLabel *lockedAmountLabel;
@property(nonatomic, strong) UILabel *lockedAmountValueLabel;
@property(nonatomic, strong) BaseLabel *unlockTimeLabel;
@property(nonatomic, strong) UILabel *unlockTimeValueLabel;

@end


@implementation AssestLockRecordTableViewCell

- (BaseLabel *)lockedAmountLabel{
    if (!_lockedAmountLabel) {
        _lockedAmountLabel = [[BaseLabel alloc] init];
        _lockedAmountLabel.font = [UIFont systemFontOfSize:14];
        _lockedAmountLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _lockedAmountLabel;
}

- (UILabel *)lockedAmountValueLabel{
    if (!_lockedAmountValueLabel) {
        _lockedAmountValueLabel = [[UILabel alloc] init];
        _lockedAmountValueLabel.font = [UIFont systemFontOfSize:14];
        _lockedAmountValueLabel.textColor = HEXCOLOR(0xB0B0B0);
        _lockedAmountValueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _lockedAmountValueLabel;
}

- (UILabel *)unlockTimeLabel{
    if (!_unlockTimeLabel) {
        _unlockTimeLabel = [[BaseLabel alloc] init];
        _unlockTimeLabel.font = [UIFont systemFontOfSize:14];
        _unlockTimeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _unlockTimeLabel;
}

- (UILabel *)unlockTimeValueLabel{
    if (!_unlockTimeValueLabel) {
        _unlockTimeValueLabel = [[UILabel alloc] init];
        _unlockTimeValueLabel.font = [UIFont systemFontOfSize:14];
        _unlockTimeValueLabel.textColor = HEXCOLOR(0xB0B0B0);
        _unlockTimeValueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _unlockTimeValueLabel;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.lockedAmountLabel];
        self.lockedAmountLabel.sd_layout.leftSpaceToView(self.contentView, MARGIN_20).topSpaceToView(self.contentView, 16).heightIs(20).widthIs(SCREEN_WIDTH - (2 * MARGIN_20) - 80);
        
        [self.contentView addSubview:self.lockedAmountValueLabel];
        self.lockedAmountValueLabel.sd_layout.rightSpaceToView(self.contentView, MARGIN_20).topSpaceToView(self.contentView, 16).heightIs(20);
        [self.lockedAmountValueLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH * 3 / 4];
        
        [self.contentView addSubview:self.unlockTimeLabel];
        self.unlockTimeLabel.sd_layout.leftSpaceToView(self.contentView, MARGIN_20).topSpaceToView(self.lockedAmountLabel, 1).heightIs(20);
        [self.unlockTimeLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH * 2 / 5];
        
        [self.contentView addSubview:self.unlockTimeValueLabel];
        self.unlockTimeValueLabel.sd_layout.rightSpaceToView(self.contentView, MARGIN_20).topSpaceToView(self.lockedAmountValueLabel, 1).heightIs(20);[self.unlockTimeValueLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH * 3 / 5];
    }
    return self;
}

- (void)setModel:(AssestLockRecord *)model{

    self.lockedAmountLabel.text = [NSString stringWithFormat: NSLocalizedString(@"锁定数量", nil)];

    self.lockedAmountValueLabel.text = [NSString stringWithFormat:@"%@ VKT",  model.assets];

    self.unlockTimeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"解锁时间", nil)];
    
    self.unlockTimeValueLabel.text = [NSString stringWithFormat:@"%@", model.unlocktime];
}

@end

