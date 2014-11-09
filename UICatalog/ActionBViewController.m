//
//  ActionBViewController.m
//  UICatalog
//
//  Created by leo.chang on 11/8/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "ActionBViewController.h"
#import "ActionBCell.h"
#import "ActionBCell2.h"
#import "ActionAHeader.h"
#import "ActionBFooter.h"

#define cellIdenttifier @"ActionBCellIdentifier"

typedef NS_ENUM(NSInteger, FooterOptios)
{
    FooterOptiosCamera,
    FooterOptiosAddFriend,
    FooterOptiosEmoji,
    FooterOptiosLocation,
};

@interface ActionBViewController ()

@property (nonatomic, strong) ActionAHeader *headerView;
@property (nonatomic, strong) ActionBFooter *footerView;

@end

@implementation ActionBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self createNnavigationBar];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActionBCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdenttifier];
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Cell高度需要扣掉上方Navigationbar & footerView & headerView的高度
    return self.view.frame.size.height - 80 - 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActionBCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenttifier forIndexPath:indexPath];
    
    
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

- (ActionAHeader*)headerView
{
    if (!_headerView)
    {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"ActionAHeader" owner:self options:nil] objectAtIndex:0];
        _headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    }
    return _headerView;
}

- (ActionBFooter*)footerView
{
    if (!_footerView)
    {
        self.footerView = [[[NSBundle mainBundle] loadNibNamed:@"ActionBFooter" owner:self options:nil] objectAtIndex:0];
        self.footerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    }
    return _footerView;
}


@end
