

#import "FilmStillCell.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

@interface FilmStillCell() {
    CGRect _tmpStageImageRect;
}

@end

@implementation FilmStillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setStagePhotoWithPhotos:(NSArray *)photoURLs {
    if (_photoURLs) {
        return;
    }
    
    _photoURLs = photoURLs;
    
    self.scrollView.contentSize = CGSizeMake(110*(photoURLs.count-1)+(photoURLs.count+1)*10 + 110, self.scrollView.frame.size.height);
    [photoURLs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSString *urlStr = [obj stringByReplacingOccurrencesOfString:@"w.h" withString:@"156.220"];
        
        NSString *imgURLStr = [[urlStr componentsSeparatedByString:@"@"]firstObject];
        UIImageView *stageImageView = [[UIImageView alloc]init];
        stageImageView.tag = idx;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleAvatarViewEvent:)];
        stageImageView.userInteractionEnabled = YES;
        [stageImageView addGestureRecognizer:tap];
        stageImageView.contentMode = UIViewContentModeScaleAspectFill;
        stageImageView.clipsToBounds = YES;
        
        stageImageView.frame = CGRectMake(110 * idx + (idx + 1) * 10, 8, 110, 95);
        
        stageImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [stageImageView sd_setImageWithURL:[NSURL URLWithString:imgURLStr]];
        
        [self.scrollView addSubview:stageImageView];
        
    }];
}

- (void)handleAvatarViewEvent:(UIGestureRecognizer *)gesture {
    UIImageView *imageView = (UIImageView *)gesture.view;
    _tmpStageImageRect = [imageView convertRect:imageView.frame toView:nil];
}

@end
