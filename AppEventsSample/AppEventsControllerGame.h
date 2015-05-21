//
//  SecondViewController.h
//  platformTest
//
//  Created by Pu Guannan on 4/7/15.
//  Copyright (c) 2015 Pu Guannan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UiSwipeViewController.h"

typedef NS_ENUM(NSInteger, AppEvent) {
    AppEventRegistration,
    AppEventTutorial,
    AppEventPurchase,
    AppEventLevel,
    AppEventAchievement,
    AppEventSpendCredits,
    AppEventCustomEvents
};

@interface AppEventsControllerGame : UiSwipeViewController
@end

