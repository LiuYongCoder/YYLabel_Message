//
//  ChatYYLabelViewController.m
//  YYLabel_message
//
//  Created by DTiOS on 2021/1/25.
//

#import "ChatYYLabelViewController.h"
#import "MacroDefine.h"
#import "LiveRoomChatTableViewCell.h"
#import "LiveRoomChatModel.h"

@interface ChatYYLabelViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (strong, nonatomic) NSMutableArray<LiveRoomChatModel *> *liveRoomChatArr;

@end

@implementation ChatYYLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *chatArr = [self getJsonObjectFromLocal:@"chat.json"];
    [self.liveRoomChatArr addObjectsFromArray:[LiveRoomChatModel mj_objectArrayWithKeyValuesArray:chatArr]];
    [self.chatTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.liveRoomChatArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiveRoomChatModel *model = _liveRoomChatArr[indexPath.section];
    return model.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiveRoomChatModel *model = _liveRoomChatArr[indexPath.section];
    static NSString *CellID = @"LiveRoomChatTableViewCell";
    LiveRoomChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[LiveRoomChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}

- (NSMutableArray<LiveRoomChatModel *> *)liveRoomChatArr
{
    if (!_liveRoomChatArr) {
        _liveRoomChatArr = [NSMutableArray array];
    }
    return _liveRoomChatArr;
}

- (id)getJsonObjectFromLocal:(NSString *)jsonStr
{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonStr ofType:nil];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    return jsonObject;
}

@end
