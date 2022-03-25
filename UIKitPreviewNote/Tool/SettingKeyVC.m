//
//  SettingKeyVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import "SettingKeyVC.h"
#import "SettingEnumValueVC.h"
#import "SettingFontVC.h"
#import "SettingColorVC.h"
#import "SettingNumCell.h"

@interface SettingKeyVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingKeyVC

+(SettingKeyModel*)createFontModelWithPtName: (NSString*)name
                                  valueChage: (void(^)(UIFont *font))block{
    SettingKeyModel *keyModel = SettingKeyModel.new;
    keyModel.propertyName = name;
    keyModel.selectBlock = ^{
        SettingFontVC *vc = [[SettingFontVC alloc] init];
        vc.title = name;
        vc.valueChange = block;
        return vc;
    };
    return keyModel;
}

+(SettingKeyModel*)createColorModelWithPtName: (NSString*)name
                                        value: (UIColor*)color
                                   valueChage: (void(^)(UIColor *color))block{
    SettingKeyModel *keyModel = SettingKeyModel.new;
    keyModel.propertyName = name;
    keyModel.selectBlock = ^{
        SettingColorVC *vc = [[SettingColorVC alloc] init];
        vc.title = name;
        vc.color = color;
        vc.valueChange = block;
        return vc;
    };
    return keyModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"属性选择";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 50;
    [tableView registerClass:[SettingNumCell class] forCellReuseIdentifier:NSStringFromClass([SettingNumCell class])];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    _tableView = tableView;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.getModelBlock) {
        self.keyModels = self.getModelBlock();
        [_tableView reloadData];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _keyModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id obj = [_keyModels objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[SettingNumCellModel class]]) {
        SettingNumCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SettingNumCell class]) forIndexPath:indexPath];
        cell.model = obj;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.numberOfLines = 0;
        if ([obj isKindOfClass:[SettingEnumValueVCModel class]]) {
            SettingEnumValueVCModel *keyModel = obj;
            cell.textLabel.text = [NSString stringWithFormat:@"%@:%@", keyModel.propertyName, keyModel.values[keyModel.selectIndex]];
        } else {
            SettingKeyModel *keyModel = obj;
            cell.textLabel.text = keyModel.propertyName;
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id obj = [_keyModels objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[SettingNumCellModel class]]) {
        
    } else if ([obj isKindOfClass:[SettingEnumValueVCModel class]]) {
        SettingEnumValueVCModel *model = obj;
        SettingEnumValueVC *vc = [[SettingEnumValueVC alloc] init];
        vc.title = model.propertyName;
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        SettingKeyModel *keyModel = [_keyModels objectAtIndex:indexPath.row];
        UIViewController *vc = keyModel.selectBlock();
        [self.navigationController pushViewController:vc animated:YES];
    }
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

@implementation SettingKeyModel

@end
