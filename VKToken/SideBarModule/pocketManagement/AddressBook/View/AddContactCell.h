//
//  AddContactCell.h
//  VKToken
//
//  Created by Lee on 2019/7/10.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#ifndef AddContactCell_h
#define AddContactCell_h

@class AddContactCell;

@protocol AddContactCellDelegate <NSObject>

- (void)addContactCell:(AddContactCell *)cell valueChange:(NSString *)value;

@end

@interface AddContactCell : UITableViewCell

@property (nonatomic, weak) id<AddContactCellDelegate> delegate;
@property (nonatomic, strong, readonly) UITextField *inputTextField;

+ (NSString *)reuseIdentifier;

- (void)textFieldEnable:(BOOL)enable;

- (void)updateWithTitle:(NSString *)title value:(NSString *)value;

@end

#endif /* AddContactCell_h */
