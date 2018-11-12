

#import "CommentCell.h"
#import "UIImage+WebP.h"
#import "UIImageView+WebCache.h"
#import "LikeAnimationView.h"
#import "DateTools.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2;
    
    self.separatorLine.backgroundColor = [UIColor lightGrayColor];
    
//    self.separatorLine.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCommentModel:(NSDictionary *)commentModel
{
    _commentModel = commentModel;
    
    self.contentLabel.text = commentModel[@"content"];
    
    self.userNameLabel.text = commentModel[@"nick"];
    
    self.starView.value = [commentModel[@"score"] doubleValue] / 2.0;
    
    [self.likeButton setTitle:[NSString stringWithFormat:@"%@",commentModel[@"approve"]] forState:UIControlStateNormal];
    
    NSDate *dateTime = [NSDate dateWithString:commentModel[@"time"] formatString:@"yyyy-MM-dd hh:mm"];
    
    NSString *timeStr = [NSDate timeAgoSinceDate:dateTime];
    
    self.timeLabel.text = timeStr;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:commentModel[@"avatarurl"]]];
    
}
- (IBAction)likeButtonClick:(UIButton *)sender {
    
    if (sender.isSelected) {
        
        [sender setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [sender setImage:[UIImage imageNamed:@"likeUp"] forState:UIControlStateNormal];
        
        NSInteger currentApprove = [sender.currentTitle integerValue]-1;
        
        [sender setTitle:[NSString stringWithFormat:@"%ld",(long)currentApprove] forState:UIControlStateNormal];

        
    }else{
        
        LikeAnimationView *likeView = [[LikeAnimationView alloc]initWithFrame:self.likeButton.frame];
        [self addSubview:likeView];
        [likeView startAnimation];

        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

        [sender setImage:[UIImage imageNamed:@"likeUp_hightLight"] forState:UIControlStateNormal];
        
        NSInteger currentApprove = [sender.currentTitle integerValue]+1;
        
        [sender setTitle:[NSString stringWithFormat:@"%ld",(long)currentApprove] forState:UIControlStateNormal];

    }
    
    sender.selected = !sender.isSelected;
    
    
    
}


-(void)setSeparatorLineColor:(UIColor *)separatorLineColor
{
    _separatorLineColor = separatorLineColor;
    
    self.separatorLine.backgroundColor = separatorLineColor;
}

@end
