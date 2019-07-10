//
//  CreatePrivateKeyViewController.m
//  UIProject
//
//  Created by lee on 07/02/2019.
//  Copyright © 2019 vankia. All rights reserved.
//

#import "CreateMemonicViewController.h"
//#import "UIColor+Hex.h"
#import "UIColor+Util.h"
#import "UILabel+SpacesAdjust.h"
#import "ConfirmMemonicViewController.h"
//#import "UIImage+.h"

@interface CreateMemonicViewController ()
@property (weak, nonatomic) IBOutlet UILabel *privateKeyComment;

@property (weak, nonatomic) IBOutlet UIView *privateContentView;
@property (weak, nonatomic) IBOutlet UILabel *privateKeyLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (strong, nonatomic) NSMutableArray *privateKeyArray;

//localized
@property (weak, nonatomic) IBOutlet UILabel *backupTitle;


@end

@implementation CreateMemonicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"backup_mnem", nil);
    
//    if (self.navigationController.viewControllers.firstObject == self) {
//        [self addLeftBarButtonImage:[[UIImage imageNamed:@"icon_guanbi"] tb_imageWithTintColor:[UIColor whiteColor]] action:@selector(responseLeftButton)];
//    }
    
    self.navigationItem.leftBarButtonItem = nil;
    
    [self changePrivateKeyCommentLabelStyle];
    [self createPrivateKeyLabel];
    
    [self.nextButton setBackgroundColor:[UIColor colorWithRGBHex:0x08B2B8 alpha:1.0]];
    self.nextButton.layer.cornerRadius = self.nextButton.frame.size.height/10;
    [self.nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextButton setTitle:NSLocalizedString(@"next_step", nil) forState:UIControlStateNormal];
    self.nextButton.layer.masksToBounds = YES;
    self.navigationItem.hidesBackButton = YES;
}

- (void)responseLeftButton {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)changeLanguage {
    self.backupTitle.text = NSLocalizedString(@"mnemonic_write_down",nil);
}

- (void)changePrivateKeyCommentLabelStyle{
    NSString *commentString = NSLocalizedString(@"backup_mnem_tips",nil);
    self.privateKeyComment.textColor = [UIColor colorWithRGBHex:0x808080];
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:commentString];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [commentString length])];
    [self.privateKeyComment setAttributedText:attributedString];
}

- (void)createPrivateKeyLabel{
    self.privateContentView.backgroundColor = [UIColor colorWithRGBHex:0xF5F5F9];
    
    NSArray *words = _privateWords;
    NSString *keys = [self generatePrivateKeyWithWords:words];
    self.privateKeyLabel.text = keys;
    self.privateKeyLabel.backgroundColor = [UIColor clearColor];
    self.privateKeyLabel.numberOfLines = 0;
    [UILabel changeLineSpaceForLabel:self.privateKeyLabel WithSpace:10.f];
    
    _privateKeyArray = [NSMutableArray arrayWithArray:words];
}

- (NSString *)generatePrivateKeyWithWords:(NSArray *)words{
    
    NSString *key = @"";
    for (NSString *keyword in words) {
        NSString *spaces = @"    ";
        key = [key stringByAppendingString:keyword];
        key = [key stringByAppendingString:spaces];
    }
    
    return key;
}
- (IBAction)clickNextBtn:(UIButton *)sender {
    ConfirmMemonicViewController *confirmVC = [[ConfirmMemonicViewController alloc] init];
    confirmVC.memonicWords = _privateKeyArray;
//    confirmVC.walletModel = _walletModel;
    [self.navigationController pushViewController:confirmVC animated:YES];
}

@end
