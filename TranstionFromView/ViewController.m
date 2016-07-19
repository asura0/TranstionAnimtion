//
//  ViewController.m
//  TranstionFromView
//
//  Created by 赚发2 on 16/7/14.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import "ViewController.h"

#import "TranstionView.h"

#import "TableViewCell.h"

static NSString *const indentifier = @"TableViewCell";

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *datasource;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _datasource = [@[@"qingshimingyue1",@"qingshimingyue2",@"qingshimingyue3",@"qingshimingyue4"]mutableCopy];
    [self confguireTableView];
}


- (void)confguireTableView{
    [_tableview registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:indentifier];
    _tableview.rowHeight = 160;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    cell.imagView.image = [UIImage imageNamed:_datasource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    TranstionView *transtionView = [[TranstionView alloc] initWithFrame:self.view.frame
                                                          containerView:self.view
                                                          showImageView:cell.imagView
                                                         imageSuperView:cell
                                                              showImage:[UIImage imageNamed:_datasource[indexPath.row]]];
    [self.view addSubview:transtionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
