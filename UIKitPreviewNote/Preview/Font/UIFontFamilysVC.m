//
//  UIFontFamilysVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import "UIFontFamilysVC.h"
#import "LBTableViewHeader.h"

@interface MyFontGroup : NSObject
@property (nonatomic, copy) NSString *familyName;
@property (nonatomic, copy) NSArray <NSString *> *fontNames;
@end
@implementation MyFontGroup
@end

@interface UIFontFamilysVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *fontGroups;
@property (nonatomic, strong) NSMutableArray *displayGroups;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, assign) CGFloat fontSize;

@end

@implementation UIFontFamilysVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.fontSize = 16.0f;
    
    UITextField *tf = UITextField.new;
    tf.placeholder = @"filter";
    [tf addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(40);
    }];
    
    UISlider *slider = UISlider.new;
    slider.minimumValue = 0.0f;
    slider.maximumValue = 30.0f;
    slider.value = self.fontSize;
    [slider addTarget:self action:@selector(fontSize:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(tf.mas_bottom);
    }];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedSectionHeaderHeight = 50;
    tableView.estimatedRowHeight = 50;
    [tableView registerClass:[LBTableViewHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([LBTableViewHeader class])];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(slider.mas_bottom).offset(0);
        make.bottom.offset(-self.view.window.safeAreaInsets.bottom);
    }];
    _tableView = tableView;
    
    _fontGroups = NSMutableArray.new;
    NSArray *familyNames = [UIFont familyNames];
    for (NSString *familyName in familyNames){
        MyFontGroup *group = [[MyFontGroup alloc] init];
        group.familyName = familyName;
        group.fontNames = [UIFont fontNamesForFamilyName:familyName];
        [_fontGroups addObject:group];
    }
    [self refreshUI];
}

-(void)refreshUI{
    _displayGroups = NSMutableArray.new;
    for(MyFontGroup *group in _fontGroups){
        NSMutableArray <NSString*> *strList = NSMutableArray.new;
        for(NSString *str in group.fontNames){
            if (_keyword.length <= 0 || [str.lowercaseString containsString:_keyword.lowercaseString]) {
                [strList addObject:str];
            }
        }
        if (_keyword.length <= 0 || [group.familyName.lowercaseString containsString:_keyword.lowercaseString] || strList.count > 0) {
            MyFontGroup *dis = [[MyFontGroup alloc] init];
            dis.familyName = group.familyName;
            dis.fontNames = strList;
            [_displayGroups addObject:dis];
        }
    }
    [self.tableView reloadData];
}

-(void)textChange: (UITextField*)textField{
    self.keyword = textField.text;
    [self refreshUI];
}

-(void)fontSize: (UISlider*)slider{
    self.fontSize = slider.value;
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _displayGroups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MyFontGroup *group = [_displayGroups objectAtIndex:section];
    return group.fontNames.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LBTableViewHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([LBTableViewHeader class])];
    MyFontGroup *group = [_displayGroups objectAtIndex:section];
    header.lb.textColor = UIColor.whiteColor;
    header.lb.attributedText = [self convertStr:group.familyName keyword:self.keyword];
    header.lb.font = [UIFont fontWithName:group.familyName size:self.fontSize];
    
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    MyFontGroup *group = [_displayGroups objectAtIndex:indexPath.section];
    NSString *fontName = [group.fontNames objectAtIndex:indexPath.row];
    cell.textLabel.attributedText = [self convertStr:fontName keyword:self.keyword];
    cell.textLabel.font = [UIFont fontWithName:fontName size:self.fontSize];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSAttributedString*)convertStr: (NSString*)str keyword: (NSString*)keyword{
    NSMutableAttributedString *attrMutStr = [[NSMutableAttributedString alloc] initWithString:str];
    if (keyword.length > 0) {
        NSString *regex = keyword;
        NSError *error;
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex
                                                                                 options:NSRegularExpressionCaseInsensitive
                                                                                   error:&error];
        // 对str字符串进行匹配
        NSArray *matches = [regular matchesInString:str
                                            options:0
                                              range:NSMakeRange(0, str.length)];
        // 遍历匹配后的每一条记录
        for (NSTextCheckingResult *match in matches) {
            NSRange range = [match range];
            [attrMutStr addAttribute:NSForegroundColorAttributeName value:UIColor.redColor range:range];
        }
    }
    [attrMutStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n0123456789 你我他的得地"]];
    return attrMutStr;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.clickBlock(indexPath.row);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
