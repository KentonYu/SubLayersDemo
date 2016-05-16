//
//  ViewController.m
//  SubLayersDemo
//
//  Created by KentonYu on 16/5/16.
//  Copyright © 2016年 KentonYu. All rights reserved.
//

#import "ViewController.h"
#import "CAShapeLayerTestView.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *tableViewDataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIButton *dismissButton;

@property (nonatomic, strong) CAShapeLayerTestView *shapeLayerTestView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:tableView];
        tableView.delegate   = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tableView;
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Pravite

- (void)p_show {
    [[UIApplication sharedApplication].keyWindow addSubview:self.mainView];
}

- (void)p_dismiss:(id)sender {
    [self.mainView removeFromSuperview];
    self.mainView = nil;
}


#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.tableViewDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"forIndexPath:indexPath];
    cell.textLabel.text = self.tableViewDataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self.mainView addSubview:self.shapeLayerTestView];
            [self p_show];
            break;
            
        default:
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}



#pragma mark Getter

- (NSArray *)tableViewDataSource {
    if (!_tableViewDataSource) {
      _tableViewDataSource = @[
        @"CAShapeLayer",
        @"CATextLayer",
        @"CATransformLayer",
        @"CAGradientLayer",
        @"CAReplicatorLayer",
        @"CAScrollLayer",
        @"CATiledLayer",
        @"CAEmitterLayer",
        @"CAEAGLLayer",
        @"AVPlayerLayer"
      ];
    }
    return _tableViewDataSource;
}

- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _mainView.backgroundColor = [UIColor blackColor];
        [_mainView addSubview:self.dismissButton];
    }
    return _mainView;
}

- (UIButton *)dismissButton {
    if (!_dismissButton) {
        _dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(15.f, 20.f, 100.f, 44.f)];
        [_dismissButton setTitle:@"dismiss" forState:UIControlStateNormal];
        [_dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_dismissButton addTarget:self action:@selector(p_dismiss:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissButton;
}

- (CAShapeLayerTestView *)shapeLayerTestView {
    if (!_shapeLayerTestView) {
        _shapeLayerTestView = [[CAShapeLayerTestView alloc] init];
    }
    return _shapeLayerTestView;
}

@end
