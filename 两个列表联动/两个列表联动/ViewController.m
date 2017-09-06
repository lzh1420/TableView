//
//  ViewController.m
//  两个列表联动
//
//  Created by 嚼华先森 on 2017/5/31.
//  Copyright © 2017年 嚼华. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * leftTableView;
@property (nonatomic,strong) UITableView * rightTableView;
@property (nonatomic,strong) NSMutableArray * dataSource;
@property (nonatomic,strong) NSMutableArray * mArray;
@property (nonatomic, strong) NSIndexPath *currentSelectIndexPath;
@end

@implementation ViewController

-(NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@"龙虾",@"蟹类",@"贝类",@"其他活鲜",@"冻品", nil];
        
        self.mArray = [NSMutableArray arrayWithObjects:@{@"name":@"龙虾",@"title":@[@"加拿大龙虾",@"美国龙虾",@"爱尔兰蓝龙",@"西澳龙",@"南澳龙",@"南非油龙",@"巴基斯坦油龙",@"南非龙",@"南非玫瑰龙",@"琵琶龙虾"]},
                       @{@"name":@"蟹类",@"title":@[@"加拿大珍宝蟹",@"美国珍宝蟹",@"英国面包蟹",@"爱尔兰面包蟹",@"美国面包蟹",@"澳澳大利亚皇帝蟹",@"美国白雪蟹",@"美国红雪蟹",@"阳澄湖大闸蟹",@"加拿大帝皇蟹"]},
                       @{@"name":@"贝类",@"title":@[@"法国生蚝",@"爱尔兰生蚝",@"新西兰生蚝",@"加拿大生蚝",@"中国生蚝",@"纳米比亚生蚝",@"澳洲鲍鱼",@"新西兰鲍鱼",@"南非鲍鱼",@"中国鲍鱼",@"加拿大象拔蚌",@"墨西哥水蚌",@"大西洋海螺",@"爱尔兰活海螺",@"新西兰青口贝",@"加拿大青口贝",@"美国北极蛤"]},
                       @{@"name":@"其他活鲜",@"title":@[@"智利三文鱼",@"加拿大三文鱼",@"苏格兰三文鱼",@"法罗群岛三文鱼",@"加拿大牡丹虾",@"新西兰鳗鱼",@"中国鳗鱼",@"加拿大海胆",@"南非海胆",@"美国海胆"]},
                       @{@"name":@"冻品",@"title":@[@"波虾",@"海蜇虾",@"红虾",@"油龙",@"小龙虾",@"白虾",@"蓝虾",@"小蜜蜂",@"玫瑰龙",@"南非龙",@"帝王蟹",@"面包蟹",@"三文鱼",@"金枪鱼",@"鳕鱼",@"鳗鱼",@"比目鱼",@"冻带鱼",@"文莱龙趸石斑",@"红斑鱼",@"红杉鱼",@"金昌鱼",@"马头鱼",@"北极贝",@"青口贝",@"海螺",@"鲍鱼",@"生蚝",@"兰花蚌",@"日月贝",@"墨鱼仔",@"花枝卷",@"朝鲜蚌",@"牛扒",@"牛板腱",@"牛肉",@"穗香鸡",@"鱿鱼"]}, nil];
        
    }
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:({
        self.leftTableView = [[UITableView alloc]initWithFrame:(CGRect){0,64,self.view.bounds.size.width *0.4,self.view.bounds.size.height-64} style:UITableViewStylePlain];
        self.leftTableView;
    })];
    
    [self.view addSubview:({
         self.rightTableView = [[UITableView alloc]initWithFrame:(CGRect){self.view.bounds.size.width*0.4, 64, self.view.bounds.size.width*0.6, self.view.bounds.size.height-64} style:UITableViewStylePlain];
        self.rightTableView;
    })];
    
    self.rightTableView.delegate = self.leftTableView.delegate = self;
    self.rightTableView.dataSource = self.leftTableView.dataSource = self;
    
//    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == self.leftTableView) {
        return 1;
    }return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.leftTableView) {
        return self.dataSource.count;
    }
    NSArray *array = self.mArray[section][@"title"];
    NSLog(@"+++++++%@",array);
    return [self.mArray[section][@"title"]count];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (tableView == self.leftTableView) {
        cell.textLabel.text = self.dataSource[indexPath.row];
    }else{
        NSArray *array = self.mArray[indexPath.section][@"title"];
        cell.textLabel.text = array[indexPath.row];
        cell.backgroundColor = [UIColor redColor];
    }
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.leftTableView) {
        return nil;
    }else{
        return self.dataSource[section];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.leftTableView) {
//        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
//    else{
//        [self.rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
//    }
    self.currentSelectIndexPath = indexPath;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.currentSelectIndexPath) {
        return;
    }
    if ((UITableView *)scrollView == self.leftTableView) {
        return;
    }
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.rightTableView.indexPathsForVisibleRows.firstObject.section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if (self.currentSelectIndexPath) self.currentSelectIndexPath = nil;
}




@end
