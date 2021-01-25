//
//  LiveRoomChatTableViewCell.m
//  StandardApplication
//
//  Created by DTiOS on 2020/9/6.
//  Copyright © 2020 DTiOS. All rights reserved.
//

#import "LiveRoomChatTableViewCell.h"
#import <YYText.h>
#import <NSAttributedString+YYText.h>
#import "MacroDefine.h"

@interface LiveRoomChatTableViewCell ()
@property (strong, nonatomic) YYLabel *liveChatLabel;
@end

@implementation LiveRoomChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.liveChatLabel];
        
    }
    return self;
}

- (void)setModel:(LiveRoomChatModel *)model
{
    _model = model;
    [self setImageNameMessage:_model];
}

- (void)setImageNameMessage:(LiveRoomChatModel *)messageModel
{
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:12];
    {
        //image
        UIImageView *avaterImageView = [[UIImageView alloc]init];
        [self setImage:avaterImageView url:messageModel.senderAvatar defaultIconName:@"defaultImg2"];
        avaterImageView.size = CGSizeMake(18, 18);
        avaterImageView.layer.cornerRadius = 9;
        avaterImageView.layer.masksToBounds = YES;
        avaterImageView.contentMode = UIViewContentModeScaleAspectFill;
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:avaterImageView contentMode:UIViewContentModeScaleAspectFill attachmentSize:CGSizeMake(18, 18) alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text appendAttributedString:attachText];
        
        //间距6
        [text appendAttributedString:[self attachTextSpaceWidth:6]];
        
        //姓名
        NSString *nameStr = [NSString stringWithFormat:@"%@：",messageModel.senderName];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:nameStr attributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#98999A"]}]];
        
        //间距2
        [text appendAttributedString:[self attachTextSpaceWidth:2]];
        
        //消息
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:NONullString(messageModel.content.text) attributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#222222"],NSParagraphStyleAttributeName:paragraphStyle}]];
    }
    text.yy_font = font;
    
    // 由于展示的时候需要距离上下有距离，预估计加20
    CGFloat liveChatHeight = [self calculateRowWidth:text].size.height + 20;
    _model.cellHeight = liveChatHeight;
    
    // 由于liveChatLabel  UIEdgeInsets 左右边距，计算时减20，展示的时候需要加20
    CGFloat liveChatWidth = [self calculateRowWidth:text].size.width + 20;
    self.liveChatLabel.frame = CGRectMake(16, 5, liveChatWidth, liveChatHeight);
    self.liveChatLabel.attributedText = text;
    
}

- (CGRect)calculateRowWidth:(NSMutableAttributedString *)string {
    // 由于liveChatLabel  UIEdgeInsets 左右边距，计算时需减20
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 32 - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading context:nil];
    return rect;
}

- (YYLabel *)liveChatLabel
{
    if (!_liveChatLabel) {
        _liveChatLabel = [YYLabel new];
        _liveChatLabel.userInteractionEnabled = YES;
        _liveChatLabel.numberOfLines = 0;
        _liveChatLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _liveChatLabel.frame = CGRectMake(16, 5, SCREEN_WIDTH - 32, 30);
        _liveChatLabel.backgroundColor = [UIColor whiteColor];
        _liveChatLabel.layer.cornerRadius = 15;
        _liveChatLabel.layer.masksToBounds = YES;
        _liveChatLabel.textContainerInset = UIEdgeInsetsMake(0, 6, 0, 14);
    }
    return _liveChatLabel;
}

- (NSMutableAttributedString *)attachTextSpaceWidth:(CGFloat)width
{
    NSMutableAttributedString *attachTextSpace = [NSMutableAttributedString yy_attachmentStringWithContent:[UIView new] contentMode:UIViewContentModeCenter width:width ascent:0 descent:0];
    return attachTextSpace;
}

-(void)setImage:(UIImageView*)imageView url:(NSString*)imageUrl defaultIconName:( NSString * )defaultIconName {
    
    UIImage *defaultImage;
    if (!IsStrEmpty(defaultIconName))
    {
        defaultImage = [UIImage imageNamed:defaultIconName];
    }
    if (IsNilOrNull(imageUrl)) {
        imageView.image = defaultImage;
    } else {
        if(defaultImage)
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:defaultImage options:SDWebImageLowPriority|SDWebImageRetryFailed|SDWebImageScaleDownLargeImages|SDWebImageRefreshCached];
        }
        else
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil options:SDWebImageLowPriority|SDWebImageRetryFailed|SDWebImageScaleDownLargeImages|SDWebImageRefreshCached];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
