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
#import "CustomerKeyboard.h"
#import "CustomInputAccessoryView.h"
#import "ActivityTableViewController.h"
#import "LocationTableViewController.h"
#import "PKImagePickerViewController.h"
#import "TSAssetsPickerController.h"

#import "DatabaseAdapter.h"

#define cellIdenttifier @"ActionBCellIdentifier"
#define reuseHeaderIdentifier @"reuseHeaderIdentifier"
#define reuseFooterIdentifier @"reuseFooterIdentifier"

typedef NS_ENUM(NSInteger, FooterOptios)
{
    FooterOptiosCamera,
    FooterOptiosAddFriend,
    FooterOptiosEmoji,
    FooterOptiosLocation,
};

@interface ActionBViewController () <ActionFooterDelegate, UIActionSheetDelegate, PKImagePickerViewControllerDelegate, CustomKeyboardDelegate, TSAssetsPickerControllerDelegate, TSAssetsPickerControllerDataSource, UINavigationControllerDelegate>

@property (nonatomic, strong) ActionAHeader *headerView;
@property (nonatomic, strong) ActionBFooter *footerView;
@property (nonatomic, strong) CustomerKeyboard *customKeyboard;
@property (nonatomic, strong) ActionBFooter *accessoryView;
@property (nonatomic, strong) UIPlaceHolderTextView *textView;
@property (nonatomic, strong) TSAssetsPickerController *albumPicker;

@end

@implementation ActionBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [[DatabaseAdapter shareInstance] getSpots];
    
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self createNnavigationBar];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActionBCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdenttifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActionBFooter" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseHeaderIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActionAHeader" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseFooterIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIKeyboardWillShow & hide
- (void)keyboardWillShow:(NSNotification*)noti
{
    [self.footerView setAlpha:0];
    [self.accessoryView setAlpha:1];
}

- (void)keyboardWillHide:(NSNotification*)noti
{
    [self.footerView setAlpha:1];
    [self.accessoryView setAlpha:0];
    
    self.textView.inputView = nil;
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
    
    self.textView = cell.contentTextView;
    self.textView.inputAccessoryView = self.accessoryView;
    
    [cell.contentTextView setPlaceholder:[NSString stringWithFormat:@"在想些什麼？"]];
    
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

#pragma mark - TSAssetsPickerControllerDataSource
- (NSUInteger)numberOfItemsToSelectInAssetsPickerController:(TSAssetsPickerController *)picker
{
    return 3;
}

- (TSFilter *)filterOfAssetsPickerController:(TSAssetsPickerController *)picker
{
    return [TSFilter filterWithType:FilterTypeAll];
}

#pragma mark - TSAssetsPickerControllerDelegate
- (void)assetsPickerControllerDidCancel:(TSAssetsPickerController *)picker
{
    [_albumPicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)assetsPickerController:(TSAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_albumPicker dismissViewControllerAnimated:YES completion:nil];
        //[DummyAssetsImporter importAssets:assets];
    });
}

- (void)assetsPickerController:(TSAssetsPickerController *)picker failedWithError:(NSError *)error {
    if (error) {
        NSLog(@"Error occurs. Show dialog or something. Probably because user blocked access to Camera Roll.");
    }
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

/*
 
 */
- (ActionBFooter*)footerView
{
    if (!_footerView)
    {
        _footerView = [[[NSBundle mainBundle] loadNibNamed:@"ActionBFooter" owner:self options:nil] objectAtIndex:0];
        _footerView.tag = 0;
        _footerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
        _footerView.actionDelegate = self;
        
        
        CALayer *layer = _footerView.layer;
        //背景
        layer.backgroundColor = [[UIColor whiteColor] CGColor];
        //位移量
        layer.shadowOffset = CGSizeMake(1, 1);
        //陰隱的顏色
        layer.shadowColor = [[UIColor darkGrayColor] CGColor];
        //圓角
        layer.shadowRadius = 3.0f;
        //透明度
        layer.shadowOpacity = 0.70f;
        //陰影的路徑
        layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
        
    }
    return _footerView;
}

- (CustomerKeyboard*)customKeyboard
{
    if (!_customKeyboard)
    {
        _customKeyboard = [[[NSBundle mainBundle] loadNibNamed:@"CustomKeyboard" owner:self options:nil] objectAtIndex:0];
        _customKeyboard.delegate = self;
    }
    return _customKeyboard;
}

- (ActionBFooter*)accessoryView
{
    if (!_accessoryView)
    {
        _accessoryView = [[[NSBundle mainBundle] loadNibNamed:@"ActionBFooter" owner:self options:nil] objectAtIndex:0];
        _accessoryView.tag = 1;
        _accessoryView.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
        _accessoryView.actionDelegate = self;
        
        
         CALayer *layer = _footerView.layer;
         //背景
         layer.backgroundColor = [[UIColor whiteColor] CGColor];
         //位移量
         layer.shadowOffset = CGSizeMake(1, 1);
         //陰隱的顏色
         layer.shadowColor = [[UIColor darkGrayColor] CGColor];
         //圓角
         layer.shadowRadius = 3.0f;
         //透明度
         layer.shadowOpacity = 0.70f;
         //陰影的路徑
         layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
        
    }
    return _accessoryView;
}

- (TSAssetsPickerController*)albumPicker
{
    if (!_albumPicker) {
        _albumPicker = [TSAssetsPickerController new];
        _albumPicker.delegate = self;
        _albumPicker.dataSource = self;
    }
    return _albumPicker;
}
#pragma mark - ActionFooterViewDelegate

- (void)footerView:(ActionBFooter*)footer actionForAction:(Footer)action
{
    NSInteger tag = footer.tag;
    switch (action)
    {
        case FooterCamera:
            [self showActionSheet];
            break;
        case FooterPeople:
        {
            ActivityTableViewController *vc = [[ActivityTableViewController alloc] initWithStyle:UITableViewStylePlain];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
            [self presentViewController:nav animated:YES completion:nil];
            break;
        }
        case FooterEmoji:
            [self switchCustomKeyboard];
            break;
        case FooterLoation:
            
            break;
        case FooterClose:
            [self.textView resignFirstResponder];
            //[self.textView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.3];
            break;
    }
}

#pragma mark - Camera
//TODO : 拍照
- (void)showActionSheet
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"請選擇來源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相機" otherButtonTitles:@"相簿", nil];
    [sheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //相機
        @autoreleasepool {
            PKImagePickerViewController *imagePicker = [[PKImagePickerViewController alloc] init];
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        
    }
    else if (buttonIndex == 1)
    {
        //相簿
        [self presentViewController:self.albumPicker animated:YES completion:nil];
    }
}

#pragma mark PKCameraImagePickerDelegate
-(void)imageSelected:(UIImage*)img
{
    //process selected image
}

-(void)imageSelectionCancelled
{
    
}

#pragma mark - People
//TODO : 取得好友清單
#pragma mark - Emoji
- (void)switchCustomKeyboard
{
    [self.textView resignFirstResponder];
    self.textView.inputView = self.customKeyboard;
    [self.textView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.3];
}

- (void)customKeyboardDoClose:(UIView *)view
{
    [self.textView resignFirstResponder];
    self.textView.inputView = nil;
}

//TODO : 建立客製鍵盤
#pragma mark - Location
//TODO : 取得定位附近地點資訊

@end
