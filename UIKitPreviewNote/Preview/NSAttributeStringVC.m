//
//  NSAttributeStringVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/22.
//

#import "NSAttributeStringVC.h"
#import "SettingVC.h"
#import "SettingEnumValueVC.h"
#import "SettingNumCell.h"

@interface NSAttributeStringVC ()

@property (nonatomic, strong) UILabel *lb;
@property (nonatomic, strong) NSMutableDictionary *attrMutDic;
@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;

@end

@implementation NSAttributeStringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"NSAttributeString";
    self.view.backgroundColor = UIColor.whiteColor;
    self.attrMutDic = NSMutableDictionary.new;
    self.paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    UILabel *lb = UILabel.new;
    lb.numberOfLines = 0;
    lb.font = [UIFont systemFontOfSize:10];
    lb.textColor = UIColor.blackColor;
    _lb = lb;
    
    SettingVC *vc = [[SettingVC alloc] init];
    [self addChildViewController:vc];
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[lb, vc.view]];
    stackView.axis = UILayoutConstraintAxisVertical;
    [self.view addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.mas_equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.mas_equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            // Fallback on earlier versions
            make.edges.offset(0);
        }
    }];
    
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(128);
    }];
    
    __weak UILabel *wlb = lb;
    __weak typeof(self)weakSelf = self;
    vc.keyVC.getModelBlock = ^NSArray<SettingKeyModel *> * _Nonnull{
        NSMutableArray <SettingKeyModel*> *keyModels = NSMutableArray.new;
        {
            SettingKeyModel *keyModel = [SettingKeyVC createFontModelWithPtName:@"NSFontAttributeName" valueChage:^(UIFont * _Nonnull font) {
                [weakSelf.attrMutDic setValue:font forKey:NSFontAttributeName];
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        {
            UIColor *color = [weakSelf.attrMutDic objectForKey:NSForegroundColorAttributeName];
            SettingKeyModel *keyModel = [SettingKeyVC createColorModelWithPtName:@"NSForegroundColorAttributeName" value:color?color:wlb.textColor valueChage:^(UIColor * _Nonnull color) {
                [weakSelf.attrMutDic setValue:color forKey:NSForegroundColorAttributeName];
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"lineSpacing"
                                                                                      value:weakSelf.paragraphStyle.lineSpacing
                                                                               minimumValue:0
                                                                               maximumValue:100
                                                                                  stepValue:1
                                                                                 valueChage:^(double value) {
                [weakSelf.paragraphStyle setLineSpacing:value];
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        {
            // 段落\n间距
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"paragraphSpacing"
                                                                                      value:weakSelf.paragraphStyle.paragraphSpacing
                                                                               minimumValue:0
                                                                               maximumValue:100
                                                                                  stepValue:1
                                                                                 valueChage:^(double value) {
                [weakSelf.paragraphStyle setParagraphSpacing:value];
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        {
            NSArray *desces = @[@"NSTextAlignmentLeft",
                                @"NSTextAlignmentCenter",
                                @"NSTextAlignmentRight",
                                @"NSTextAlignmentJustified",
                                @"NSTextAlignmentNatural"];
            NSArray *values = @[@(NSTextAlignmentLeft),
                                @(NSTextAlignmentCenter),
                                @(NSTextAlignmentRight),
                                @(NSTextAlignmentJustified),
                                @(NSTextAlignmentNatural)];
            NSInteger defaultIndex = [values indexOfObject:@(weakSelf.paragraphStyle.alignment)];
            SettingKeyModel *keyModel = [SettingEnumValueVCModel createEnumKModelWithPtName:@"alignment"
                                                                                  descArray:desces
                                                                                     values:values
                                                                               defaultIndex:defaultIndex
                                                                               selectChange:^(NSInteger value) {
                weakSelf.paragraphStyle.alignment = value;
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"firstLineHeadIndent"
                                                                                      value:weakSelf.paragraphStyle.firstLineHeadIndent
                                                                               minimumValue:0
                                                                               maximumValue:100
                                                                                  stepValue:1
                                                                                 valueChage:^(double value) {
                [weakSelf.paragraphStyle setFirstLineHeadIndent:value];
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"headIndent"
                                                                                      value:weakSelf.paragraphStyle.headIndent
                                                                               minimumValue:0
                                                                               maximumValue:100
                                                                                  stepValue:1
                                                                                 valueChage:^(double value) {
                [weakSelf.paragraphStyle setHeadIndent:value];
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"tailIndent"
                                                                                      value:weakSelf.paragraphStyle.tailIndent
                                                                               minimumValue:0
                                                                               maximumValue:100
                                                                                  stepValue:1
                                                                                 valueChage:^(double value) {
                [weakSelf.paragraphStyle setTailIndent:value];
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        {
            NSArray *desces = @[@"NSLineBreakByWordWrapping",
                                @"NSLineBreakByCharWrapping",
                                @"NSLineBreakByClipping",
                                @"NSLineBreakByTruncatingHead",
                                @"NSLineBreakByTruncatingTail",
                                @"NSLineBreakByTruncatingMiddle"];
            NSArray *values = @[@(NSLineBreakByWordWrapping),
                                @(NSLineBreakByCharWrapping),
                                @(NSLineBreakByClipping),
                                @(NSLineBreakByTruncatingHead),
                                @(NSLineBreakByTruncatingTail),
                                @(NSLineBreakByTruncatingMiddle)];
            NSInteger defaultIndex = [values indexOfObject:@(weakSelf.paragraphStyle.lineBreakMode)];
            SettingKeyModel *keyModel = [SettingEnumValueVCModel createEnumKModelWithPtName:@"lineBreakMode"
                                                                                  descArray:desces
                                                                                     values:values
                                                                               defaultIndex:defaultIndex
                                                                               selectChange:^(NSInteger value) {
                weakSelf.paragraphStyle.lineBreakMode = value;
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"minimumLineHeight"
                                                                                      value:weakSelf.paragraphStyle.minimumLineHeight
                                                                               minimumValue:0
                                                                               maximumValue:100
                                                                                  stepValue:1
                                                                                 valueChage:^(double value) {
                weakSelf.paragraphStyle.minimumLineHeight = value;
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"maximumLineHeight"
                                                                                      value:weakSelf.paragraphStyle.maximumLineHeight
                                                                               minimumValue:0
                                                                               maximumValue:100
                                                                                  stepValue:1
                                                                                 valueChage:^(double value) {
                weakSelf.paragraphStyle.maximumLineHeight = value;
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        {
            NSArray *desces = @[@"NSWritingDirectionNatural",
                                @"NSWritingDirectionLeftToRight",
                                @"NSWritingDirectionRightToLeft"];
            NSArray *values = @[@(NSWritingDirectionNatural),
                                @(NSWritingDirectionLeftToRight),
                                @(NSWritingDirectionRightToLeft)];
            NSInteger defaultIndex = [values indexOfObject:@(weakSelf.paragraphStyle.baseWritingDirection)];
            SettingKeyModel *keyModel = [SettingEnumValueVCModel createEnumKModelWithPtName:@"baseWritingDirection"
                                                                                  descArray:desces
                                                                                     values:values
                                                                               defaultIndex:defaultIndex
                                                                               selectChange:^(NSInteger value) {
                weakSelf.paragraphStyle.baseWritingDirection = value;
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"lineHeightMultiple"
                                                                                      value:weakSelf.paragraphStyle.lineHeightMultiple
                                                                               minimumValue:0
                                                                               maximumValue:100
                                                                                  stepValue:1
                                                                                 valueChage:^(double value) {
                weakSelf.paragraphStyle.lineHeightMultiple = value;
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"paragraphSpacingBefore"
                                                                                      value:weakSelf.paragraphStyle.paragraphSpacingBefore
                                                                               minimumValue:0
                                                                               maximumValue:100
                                                                                  stepValue:1
                                                                                 valueChage:^(double value) {
                weakSelf.paragraphStyle.paragraphSpacingBefore = value;
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"hyphenationFactor"
                                                                                      value:weakSelf.paragraphStyle.hyphenationFactor
                                                                               minimumValue:0
                                                                               maximumValue:100
                                                                                  stepValue:1
                                                                                 valueChage:^(double value) {
                weakSelf.paragraphStyle.hyphenationFactor = value;
                [weakSelf refreshUI];
            }];
            [keyModels addObject:keyModel];
        }
        
        return keyModels;
    };
    
    [self refreshUI];
}

- (void)refreshUI{
    NSString *str = @"这是NSAttributedString富文本这是NSAttributedStrin\ng富文本这是NSAttributedString富文本";
    NSMutableAttributedString *specAttr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
    textAttachment.image = [UIImage imageNamed:@"icon_check"];
    CGRect frame = CGRectMake(0, 0, textAttachment.image.size.width, textAttachment.image.size.height);
//    frame.origin.y -= 4;
    textAttachment.bounds = frame;
    [specAttr appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
    
    [specAttr addAttributes:self.attrMutDic range:NSMakeRange(0, specAttr.length)];
    [specAttr addAttribute:NSParagraphStyleAttributeName value:self.paragraphStyle range:NSMakeRange(0, [specAttr length])];
    
    NSMutableAttributedString *attrMut = [[NSMutableAttributedString alloc] initWithString:str];
    [attrMut appendAttributedString:specAttr];
    [attrMut appendAttributedString:[[NSAttributedString alloc] initWithString:str]];
    self.lb.attributedText = attrMut;
    
    //
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
