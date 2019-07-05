//
//  ContactCell.m
//  AddressBook1.0
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //创建视图
        [self creatSubViews];
    }
    
    return self;
}

- (void)creatSubViews{
    //头像
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    _image.layer.masksToBounds = YES;
    _image.layer.cornerRadius = 30;
    [self.contentView addSubview:_image];
    
    //姓名
    _name = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 120, 30)];
    _name.textColor = [UIColor blackColor];
    _name.font = [UIFont systemFontOfSize:22];
    [self.contentView addSubview:_name];
    
    //账户
    _account = [[UILabel alloc] initWithFrame:CGRectMake(220, 10, 120, 30)];
    _name.textColor = [UIColor blackColor];
    [self.contentView addSubview:_account];
    
    //备注
    _commnet = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, 200, 30)];
    _commnet.textColor = [UIColor blackColor];
    [self.contentView addSubview:_commnet];
}

- (void)setPer:(Person *)per{
    _image.image = [UIImage imageNamed:per.image];
    _name.text = per.name;
    _account.text = per.account;
    _commnet.text = per.comment;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
