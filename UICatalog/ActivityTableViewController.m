//
//  ActivityTableViewController.m
//  UICatalog
//
//  Created by Leo on 10/24/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "ActivityTableViewController.h"
#import "CustomSearchBar.h"
#import "CustomCell.h"

@interface ActivityTableViewController () <UISearchBarDelegate, CustomCellDelegate>

@property (nonatomic, strong) CustomSearchBar *searchBar;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ActivityTableViewController

- (void)loadView
{
    [super loadView];
    NSLog(@"loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    /*
     Create UIBarButton in UINavitaionBar
     */
    [self createNnavigationBar];
    [self createRefreshControl];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (void)createRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor lightGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
}

- (void)refresh:(id)sender
{
    NSLog(@"refresh!!");
    [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:3];
}

- (void)done:(id)sender
{
    NSLog(@"done!!!");
}

- (IBAction)searchItemPress:(id)sender
{
    if (self.searchBar.isShowing)
    {
        [self.searchBar dismiss];
    }
    else
    {
        [self.searchBar showInView:self.tableView offset:self.tableView.contentOffset];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.searchBar.isShowing)
    {
        [self.searchBar dismiss];
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"Cancel!!");
    if (self.searchBar.isShowing)
    {
        [self.searchBar dismiss];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"Search!!");
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"text change");
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    return YES;
}

#pragma mark - Accessors
- (CustomSearchBar*)searchBar
{
    //lazy loader suggested from Apple
    if (!_searchBar)
    {
        _searchBar = [[[NSBundle mainBundle] loadNibNamed:@"CustomSearchBar" owner:self options:nil] objectAtIndex:0];
        _searchBar.frame = CGRectMake(0, -kSearchBarHeight, self.view.frame.size.width, kSearchBarHeight);
        _searchBar.searchBar.delegate = self;
    }
    return _searchBar;
}

@end
