//
//  SettingEnumValueVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import "SettingEnumValueVC.h"

@interface SettingEnumValueVCModel()

@property (nonatomic, copy) void(^clickBlock)(NSInteger index);

@end

@implementation SettingEnumValueVCModel

+(SettingEnumValueVCModel *)createEnumKModelWithPtName: (NSString*)name
                                        descArray: (NSArray*)descArray
                                           values: (NSArray*)values
                                     defaultIndex: (NSInteger)defaultIndex
                                     selectChange: (void(^)(NSInteger value))block{
    SettingEnumValueVCModel *model = SettingEnumValueVCModel.new;
    model.propertyName = name;
    model.values = descArray;
    model.selectIndex = [values indexOfObject:@(defaultIndex)];
    model.clickBlock = ^(NSInteger index) {
        block([[values objectAtIndex:index] integerValue]);
    };
    return model;
}

@end

@interface SettingEnumValueVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingEnumValueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    if (self.model.selectIndex < self.model.values.count) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.model.selectIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.values.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [self.model.values objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.model.clickBlock(indexPath.row);
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
