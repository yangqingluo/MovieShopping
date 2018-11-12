

#import <UIKit/UIKit.h>

@interface FilmStillCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic ,copy) NSArray *photoURLs;
- (void)setStagePhotoWithPhotos:(NSArray *)photoURLs;

@end
