//
//  LiveRoomChatModel.h
//  StandardApplication
//
//  Created by DTiOS on 2020/9/8.
//  Copyright © 2020 DTiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveRoomChatContentModel : NSObject
@property (retain, nonatomic) NSString *id;   // 回撤消息id
@property (retain, nonatomic) NSString *text;  // 评论内容
@end

@interface LiveRoomChatModel : NSObject
@property (retain, nonatomic) NSString *senderAvatar;
@property (retain, nonatomic) NSString *eventType;
@property (retain, nonatomic) NSString *type;
@property (retain, nonatomic) NSString *liveId;
@property (retain, nonatomic) NSString *id;  // 消息唯一id
@property (strong, nonatomic) LiveRoomChatContentModel *content;
@property (retain, nonatomic) NSString *senderName;

@property (assign, nonatomic) CGFloat cellHeight;
@property (retain, nonatomic) NSString *noticeStr;  //标记是notice

@property (strong, nonatomic) NSString *joinRoomStr;  //标记是否是进入直播间的组装消息  竖屏的时候用
@end

//"blockState": 0,
//"auditor": "",
//"senderAvatar": "http://mediatestcdn.wdit.com.cn/3765.png",
//"eventType": "PUBLIC_COMMENT",
//"type": "CHAT",
//"liveId": "35b2f0040dc24032929bea27e7ef161a",
//"content": {
//    "msg": "你在我"
//},
//"auditState": 1,
//"senderName": "师奶撒手",
//"createTime": "2020-09-08 14:56:31",
//"auditTime": "2020-09-08 14:56:35",
//"sender": "",
//"deleteTime": "",
//"blockTime": "",
//"id": "636146baeb2048baae5f096207a7c213",
//"commentRule": 0,
//"deleteState": 0

NS_ASSUME_NONNULL_END
