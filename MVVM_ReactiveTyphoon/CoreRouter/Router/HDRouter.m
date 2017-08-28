



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


// Controllers Protocol
#import "HDLoginVCPrtcl.h"
#import "HDWorkerTVCPrtcl.h"
#import "HDDetailVCPrtcl.h"
#import "HDPsychedelicDetailTVCPrtcl.h"


// Typhoon Fabric
#import "HDLoginAndRegistrationStoriesAssembly.h" // HDLoginVC
#import "HDWorkerStoriesAssembly.h"               // HDWorkerTVC
#import "HDDetailStoriesAssembly.h"               // HDDetailVC
#import "HDPscychedelicDetailStoriesAssembly.h"   // HDPsychedelicDetailTVC

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
    /*
    HDLoginVC* vc = [[HDLoginVC alloc] init];
    vc.vmAccountsData       = [[HDAccountsDataViewModel alloc] init];
    
    [HDRouter setToRootView:vc andAnimationOptions:UIViewAnimationOptionTransitionFlipFromLeft];
    */
    
    HDLoginAndRegistrationStoriesAssembly* factory = [[HDLoginAndRegistrationStoriesAssembly new] activated];
    id <HDLoginVCPrtcl> vc = [factory getHDLoginVC];
   
    [HDRouter setToRootView:(UIViewController*) vc andAnimationOptions:UIViewAnimationOptionTransitionFlipFromLeft];
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
    /*
    HDDetailStoriesAssembly* factory = [[HDDetailStoriesAssembly new] activated];
    id <HDDetailVCPrtcl> vc = [factory getHDDetailVCWithLinkOnFullCV:link];
    */
    
    HDDetailVC* vc = [HDDetailVC new];
    vc.vmWorkerDetail = [[HDWorkerDetailViewModel alloc] initWithLinkOnFull_CV_Model: link];
    
    
    if ([self haveControllerForMenuInMemory]){
        [HDRouter pushTo:(UIViewController*)vc inNavContr:self.mainNavContr];
    }
}

- (void) openPsychedelicDetailTVC:(HDWorkerFull*) workerModel
{
    /*
    HDListOfPsychedelicWorkersTableViewModel* vm = [[HDListOfPsychedelicWorkersTableViewModel alloc] initWithWorker:workerModel];
    
    HDPsychedelicDetailTVC* vc = [[HDPsychedelicDetailTVC alloc] initWithVM:vm];
    */
    HDPscychedelicDetailStoriesAssembly* factory = [[HDPscychedelicDetailStoriesAssembly new] activated];
    id<HDPsychedelicDetailTVCPrtcl> vc = [factory getHDPsychedelicDetailTVC:workerModel];
    
    if ([self haveControllerForMenuInMemory]){
        [HDRouter pushTo:(UIViewController*)vc inNavContr:self.mainNavContr];
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
    HDWorkerStoriesAssembly* factory = [[HDWorkerStoriesAssembly new] activated];
    id <HDWorkerTVCPrtcl> vc = [factory getHDWorkerTVC];
    self.mainWorkersTVC = (HDWorkerTVC*)vc;
    
    self.mainNavContr = [[UINavigationController alloc] initWithRootViewController: _mainWorkersTVC];
    [self setLightStyleForUINavigationController:self.mainNavContr];
}

- (void) setLightStyleForUINavigationController:(UINavigationController*) navContr
{
    navContr.navigationBar.barTintColor = [UIColor lightGrayColor];
    navContr.navigationBar.tintColor = [UIColor whiteColor];
    [navContr.navigationBar setTitleTextAttributes:  @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                NSFontAttributeName:[UIFont fontWithName:@"Avenir Next" size:18]}];
}

- (void) removeFromMemoryControllersForMenu
{
    self.mainWorkersTVC = nil;
    self.mainNavContr   = nil;
}


@end
