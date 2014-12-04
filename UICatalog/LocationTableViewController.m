//
//  LocationTableViewController.m
//  UICatalog
//
//  Created by leo.chang on 11/28/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "LocationTableViewController.h"
#import "DatabaseAdapter.h"

@interface LocationTableViewController ()
{
    BOOL canSelected;
}
@property (nonatomic, strong) NSArray *spots;
@property (nonatomic, strong) NSMutableArray *checedkValues;

@end

@implementation LocationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBarItem];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    __block LocationTableViewController *blockSelf = self;
    [[DatabaseAdapter shareInstance] getSpotsCompletion:^(BOOL success, NSArray *items){
        blockSelf.spots = items;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    _delegate = nil;
}

- (void)createBarItem
{
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"確定" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel:)];
    
    self.navigationItem.leftBarButtonItems = @[done];
    self.navigationItem.rightBarButtonItems = @[cancel];
}

- (void)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(didSelectItems:)])
        {
            [self.delegate didSelectItems:[self getSelectedItems]];
        }
    }];
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.spots.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }
    
    SpotItem *item = self.spots[indexPath.row];
    cell.textLabel.text = item.spot;
    if (item.selected)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate shouldSelectEnable])
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        SpotItem *item = self.spots[indexPath.row];
        
        item.selected = !item.selected;
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
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

- (NSArray*)getSelectedItems
{
    NSMutableArray *items = [NSMutableArray array];
    for (SpotItem *item in _spots)
    {
        if (item.selected)
        {
            [items addObject:items];
        }
    }
    return items;
}
@end
