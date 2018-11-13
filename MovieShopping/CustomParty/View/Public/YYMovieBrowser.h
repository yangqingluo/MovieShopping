
#import <UIKit/UIKit.h>

#define kMovieBrowserHeight 125.0

@class YYMovieBrowser;
@protocol YYMovieBrowserDelegate <NSObject>

@optional
- (void)movieBrowser:(YYMovieBrowser *)movieBrowser didSelectItemAtIndex:(NSInteger)index;
- (void)movieBrowser:(YYMovieBrowser *)movieBrowser didEndScrollingAtIndex:(NSInteger)index;
- (void)movieBrowser:(YYMovieBrowser *)movieBrowser didChangeItemAtIndex:(NSInteger)index;

@end

@interface YYMovieBrowser : UIView

@property (nonatomic, assign, readwrite) id<YYMovieBrowserDelegate> delegate;
@property (nonatomic, assign, readonly)  NSInteger currentIndex;
@property (nonatomic, strong, readwrite) NSMutableArray *movies;

- (instancetype)initWithFrame:(CGRect)frame movies:(NSArray *)movies;
- (instancetype)initWithFrame:(CGRect)frame movies:(NSArray *)movies currentIndex:(NSInteger)index;
- (void)setCurrentMovieIndex:(NSInteger)index;
- (void)updateMovies:(NSArray *)movies;

@end
