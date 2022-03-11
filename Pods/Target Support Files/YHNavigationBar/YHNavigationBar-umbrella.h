#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "UIViewController+YHNavigation.h"
#import "YHNavigationBaseAnimated.h"
#import "YHNavigationController.h"
#import "YHNavigationDelegateObject.h"
#import "YHNavigationFullScreenPopGesture.h"
#import "YHNavigationKit.h"
#import "YHNavigationScaleAnimated.h"
#import "YHNavigationTransitionAnimated.h"

FOUNDATION_EXPORT double YHNavigationBarVersionNumber;
FOUNDATION_EXPORT const unsigned char YHNavigationBarVersionString[];

