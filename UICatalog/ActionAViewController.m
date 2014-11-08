//
//  ActionAViewController.m
//  UICatalog
//
//  Created by leo.chang on 11/8/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "ActionAViewController.h"
#import "SearchMarkCell.h"
#import "LocationManager.h"

#define cellIdenttifier @"searchMarkCellIdentifier"

@interface ActionAViewController ()

@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation ActionAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self createNnavigationBar];
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchMarkCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdenttifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if ([[LocationManager sharedInstance] locationServicesEnabled])
    {
        return 0;
    }
    return 1;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.searchBar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenttifier forIndexPath:indexPath];
    
    [cell setLocationServiceEnabled:[[LocationManager sharedInstance] locationServicesEnabled]];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)createNnavigationBar
{
    //建立一個Action Item
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
    //self.navigationItem.leftBarButtonItems = [NSArray arrayWithObject:done];
    self.navigationItem.leftBarButtonItems = @[cancel];
}

- (void)cancel:(id)sender
{
    NSLog(@"Cancel");
    
    [self dismissViewControllerAnimated:YES completion:^(){
        
    }];
}

#pragma mark - Accessors
- (UISearchBar*)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        [_searchBar setPlaceholder:NSLocalizedStringFromTable(@"search_mark", @"LocationStrings", @"註解")];
        //_searchBar.delegate = self;
        [_searchBar setKeyboardType:UIKeyboardTypeNumberPad];
        //cusomized keyboard
        //[_searchBar setInputAccessoryView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)]];
    }
    return _searchBar;
}

@end
