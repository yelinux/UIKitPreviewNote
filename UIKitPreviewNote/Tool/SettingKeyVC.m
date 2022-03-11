//
//  SettingKeyVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import "SettingKeyVC.h"
#import "SettingEnumValueVC.h"
#import "SettingNumValueVC.h"

@interface SettingKeyVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingKeyVC

+(SettingKeyModel *)createEnumKModelWithPtName: (NSString*)name
                        descArray: (NSArray*)descArray
                           values: (NSArray*)values
                     defaultIndex: (NSInteger)defaultIndex
                     selectChange: (void(^)(NSInteger value))block{
    SettingKeyModel *keyModel = SettingKeyModel.new;
    keyModel.propertyName = name;
    keyModel.selectBlock = ^{
        return [SettingEnumValueVC createEnumKModelWithPtName:name
                                                    descArray:descArray
                                                       values:values
                                                 defaultIndex:defaultIndex
                                                 selectChange:block];
    };
    return keyModel;
}

+(SettingKeyModel*)createStepKModelWithPtName: (NSString*)name
                                        value: (double)value
                                 minimumValue: (double)minimumValue
                                 maximumValue: (double)maximumValue
                                    stepValue: (double)stepValue
                                   valueChage: (void(^)(double value))block{
    SettingKeyModel *keyModel = SettingKeyModel.new;
    keyModel.propertyName = name;
    keyModel.selectBlock = ^{
        return [SettingNumValueVC createStepKModelWithPtName:name
                                                       value:value
                                                minimumValue:minimumValue
                                                maximumValue:maximumValue
                                                   stepValue:stepValue
                                                  valueChage:block];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    SettingKeyModel *keyModel = [_keyModels objectAtIndex:indexPath.row];
    cell.textLabel.text = keyModel.propertyName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SettingKeyModel *keyModel = [_keyModels objectAtIndex:indexPath.row];
    UIViewController *vc = keyModel.selectBlock();
    [self.navigationController pushViewController:vc animated:YES];
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
