//
//  SecondViewController.m
//  platformTest
//
//  Created by Pu Guannan on 4/7/15.
//  Copyright (c) 2015 Pu Guannan. All rights reserved.
//

#import "AppEventsControllerGame.h"
#import "PickerViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppEventsControllerGame ()
@property (nonatomic, strong) IBOutlet UILabel *eventStatusLabel;
@end

@implementation AppEventsControllerGame
{
    AppEvent _lastButtonTag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleEvent:(id)sender
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
        case AppEventPurchase:
        {
            double value = [[properties valueForKey:@"Value"] doubleValue];
            [properties removeObjectForKey:@"Value"];
            
            [FBSDKAppEvents logEvent:FBSDKAppEventNameInitiatedCheckout valueToSum:value parameters:properties];
            
            if ([identifier isEqualToString:@"exitFromCancel"])
            {
                // log purchase cancel
                [FBSDKAppEvents logEvent:@"fb_mobile_purchase_failed" valueToSum:value parameters:properties];
            }
            else
            {
                NSString *currency = [properties valueForKey:FBSDKAppEventParameterNameCurrency];
                [properties removeObjectForKey:FBSDKAppEventParameterNameCurrency];
                [FBSDKAppEvents logPurchase:value currency:currency parameters:properties];
            }
        }
            break;
            
        case AppEventRegistration:
        {
            [FBSDKAppEvents logEvent:FBSDKAppEventNameCompletedRegistration parameters:properties];
        }
            break;
            
        case AppEventAchievement:
        {
            [FBSDKAppEvents logEvent:FBSDKAppEventNameUnlockedAchievement parameters:properties];
        }
            break;
            
        case AppEventSpendCredits:
        {
            double value = [[properties valueForKey:@"Value"] doubleValue];
            [properties removeObjectForKey:@"Value"];
            [FBSDKAppEvents logEvent:FBSDKAppEventNameSpentCredits valueToSum:value parameters:properties];
        }
            break;
            
        default:
            break;
    }

    _eventStatusLabel.text = [NSString stringWithFormat:@"Event %@ logged.", vc.eventName];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PickerViewController *vc = segue.destinationViewController;

    switch (_lastButtonTag) {
        case AppEventRegistration:
        {
            NSArray *content = @[@{FBSDKAppEventParameterNameRegistrationMethod: @"Facebook",
                                   FBSDKAppEventParameterNameDescription: @"Facebook"},
                                 @{FBSDKAppEventParameterNameRegistrationMethod: @"Google Play",
                                   FBSDKAppEventParameterNameDescription: @"Google Play"},
                                 @{FBSDKAppEventParameterNameRegistrationMethod: @"Google+",
                                   FBSDKAppEventParameterNameDescription: @"Google+"},
                                 @{FBSDKAppEventParameterNameRegistrationMethod: @"Amazon",
                                   FBSDKAppEventParameterNameDescription: @"Amazon"},
                                 @{FBSDKAppEventParameterNameRegistrationMethod: @"App Store",
                                   FBSDKAppEventParameterNameDescription: @"App Store"},
                                 @{FBSDKAppEventParameterNameRegistrationMethod: @"Email",
                                   FBSDKAppEventParameterNameDescription: @"Email"},
                                 @{FBSDKAppEventParameterNameRegistrationMethod: @"Twitter",
                                   FBSDKAppEventParameterNameDescription: @"Twitter"}];
            [vc setEventName:FBSDKAppEventNameCompletedRegistration setContent: content];
        }
            break;
            
        case AppEventTutorial:
        {
            NSArray *content = @[@{FBSDKAppEventParameterNameContentID: @"1",
                                   FBSDKAppEventParameterNameDescription: @"Tutorial Step 1"},
                                 @{FBSDKAppEventParameterNameContentID: @"2",
                                   FBSDKAppEventParameterNameDescription: @"Tutorial Step 2"},
                                 @{FBSDKAppEventParameterNameContentID: @"3",
                                   FBSDKAppEventParameterNameDescription: @"Tutorial Step 3"},
                                 @{FBSDKAppEventParameterNameContentID: @"4",
                                   FBSDKAppEventParameterNameDescription: @"Tutorial Step 4"},
                                 @{FBSDKAppEventParameterNameContentID: @"5",
                                   FBSDKAppEventParameterNameDescription: @"Tutorial Step 5"}];
            [vc setEventName:FBSDKAppEventNameCompletedTutorial setContent: content];
        }
            break;
            
        case AppEventPurchase:
        {
            NSArray* content = @[@{FBSDKAppEventParameterNameContentID: @"10001",
                                   FBSDKAppEventParameterNameDescription: @"$1.99 - 100 gems",
                                   FBSDKAppEventParameterNameCurrency: @"USD",
                                   @"Value":@1.99},
                                 @{FBSDKAppEventParameterNameContentID: @"10002",
                                   FBSDKAppEventParameterNameDescription: @"$9.99 - 600 gems",
                                   FBSDKAppEventParameterNameCurrency: @"USD",
                                   @"Value":@9.99},
                                 @{FBSDKAppEventParameterNameContentID: @"10003",
                                   FBSDKAppEventParameterNameDescription: @"$19.99 - 1300 gems",
                                   FBSDKAppEventParameterNameCurrency: @"USD",
                                   @"Value":@19.99},
                                 @{FBSDKAppEventParameterNameContentID: @"10004",
                                   FBSDKAppEventParameterNameDescription: @"$49.99 - 3500 gems",
                                   FBSDKAppEventParameterNameCurrency: @"USD",
                                   @"Value":@49.99},
                                 @{FBSDKAppEventParameterNameContentID: @"10005",
                                   FBSDKAppEventParameterNameDescription: @"$99.99 - 7200 gems",
                                   FBSDKAppEventParameterNameCurrency: @"USD",
                                   @"Value":@99.99},
                                 ];
            [vc setEventName:FBSDKAppEventNameInitiatedCheckout setContent: content];
        }
            break;
        case AppEventLevel: //player level
        {
            NSArray *content = @[@{FBSDKAppEventParameterNameLevel: @"1",
                                   FBSDKAppEventParameterNameDescription: @"Player level 1"},
                                 @{FBSDKAppEventParameterNameLevel: @"2",
                                   FBSDKAppEventParameterNameDescription: @"Player level 2"},
                                 @{FBSDKAppEventParameterNameLevel: @"3",
                                   FBSDKAppEventParameterNameDescription: @"Player level 3"},
                                 @{FBSDKAppEventParameterNameLevel: @"4",
                                   FBSDKAppEventParameterNameDescription: @"Player level 4"},
                                 @{FBSDKAppEventParameterNameLevel: @"5",
                                   FBSDKAppEventParameterNameDescription: @"Player level 5"}];
            [vc setEventName:FBSDKAppEventParameterNameLevel setContent: content];
        }
            break;
        case AppEventAchievement:
        {
            NSArray* content = @[@{FBSDKAppEventParameterNameContentID: @"1001",
                                   FBSDKAppEventParameterNameDescription: @"Killed Boss Dragon"},
                                 @{FBSDKAppEventParameterNameContentID: @"1002",
                                   FBSDKAppEventParameterNameDescription: @"Have five builders"},
                                 @{FBSDKAppEventParameterNameContentID: @"1003",
                                   FBSDKAppEventParameterNameDescription: @"Gather 1000000 gold"},
                                 @{FBSDKAppEventParameterNameContentID: @"1004",
                                   FBSDKAppEventParameterNameDescription: @"Spent 10,000 gems in one day"},
                                 @{FBSDKAppEventParameterNameContentID: @"1005",
                                   FBSDKAppEventParameterNameDescription: @"Shared an app event"}];
            [vc setEventName:FBSDKAppEventNameUnlockedAchievement setContent: content];
        }
            break;
        case AppEventSpendCredits:
        {
            NSArray* content = @[@{FBSDKAppEventParameterNameContentID: @"20001",
                                   FBSDKAppEventParameterNameDescription: @"150 Gems - Green Armor",
                                   FBSDKAppEventParameterNameContentType: @"Hard Currency",
                                   @"Value":@150},
                                 @{FBSDKAppEventParameterNameContentID: @"20002",
                                   FBSDKAppEventParameterNameDescription: @"350 Gems - Lightning Shoe",
                                   FBSDKAppEventParameterNameContentType: @"Hard Currency",
                                   @"Value":@350},
                                 @{FBSDKAppEventParameterNameContentID: @"20003",
                                   FBSDKAppEventParameterNameDescription: @"200 Gems - Magic Helm",
                                   FBSDKAppEventParameterNameContentType: @"Hard Currency",
                                   @"Value":@200},
                                 @{FBSDKAppEventParameterNameContentID: @"20004",
                                   FBSDKAppEventParameterNameDescription: @"900 Gems - Crystal Sword",
                                   FBSDKAppEventParameterNameContentType: @"Hard Currency",
                                   @"Value":@900},
                                 @{FBSDKAppEventParameterNameContentID: @"20005",
                                   FBSDKAppEventParameterNameDescription: @"450 Gems - Gold Shield",
                                   FBSDKAppEventParameterNameContentType: @"Hard Currency",
                                   @"Value":@450},
                                 ];
            [vc setEventName:FBSDKAppEventNameSpentCredits setContent: content];
        }
            break;
        case AppEventCustomEvents:
            break;
        default:
            break;
    }
}

@end
