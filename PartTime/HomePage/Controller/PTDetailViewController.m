//
//  PTDetailViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTDetailViewController.h"
#import "PTDetailTitleCell.h"
#import "PTDetailContentCell.h"
#import "PTDetailCompanyCell.h"
#import "PTCopyThreeAlertView.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
/// iOS 9的新框架
#import <ContactsUI/ContactsUI.h>
#import "PTLoginViewController.h"
#import "PTLoginViewController.h"

#define Is_up_Ios_9    ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
@interface PTDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ABPeoplePickerNavigationControllerDelegate,CNContactPickerDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic,strong)UIButton *confirmBtn;
@property (nonatomic,strong) CAGradientLayer *confirmLayer;
@property (nonatomic,strong)UILabel *confirmLabel;
@property (nonatomic,strong)PartTimeModel *model;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)BOOL isOpen;
@property (nonatomic,strong)PartTimeDetailModel *detailModel;

@end

@implementation PTDetailViewController

- (void)viewDidLoad {
     [super viewDidLoad];
    
    [self createTabelView];
    
    [self confirmBtn];
    
    [self setTitle:@"详情"];
       
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    
    [self requestDetailAction];
}

- (void)createTabelView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, self.view.bounds.size.height - 45) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    [self registerAction];
    
    _tableView.estimatedRowHeight = 0;

    
}

- (void)registerAction{
    [_tableView registerNib:[UINib nibWithNibName:@"PTDetailTitleCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PTDetailTitleCell class])];
     [_tableView registerNib:[UINib nibWithNibName:@"PTDetailContentCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PTDetailContentCell class])];
     [_tableView registerNib:[UINib nibWithNibName:@"PTDetailCompanyCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PTDetailCompanyCell class])];
}

#pragma mark ----tableViewDataSource----
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self titleCell:tableView indexPath:indexPath];
    }else if(indexPath.section == 1){
        return [self contentCell:tableView indexPath:indexPath];
    }else{
        return [self companyCell:tableView indexPath:indexPath];
    }
   
}


/** 标题 */
- (UITableViewCell *)titleCell:(UITableView *)tableView
                     indexPath:(NSIndexPath *)indexPath
{
    PTDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PTDetailTitleCell class])];
    [cell setDataWithModel:self.model];
    __weak typeof(self)weakSelf = self;
    [cell setCopyBlock:^(PartTimeModel * _Nonnull model) {
        [weakSelf copyAction:model];
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


/** 工作内容 */
- (UITableViewCell *)contentCell:(UITableView *)tableView
                     indexPath:(NSIndexPath *)indexPath
{
    PTDetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PTDetailContentCell class])];
    //cell.clipsToBounds = YES;
    [cell setDataWithModel:self.model];
    __weak typeof(self)weakSelf = self;
    [cell setOpenBlock:^(BOOL isOpen) {
        weakSelf.isOpen = isOpen;
        [weakSelf.tableView reloadData];
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


/** 公司 */
- (UITableViewCell *)companyCell:(UITableView *)tableView
                     indexPath:(NSIndexPath *)indexPath
{
    PTDetailCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PTDetailCompanyCell class])];
    [cell setDataWithModel:self.model comModel:self.detailModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


#pragma mark ----tableViewDelegate----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.model) {
        if (indexPath.section == 0) {
            return self.model.detailTitleCellHeight;
        }else if(indexPath.section == 1){
            
            //内容可能包含有展开信息
          //  if (self.isOpen) {
                return self.model.detailContentRealCellHeight;
//            }else{
//                return self.model.detailContentCellHeight;
//            }
            
        }else{
            return self.model.detailCompanyCellHeight;
        }
        
    }else{
        return 300;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 19)];
    view.backgroundColor = [PTTool colorFromHexRGB:@"#f1f3f4"];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - getter and setter
- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 45 - self.navigationController.navigationBar.height - statusRect.size.height, WIDTH_OF_SCREEN, 45)];
        [btn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _confirmBtn = btn;
        
        [_confirmBtn.layer addSublayer:self.confirmLayer];
        [self confirmLabel];
    }
    
    return _confirmBtn;
}

- (UILabel *)confirmLabel
{
    if (!_confirmLabel) {
        _confirmLabel = [[UILabel alloc] initWithFrame:self.confirmBtn.frame];
        _confirmLabel.text = @"报名参加";
        _confirmLabel.textColor = [PTTool colorFromHexRGB:@"#ffffff"];
        _confirmLabel.font = [UIFont boldSystemFontOfSize:18.f];
        _confirmLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_confirmLabel];
    }
    
    return _confirmLabel;
}

- (CAGradientLayer *)confirmLayer
{
    if (!_confirmLayer) {
        _confirmLayer = [PTTool customLayer:self.confirmBtn haveCorner:NO];
    }
    
    return _confirmLayer;
}

