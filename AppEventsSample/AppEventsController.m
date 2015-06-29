//
//  SecondViewController.m
//  platformTest
//
//  Created by Pu Guannan on 4/7/15.
//  Copyright (c) 2015 Pu Guannan. All rights reserved.
//

#import "AppEventsController.h"
#import "PickerViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppEventsController ()
@end

@implementation AppEventsController
{
}

+(NSString*) getEventName:(AppEvent) appEvent
{
    switch (appEvent) {
        // common & games
        case AppEventRegistration:
            return FBSDKAppEventNameCompletedRegistration;
            break;
        case AppEventTutorial:
            return FBSDKAppEventNameCompletedTutorial;
            break;
        case AppEventPurchase:
            return FBSDKAppEventNameInitiatedCheckout;
            break;
        case AppEventPlayerLevel:
            return FBSDKAppEventNameAchievedLevel;
            break;
        case AppEventAchievement:
            return FBSDKAppEventNameUnlockedAchievement;
            break;
        case AppEventSpendHardCurrency:
            return FBSDKAppEventNameSpentCredits;
            break;
        case AppEventMapLevel:
            return @"Map Level Completed";
            break;
        case AppEventSpendSoftCurrency:
            return @"Spend Soft Currency";
            break;
            
        //apps
        case AppEventSearched:
            return FBSDKAppEventNameSearched;
            break;
        case AppEventAddedPaymentInfo:
            return FBSDKAppEventNameAddedPaymentInfo;
            break;
        case AppEventAddedToCart:
            return FBSDKAppEventNameAddedToCart;
            break;
        case AppEventAddedToWishlist:
            return FBSDKAppEventNameAddedToWishlist;
            break;
        case AppEventRated:
            return FBSDKAppEventNameRated;
            break;
        case AppEventViewedContent:
            return FBSDKAppEventNameViewedContent;
            break;
            
        default:
            return @"Invalid event name";
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadButtons];
}

- (void)loadButtons
{
}

- (void)addButton:(AppEvent)appEvent buttonText:(NSString*)text
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:text forState:UIControlStateNormal];
    CGRect viewRect = _contentView.frame;
    
    button.frame = CGRectMake(viewRect.size.width / 2.0 - 80.0, _lastY, 160.0, 40.0);
    _lastY += 50.0;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor brownColor];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:10.0f];
    button.tag = appEvent;
    [[self contentView] addSubview:button];
}

- (IBAction)handleEvent:(id)sender
{
    _lastButtonTag = [sender tag];
    [self performSegueWithIdentifier:@"appevent" sender:self];
}

- (void) buttonClicked:(UIButton*)sender
{
    _lastButtonTag = [sender tag];
    [self performSegueWithIdentifier:@"appevent" sender:self];
}

- (IBAction)showAppEventsDialog:(UIStoryboardSegue *)segue
{
    NSString *identifier = segue.identifier;
    
    PickerViewController *vc = segue.sourceViewController;
    NSDictionary *selectedContent = [vc getSelectedContent];
    NSMutableDictionary *properties = [selectedContent mutableCopy];
    
    switch (_lastButtonTag) {
        /*
         * Purchase event will be logged automatically if automatic toggle is turned on in Facebook app settings
         * Please check your implementation to make sure purchase events are not logged more than once
         */
        case AppEventPurchase:
        {
            double value = [[properties valueForKey:@"Value"] doubleValue];
            [properties removeObjectForKey:@"Value"];
            
            [FBSDKAppEvents logEvent:vc.eventName valueToSum:value parameters:properties];
            
            if ([identifier isEqualToString:@"exitFromCancel"])
            {
                /*
                 * log purchase cancel event will be logged automatically if you toggle on the switch for payment in app settings
                 * you need to manually this event here if the setting is off
                 */
                [FBSDKAppEvents logEvent:@"fb_mobile_purchase_failed" valueToSum:value parameters:properties];
            }
            else
            {
                /*
                 * you can also log purchase using "fb_mobile_purchase"
                 * [FBSDKAppEvents logEvent:@"fb_mobile_purchase" valueToSum:value parameters:properties];
                 */
                NSString *currency = [properties valueForKey:FBSDKAppEventParameterNameCurrency];
                [properties removeObjectForKey:FBSDKAppEventParameterNameCurrency];
                [FBSDKAppEvents logPurchase:value currency:currency parameters:properties];
            }
        }
            break;
        
        default:
        {
            if ([properties objectForKey:@"Value"] != nil)
            {
                double value = [[properties valueForKey:@"Value"] doubleValue];
                [properties removeObjectForKey:@"Value"];
                [FBSDKAppEvents logEvent:vc.eventName valueToSum:value parameters:properties];
            }
            else
                [FBSDKAppEvents logEvent:vc.eventName parameters:properties];

        }
            break;
    }

    _eventStatusLabel.text = [NSString stringWithFormat:@"Event %@ logged.", vc.eventName];
}

@end
