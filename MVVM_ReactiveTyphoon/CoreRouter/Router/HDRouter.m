



// https://stackoverflow.com/questions/18331751/storyboard-and-custom-init
#import "HDRouter.h"


// Controllers
#import "HDLoginVC.h"
#import "HDWorkerTVC.h"
#import "HDDetailVC.h"
#import "HDPsychedelicDetailTVC.h"
// From custom library
#import <NYTPhotoViewer/NYTPhotosViewController.h>

// ViewModels
#import "HDAccountsDataViewModel.h"
#import "HDListOfWorkersTableViewModel.h"
#import "HDWorkerDetailViewModel.h"
#import "HDListOfPsychedelicWorkersTableViewModel.h"

// Model
#import "HDWorkerFull.h"
#import "HDPhotoModel.h"

@implementation HDRouter

#pragma mark - Core

+ (HDRouter*) sharedRouter {
    
    static HDRouter* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HDRouter alloc] init];
        manager.window = [HDRouter getApplicationWindow];
    });
    return manager;
}


#pragma mark - Open Controllers

- (void) openApplication
{
    BOOL isLogin = [self getIsLoginFromUserDefault];
    
    if (!isLogin){
        [self openLoginVC];
    } else {
        [self openWorkersTVC];
    }
}


#pragma mark - Open Controllers

- (void) openLoginVC
{
    HDLoginVC* vc = [[HDLoginVC alloc] init];
    vc.vmAccountsData       = [[HDAccountsDataViewModel alloc] init];
    
    [HDRouter setToRootView:vc andAnimationOptions:UIViewAnimationOptionTransitionFlipFromLeft];
}


- (void) openWorkersTVC
{
    if (![self haveControllerForMenuInMemory]){
        [self initInMemoryControllersForMenu];
    }
    [HDRouter setToRootView:self.mainNavContr andAnimationOptions:UIViewAnimationOptionTransitionFlipFromRight];
}


- (void) openDetailVCwithLinkOnFullCV:(NSString*) link;
{
    // Вытащить linkOnCV
    HDDetailVC* vc = [HDDetailVC new];
    vc.vmWorkerDetail = [[HDWorkerDetailViewModel alloc] initWithLinkOnFull_CV_Model: link];
    
    if ([self haveControllerForMenuInMemory]){
        [HDRouter pushTo:vc inNavContr:self.mainNavContr];
    }
}

- (void) openPsychedelicDetailTVC:(HDWorkerFull*) workerModel
{
    HDListOfPsychedelicWorkersTableViewModel* vm = [[HDListOfPsychedelicWorkersTableViewModel alloc] initWithWorker:workerModel];
    
    HDPsychedelicDetailTVC* vc = [[HDPsychedelicDetailTVC alloc] initWithVM:vm];
    
    
    if ([self haveControllerForMenuInMemory]){
        [HDRouter pushTo:vc inNavContr:self.mainNavContr];
    }
}

- (void) openNYTPhotovVCwithPhotoModel:(id<NYTPhoto>) photoModel
{
    NYTPhotosViewController* photoVC = [[NYTPhotosViewController alloc] initWithPhotos:@[photoModel]];
    [HDRouter present:photoVC animated:YES];
}

#pragma mark - NSUserDefault

- (void) setIsLoginInUserDefaults:(BOOL) isLogin
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:[NSNumber numberWithBool:isLogin]  forKey:@"isLogin"];
}


- (BOOL) getIsLoginFromUserDefault
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud boolForKey:@"isLogin"];
}


#pragma mark - Helpers

- (BOOL) haveControllerForMenuInMemory
{
    if (_mainNavContr && _mainWorkersTVC)
        return YES;
    return NO;
}


- (void) initInMemoryControllersForMenu
{
    self.mainWorkersTVC = [[HDWorkerTVC alloc] init];
    self.mainWorkersTVC.vmListOfWorkersTableView = [[HDListOfWorkersTableViewModel alloc] init];
    self.mainNavContr = [[UINavigationController alloc] initWithRootViewController: _mainWorkersTVC];
    
    self.mainNavContr.navigationBar.barTintColor = [UIColor lightGrayColor];
    self.mainNavContr.navigationBar.tintColor = [UIColor whiteColor];
    [self.mainNavContr.navigationBar setTitleTextAttributes:  @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                NSFontAttributeName:[UIFont fontWithName:@"Avenir Next" size:18]}];
}


- (void) removeFromMemoryControllersForMenu
{
    self.mainWorkersTVC = nil;
    self.mainNavContr   = nil;
}


@end