#pragma mark - senderAction -
- (void)confirmAction:(UIButton *)sender
{
    if ([PTUserUtil loginStatus]) {
        __weak typeof(self)weakSelf = self;
        [PartTimeUserJoinModel requestJoinPartTimeWithUserId:[PTUserUtil getUserId] aid:self.ptId completeBlock:^(id obj) {
            PartTimeUserJoinModel *model = (PartTimeUserJoinModel *)obj;
            if ([model.status isEqualToString:@"0000"]) {
                weakSelf.confirmBtn.backgroundColor = [PTTool colorFromHexRGB:@"#b2b2b2"];
                weakSelf.confirmLabel.text = @"已报名";
                [weakSelf.confirmLayer removeFromSuperlayer];
                
                [weakSelf copyAction:weakSelf.model];
            }
            
        } faileBlock:^(id error) {
            
        }];
    }else{
        PTLoginViewController *loginVC = [[PTLoginViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
   

}


- (void)copyAction:(PartTimeModel *)model
{
    if ([PTUserUtil loginStatus]) {
        UIWindow *window = [PTManager shareManager].hightWindow;
        PTCopyThreeAlertView *view = [PTCopyThreeAlertView initWithXib];
        view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        view.frame = CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN);
        view.contactType = model.contactType;
        [window addSubview:view];
        window.hidden = NO;
        
        __weak typeof(self)weakSelf = self;
        [view setPhoneBlock:^{
            [weakSelf JudgeAddressBookPower];
        }];
        
        NSString *title = @"";
        NSString *content = @"";
        if (model.contactType == 1) {
            title = @"已为您复制QQ号";
            content = @"前往QQ添加>";
        }else if(model.contactType == 2){
            title = @"已为您复制微信号";
            content = @"前往微信添加>";
        }else{
            title = @"已为您复制手机号>";
            content = @"前往手机通讯录添加";
        }
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = model.contact;
        view.titleLabel.text = title;
        view.btnLabel.text = content;
        CAGradientLayer *confirmLayer = [PTTool customLayer:view.confirmBtn haveCorner:YES];
        [view.confirmBtn.layer addSublayer:confirmLayer];
    }else{
        PTLoginViewController *loginVC = [[PTLoginViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    
}

#pragma mark - data -
- (void)requestDetailAction
{
    __weak typeof(self)weakSelf = self;
    [PartTimeDetailModel requestDetailPartTimeWithUserId:1 aid:self.ptId completeBlock:^(id obj) {
        
        PartTimeDetailModel *model = (PartTimeDetailModel *)obj;
        weakSelf.detailModel = model;
        [weakSelf setDetailDataWithModel:model];
        if (model.isJoin) {
            weakSelf.confirmBtn.backgroundColor = [PTTool colorFromHexRGB:@"#b2b2b2"];
            weakSelf.confirmLabel.text = @"已报名";
            [weakSelf.confirmLayer removeFromSuperlayer];
        }
        
    } faileBlock:^(id error) {
        
    }];
}

- (void)setDetailDataWithModel:(PartTimeDetailModel *)detailModel
{
    self.model = detailModel.model;
    [self.tableView reloadData];
}

#pragma mark ---- 调用系统通讯录
- (void)JudgeAddressBookPower {
    ///获取通讯录权限，调用系统通讯录
    [self CheckAddressBookAuthorization:^(bool isAuthorized , bool isUp_ios_9) {
        if (isAuthorized) {
            [self callAddressBook:isUp_ios_9];
        }else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }];
}

- (void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized , bool isUp_ios_9))block {
    if (Is_up_Ios_9) {
        CNContactStore * contactStore = [[CNContactStore alloc]init];
        if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * __nullable error) {
                if (error) {
                    NSLog(@"Error: %@", error);
                } else if (!granted) {
                    block(NO,YES);
                } else {
                    block(YES,YES);
                }
            }];
        } else if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
            block(YES,YES);
        } else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }else {
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        
        if (authStatus == kABAuthorizationStatusNotDetermined) {
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error) {
                        NSLog(@"Error: %@", (__bridge NSError *)error);
                    } else if (!granted) {
                        block(NO,NO);
                    } else {
                        block(YES,NO);
                    }
                });
            });
        }else if (authStatus == kABAuthorizationStatusAuthorized) {
            block(YES,NO);
        }else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }
}  

- (void)callAddressBook:(BOOL)isUp_ios_9 {
    if (isUp_ios_9) {
        CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
        contactPicker.delegate = self;
        contactPicker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        [self presentViewController:contactPicker animated:YES completion:nil];
    } else {
        ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
        peoplePicker.peoplePickerDelegate = self;
        [self presentViewController:peoplePicker animated:YES completion:nil];
    }
}

#pragma mark -- CNContactPickerDelegate  进入系统通讯录页面 --
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    CNPhoneNumber *phoneNumber = (CNPhoneNumber *)contactProperty.value;
    [self dismissViewControllerAnimated:YES completion:^{
        /// 联系人
        NSString *text1 = [NSString stringWithFormat:@"%@%@",contactProperty.contact.familyName,contactProperty.contact.givenName];
        /// 电话
        NSString *text2 = phoneNumber.stringValue;
        //text2 = [text2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"联系人：%@, 电话：%@",text1,text2);
    }];
}

#pragma mark -- ABPeoplePickerNavigationControllerDelegate   进入系统通讯录页面 --
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef,index);
    CFStringRef anFullName = ABRecordCopyCompositeName(person);
    
    [self dismissViewControllerAnimated:YES completion:^{
        /// 联系人
        NSString *text1 = [NSString stringWithFormat:@"%@",anFullName];
        /// 电话
        NSString *text2 = (__bridge NSString*)value;
        //text2 = [text2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"联系人：%@, 电话：%@",text1,text2);
    }];
}

@end
