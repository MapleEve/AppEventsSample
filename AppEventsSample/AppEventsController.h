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
    AppEventPlayerLevel,
    AppEventAchievement,
    AppEventSpendHardCurrency,
    AppEventMapLevel,
    AppEventSpendSoftCurrency,
    
    AppEventSearched,
    AppEventViewedContent,
    AppEventAddedToWishlist,
    AppEventAddedToCart,
    AppEventAddedPaymentInfo,
    AppEventRated,
};

@interface AppEventsController : UiSwipeViewController
@property (nonatomic, strong) IBOutlet UILabel *eventStatusLabel;
@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic) AppEvent lastButtonTag;
@property (nonatomic) float lastY;
+(NSString*) getEventName:(AppEvent) appEvent;
-(void) buttonClicked:(UIButton*)sender;
-(void)loadButtons;
-(void)addButton:(AppEvent)appEvent buttonText:(NSString*)text;
@end

