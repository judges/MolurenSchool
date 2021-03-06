//
//  TdTableViewCell.m
//  MolurenSchool
//
//  Created by zheng lingshan on 15/4/13.
//  Copyright (c) 2015年 TeamDQ. All rights reserved.
//

#import "TdTableViewCell.h"

#import "UIImageView+RZWebImage.h"

#define CELL_HEIGHT self.contentView.frame.size.height
#define CELL_WIDTH self.contentView.frame.size.width

@implementation TdTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialization code
        _userHead =[[UIImageView alloc]initWithFrame:CGRectZero];
        _bubbleBg =[[UIImageView alloc]initWithFrame:CGRectZero];
        _messageConent=[[UILabel alloc]initWithFrame:CGRectZero];
        _headMask =[[UIImageView alloc]initWithFrame:CGRectZero];
        _chatImage =[[UIImageView alloc]initWithFrame:CGRectZero];
        
        [_messageConent setBackgroundColor:[UIColor clearColor]];
        [_messageConent setFont:[UIFont systemFontOfSize:15]];
        [_messageConent setNumberOfLines:20];
        [self.contentView addSubview:_bubbleBg];
        [self.contentView addSubview:_userHead];
        [self.contentView addSubview:_headMask];
        [self.contentView addSubview:_messageConent];
        [self.contentView addSubview:_chatImage];
        // [_chatImage setBackgroundColor:[UIColor redColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        //[_headMask setImage:[[UIImage imageNamed:@"TestUserPortrait"]stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [_headMask setImage:[UIImage imageNamed:@"TestUserPortrait"]];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
    
    
    NSString *orgin=_messageConent.text;
    CGSize textSize=[orgin sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake((320-HEAD_SIZE-3*INSETS-40), TEXT_MAX_HEIGHT) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    switch (_msgStyle) {
        case TdMessageCellStyleMe:
        {
            [_chatImage setHidden:YES];
            [_messageConent setHidden:NO];
            [_messageConent setFrame:CGRectMake(CELL_WIDTH-INSETS*2-HEAD_SIZE-textSize.width-15, (CELL_HEIGHT-textSize.height)/2, textSize.width, textSize.height)];
            [_userHead setFrame:CGRectMake(CELL_WIDTH-INSETS-HEAD_SIZE, INSETS,HEAD_SIZE , HEAD_SIZE)];
            
            [_bubbleBg setImage:[[UIImage imageNamed:@"SenderBubbleBgImg"]stretchableImageWithLeftCapWidth:20 topCapHeight:30]];
            _bubbleBg.frame=CGRectMake(_messageConent.frame.origin.x-15, _messageConent.frame.origin.y-12, textSize.width+30, textSize.height+30);
        }
            break;
        case TdMessageCellStyleOther:
        {
            [_chatImage setHidden:YES];
            [_messageConent setHidden:NO];
            [_userHead setFrame:CGRectMake(INSETS, INSETS,HEAD_SIZE , HEAD_SIZE)];
            [_messageConent setFrame:CGRectMake(2*INSETS+HEAD_SIZE+15, (CELL_HEIGHT-textSize.height)/2, textSize.width, textSize.height)];
            
            
            [_bubbleBg setImage:[[UIImage imageNamed:@"ReceiverBubbleBgImg"]stretchableImageWithLeftCapWidth:20 topCapHeight:30]];
            _bubbleBg.frame=CGRectMake(_messageConent.frame.origin.x-15, _messageConent.frame.origin.y-12, textSize.width+30, textSize.height+30);
        }
            break;
        case TdMessageCellStyleMeWithImage:
        {
            //[_messageConent setFrame:CGRectMake(CELL_WIDTH-INSETS*2-HEAD_SIZE-textSize.width-15, (CELL_HEIGHT-textSize.height)/2, textSize.width, textSize.height)];
            [_chatImage setHidden:NO];
            [_messageConent setHidden:YES];
            [_chatImage setFrame:CGRectMake(CELL_WIDTH-INSETS*2-HEAD_SIZE-115, (CELL_HEIGHT-100)/2, 100, 100)];
            [_userHead setFrame:CGRectMake(CELL_WIDTH-INSETS-HEAD_SIZE, INSETS,HEAD_SIZE , HEAD_SIZE)];
            
            [_bubbleBg setImage:[[UIImage imageNamed:@"SenderBubbleBgImg"]stretchableImageWithLeftCapWidth:20 topCapHeight:30]];
            _bubbleBg.frame=CGRectMake(_chatImage.frame.origin.x-15, _chatImage.frame.origin.y-12, 100+30, 100+30);
        }
            break;
        case TdMessageCellStyleOtherWithImage:
        {
            [_chatImage setHidden:NO];
            [_messageConent setHidden:YES];
            [_chatImage setFrame:CGRectMake(2*INSETS+HEAD_SIZE+15, (CELL_HEIGHT-100)/2,100,100)];
            [_userHead setFrame:CGRectMake(INSETS, INSETS,HEAD_SIZE , HEAD_SIZE)];
            
            [_bubbleBg setImage:[[UIImage imageNamed:@"ReceiverBubbleBgImg"]stretchableImageWithLeftCapWidth:20 topCapHeight:30]];
            
            _bubbleBg.frame=CGRectMake(_chatImage.frame.origin.x-15, _chatImage.frame.origin.y-12, 100+30, 100+30);
            
        }
            break;
        default:
            break;
    }
    
    
    _headMask.frame=CGRectMake(_userHead.frame.origin.x-3, _userHead.frame.origin.y-1, HEAD_SIZE+6, HEAD_SIZE+6);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)setMessageObject:(TdMessage*)aMessage
{
    [_messageConent setText:aMessage.messageContent];
}
-(void)setHeadImage:(NSURL*)headImage tag:(int)aTag
{
    [_userHead setTag:aTag];
    [_userHead setWebImage:headImage placeHolder:Nil downloadFlag:aTag];
}

-(void)setHeadImageTest{
    //[_userHead setImage:[UIImage imageNamed:@"DefaultUserPortrait"]];
}

-(void)setChatImage:(NSURL *)chatImage tag:(int)aTag
{
    [_chatImage setTag:aTag];
    [_chatImage setWebImage:chatImage placeHolder:Nil downloadFlag:aTag];
}

@end