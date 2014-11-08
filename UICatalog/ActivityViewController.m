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
#import "NSDate+TimeAgo.h"
#import "ActionAViewController.h"
#import "ActionBViewController.h"


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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startPullDownRefreshing];
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
    NSLog(@"Action : %i", (int)action);
}

- (customHeaderView*)tableviewHeader
{
    //define a block
    void (^ActionOptionBlock)() = ^(ActionOptions option) {
        NSLog(@"action button press");
        //A Controller do something
    };
    
    if (!_tableviewHeader)
    {
        _tableviewHeader = [[[NSBundle mainBundle] loadNibNamed:@"customHeaderView" owner:self options:nil] objectAtIndex:0];
        _tableviewHeader.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
        [_tableviewHeader setBlock:nil];
        _tableviewHeader.delegate = self;
    }
    return _tableviewHeader;
}

#pragma mark - PullToRefreshing
- (void)loadDataSource {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *dataSource = [[NSMutableArray alloc] init];
        for (int i = 0; i < 100; i ++) {
            [dataSource addObject:@"请问你现在在哪里啊？我在广州天河"];
        }
        
        NSMutableArray *indexPaths;
        if (self.requestCurrentPage) {
            indexPaths = [[NSMutableArray alloc] initWithCapacity:dataSource.count];
            [dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:self.dataSource.count + idx inSection:0]];
            }];
        }
        sleep(1.5);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.requestCurrentPage) {
                if (self.requestCurrentPage == arc4random() % 10) {
                    [self endMoreOverWithMessage:@"段子已加载完"];
                } else {
                    
                    [self.dataSource addObjectsFromArray:dataSource];
                    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                    [self endLoadMoreRefreshing];
                }
            } else {
                if (rand() % 3 > 1) {
                    self.loadMoreRefreshed = NO;
                }
                
                self.dataSource = dataSource;
                [self.tableView reloadData];
                [self endPullDownRefreshing];
            }
        });
    });
}

#pragma mark - XHRefreshControl Delegate

- (NSString *)lastUpdateTimeString {
    
    NSDate *nowDate = [NSDate date];
    
    NSString *destDateString = [nowDate timeAgo];
    
    return destDateString;
}

- (UIView *)customPullDownRefreshView {
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -60, 320, 60)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    progressView.tag = 100;
    progressView.frame = CGRectMake(0, CGRectGetHeight(backgroundView.bounds) / 2.0 - 3, 320, 3);
    if ([progressView respondsToSelector:@selector(setTintColor:)]) {
        progressView.tintColor = [UIColor orangeColor];
    }
    [backgroundView addSubview:progressView];
    return backgroundView;
}

- (void)customPullDownRefreshView:(UIView *)customPullDownRefreshView withPullDownOffset:(CGFloat)pullDownOffset {
    UIProgressView *progessView = (UIProgressView *)[customPullDownRefreshView viewWithTag:100];
    [progessView setProgress:pullDownOffset / 40.0 animated:NO];
}

- (void)customPullDownRefreshViewWillStartRefresh:(UIView *)customPullDownRefreshView {
    UIProgressView *progressView = (UIProgressView *)[customPullDownRefreshView viewWithTag:100];
    [progressView setProgress:1.0];
    if ([progressView respondsToSelector:@selector(setTintColor:)]) {
        [progressView setTintColor:[UIColor greenColor]];
    }
}

- (void)customPullDownRefreshViewWillEndRefresh:(UIView *)customPullDownRefreshView {
    UIProgressView *progressView = (UIProgressView *)[customPullDownRefreshView viewWithTag:100];
    if ([progressView respondsToSelector:@selector(setTintColor:)]) {
        [progressView setTintColor:[UIColor greenColor]];
    }
    [progressView setProgress:0.0 animated:NO];
}
- (CGFloat)preloadDistance {
    return 1500;
}

@end
