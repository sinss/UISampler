//
//  ActivityTableViewController.m
//  UICatalog
//
//  Created by Leo on 10/24/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "ActivityTableViewController.h"

@interface ActivityTableViewController ()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *checkState;

@end

@implementation ActivityTableViewController

- (void)loadView
{
    [super loadView];
    NSLog(@"loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createData];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    /*
     Create UIBarButton in UINavitaionBar
     */
    [self createNnavigationBar];
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

- (void)done:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSArray *tmpArray = self.items[sec];
    NSArray *state = self.checkState[sec];
    BOOL check = [state[row] boolValue];
    if (check)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = tmpArray[row];
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSMutableArray *state = [NSMutableArray arrayWithArray:self.checkState[sec]];
    
    BOOL check = [state[row] boolValue];
    
    [state replaceObjectAtIndex:row withObject:[NSNumber numberWithBool:!check]];
    
    NSMutableArray *checkState = [NSMutableArray arrayWithArray:self.checkState];
    
    [checkState replaceObjectAtIndex:sec withObject:state];
    
    self.checkState = [NSArray arrayWithArray:checkState];
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;

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
    
}

- (void)createData
{
    NSMutableArray *items = [NSMutableArray array];
    NSMutableArray *checkStates = [NSMutableArray array];
    for (int i = 0; i < 5; i++)
    {
        NSMutableArray *set = [NSMutableArray array];
        NSMutableArray *state = [NSMutableArray array];
        for (int j = 0 ; j < 5 ; j++)
        {
            [set addObject:[NSString stringWithFormat:@"(%i, %i)",i ,j]];
            [state addObject:@NO];
        }
        [items addObject:set];
        [checkStates addObject:state];
    }
    
    self.items = [NSArray arrayWithArray:items];
    self.checkState = [NSArray arrayWithArray:checkStates];
}
@end
