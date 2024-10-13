//
//  ViewController.m
//  StudyObjc
//
//  Created by gtc on 2020/5/30.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "ViewController.h"
#import "QTBaseNavigtiaonController.h"
#import <malloc/malloc.h>

@implementation Person

@end


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *dataDict;
@property (nonatomic, assign) NSNumber *numb;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 45;
    if (!self.dataDict) {
        self.dataDict = [NSMutableDictionary dictionary];
    }
    [self configDataSource];
}

- (void)configDataSource {
    [self.dataDict setObject:@"QTUIKitsIndexController" forKey:@"OC基础"];
    [self.dataDict setObject:@"QTRuntimeIndexController" forKey:@"Runtime"];
    [self.dataDict setObject:@"QTRunloopIndexController" forKey:@"Runloop"];
    [self.dataDict setObject:@"QTThreadIndexController" forKey:@"多线程"];
    [self.dataDict setObject:@"QTAutolayoutIndexController" forKey:@"AutoLayout"];
    [self.dataDict setObject:@"QTCoreAnimaionIndexController" forKey:@"CoreAnimation"];
    [self.dataDict setObject:@"QTGCDIndexController" forKey:@"GCD"];
    [self.dataDict setObject:@"QTOperationViewController" forKey:@"NSOperation"];
    [self.dataDict setObject:@"QTVideoController" forKey:@"Daenerys"];
    [self.dataDict setObject:@"QTKVOViewController" forKey:@"KVO"];
}

#pragma mark - DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataDict.allValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *title = [self.dataDict.allKeys objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [self.dataDict.allKeys objectAtIndex:indexPath.row];
    NSString *classvc = self.dataDict[title];
    UIViewController *thevc = nil;
    
    Class vcClass = NSClassFromString(classvc);
    thevc = [[vcClass alloc] init];
    [self.navigationController pushViewController:thevc animated:YES];
}

@end
