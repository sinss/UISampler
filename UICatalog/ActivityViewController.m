//
//  ActivityViewController.m
//  UICatalog
//
//  Created by leo.chang on 11/1/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityTableSource.h"
#import "CustomSearchBar.h"
#import "CustomCell.h"
#import "customHeaderView.h"
#import "ActionAViewController.h"
#import "ActionBViewController.h"
#import "LocationTableViewController.h"


@interface ActivityViewController () <UIScrollViewDelegate, ActivityScrollDelegate, customHeaderViewAction>

@property (nonatomic, strong) ActivityTableSource *tableSource;
@property (nonatomic, strong) CustomSearchBar *searchBar;
@property (nonatomic, strong) customHeaderView *tableviewHeader;

@end

@implementation ActivityViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    /*
     Create UIBarButton in UINavitaionBar
     */
    [self createNnavigationBar];
    
    self.title = [NSString stringWithFormat:@"tableView"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
#warning 使用一個Delegate包裝ScrollView的callback methods
    self.tableSource = [[ActivityTableSource alloc] init];
    self.tableSource.delegate = self;
    
    self.tableView.delegate = _tableSource;
    self.tableView.dataSource = _tableSource;

    [self.tableView reloadData];
    
    self.tableView.tableHeaderView = self.tableviewHeader;
    
    /*
     最簡單的背景執行動作
     */
    [self performSelectorInBackground:@selector(doComplexityWork) withObject:nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNnavigationBar
{
    //建立一個UIButton
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 40, 40)];
    //設定按鈕被選中時出現的樣式
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    [btn setTitle:@"AA" forState:UIControlStateNormal];
    [btn setTitle:@"HH" forState:UIControlStateHighlighted];
    //UIButton 是一個　UIView 的　subclass
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //建立一個Action Item
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(done:)];
    
    self.navigationItem.leftBarButtonItems = @[item, done];
}

- (void)done:(id)sender
{
    NSLog(@"done!!");
}

- (IBAction)searchItemPress:(id)sender
{
    if (self.searchBar.isShowing)
    {
        [self.searchBar dismiss];
    }
    else
    {
        [self.searchBar showInView:self.view offset:self.tableView.contentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.searchBar.isShowing)
    {
        [self.searchBar dismiss];
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

#pragma mark - Accessors
- (CustomSearchBar*)searchBar
{
    //lazy loader suggested from Apple
    if (!_searchBar)
    {
        _searchBar = [[[NSBundle mainBundle] loadNibNamed:@"CustomSearchBar" owner:self options:nil] objectAtIndex:0];
        _searchBar.frame = CGRectMake(0, -kSearchBarHeight + 64, self.view.frame.size.width, kSearchBarHeight);
    }
    return _searchBar;
}

#pragma mark - ActivityTableSourceDelegate
- (void)ActivityCcrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.searchBar.isShowing)
    {
        [self.searchBar dismiss];
    }
}

#pragma mark - customActionHeaderDelegate
- (void)customHeader:(customHeaderView *)view didSelectAction:(ActionOptions)action
{
    
    if (action == ActionOptionsA)
    {
        ActionAViewController *vc = [[ActionAViewController alloc] initWithNibName:@"ActionAViewController" bundle:nil];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [self presentViewController:nav animated:YES completion:^(){
            //do something
        }];
    }
    else if (action == ActionOptionsB)
    {
        ActionBViewController *vc = [[ActionBViewController alloc] initWithNibName:@"ActionBViewController" bundle:nil];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [self presentViewController:nav animated:YES completion:^(){
            //do something
        }];
    }
    else if (action == ActionOptionsC)
    {
        LocationTableViewController *vc = [[LocationTableViewController alloc] initWithStyle:UITableViewStylePlain];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [self presentViewController:nav animated:YES completion:^(){
            //do something
        }];
    }
    NSLog(@"Action : %i", (int)action);
}

- (customHeaderView*)tableviewHeader
{
    //define a block
//    void (^ActionOptionBlock)() = ^(ActionOptions option) {
//        NSLog(@"action button press");
//        //A Controller do something
//    };
    
    if (!_tableviewHeader)
    {
        _tableviewHeader = [[[NSBundle mainBundle] loadNibNamed:@"customHeaderView" owner:self options:nil] objectAtIndex:0];
        _tableviewHeader.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
        [_tableviewHeader setBlock:nil];
        _tableviewHeader.delegate = self;
    }
    return _tableviewHeader;
}

- (void)doComplexityWork
{
    NSLog(@"XXXXX");
}

@end
