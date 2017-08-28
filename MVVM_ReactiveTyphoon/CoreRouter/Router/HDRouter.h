// Base Router Implemetation
#import "CoreRouter.h"
#import <NYTPhotoViewer/NYTPhoto.h>


//Controllers
@class HDLoginVC;
@class HDWorkerTVC;
@class HDDetailVC;
@class HDPsychedelicDetailTVC;

//ViewModels
@class HDAccountsDataViewModel;
@class HDListOfWorkersTableViewModel;
@class HDListOfPsychedelicWorkersTableViewModel;
@class HDWorkerDetailViewModel;

//Models
@class HDWorkerFull;
@class NYTPhoto;

#import "CoreRouterProtocol.h"

@interface HDRouter : CoreRouter <CoreRouterProtocol>

//  Core
+ (HDRouter*) sharedRouter;

@property (nonatomic, strong) UINavigationController* mainNavContr;
@property (nonatomic, strong) HDWorkerTVC* mainWorkersTVC;

// Open Controllers
- (void) openApplication;
- (void) openLoginVC;
- (void) openWorkersTVC;
- (void) openDetailVCwithLinkOnFullCV:(NSString*) link;
- (void) openPsychedelicDetailTVC:(HDWorkerFull*) workerModel;
- (void) openNYTPhotovVCwithPhotoModel:(id<NYTPhoto>) photoModel;


#pragma mark - Routing method & propierties

// NSUserDefaults properties
@property (nonatomic, assign) BOOL isLogin;

- (void) setIsLoginInUserDefaults:(BOOL) isLogin;
- (BOOL) getIsLoginFromUserDefault;

@end
