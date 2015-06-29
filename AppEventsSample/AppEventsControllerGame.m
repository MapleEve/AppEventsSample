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

@end

@implementation AppEventsControllerGame

- (void)loadButtons
{
    self.lastY = 0.0;
    [self addButton:AppEventRegistration buttonText:@"Registation"];
    [self addButton:AppEventTutorial buttonText:@"Tutorial"];
    [self addButton:AppEventPurchase buttonText:@"Purchase"];
    [self addButton:AppEventPlayerLevel buttonText:@"Level Achieved"];
    [self addButton:AppEventMapLevel buttonText:@"Map Complete"];
    [self addButton:AppEventAchievement buttonText:@"Achievement"];
    [self addButton:AppEventSpendHardCurrency buttonText:@"Spend Credits"];
    [self addButton:AppEventSpendSoftCurrency buttonText:@"Spend Soft Currency"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PickerViewController *vc = segue.destinationViewController;
    NSArray *content;

    switch ([self lastButtonTag]) {
        /*
         * provide description param for most app events you are logging, by doing this,
         * cross functional teams can easily look up the right param to use for strategy and marketing
         */
        case AppEventRegistration:
        {
            content = @[@{FBSDKAppEventParameterNameRegistrationMethod: @"R1001",
                          FBSDKAppEventParameterNameDescription: @"Facebook"},
                        @{FBSDKAppEventParameterNameRegistrationMethod: @"R1002",
                          FBSDKAppEventParameterNameDescription: @"Google Play"},
                        @{FBSDKAppEventParameterNameRegistrationMethod: @"R1003",
                          FBSDKAppEventParameterNameDescription: @"Google+"},
                        @{FBSDKAppEventParameterNameRegistrationMethod: @"R1004",
                          FBSDKAppEventParameterNameDescription: @"Amazon"},
                        @{FBSDKAppEventParameterNameRegistrationMethod: @"R1005",
                          FBSDKAppEventParameterNameDescription: @"Apple Game Center"},
                        @{FBSDKAppEventParameterNameRegistrationMethod: @"R1006",
                          FBSDKAppEventParameterNameDescription: @"Email"},
                        @{FBSDKAppEventParameterNameRegistrationMethod: @"R1009",
                          FBSDKAppEventParameterNameDescription: @"Guest"}];
        }
            break;
        
        /*
         * By logging tutorial steps, you can easily create funnel to check the conversion rate of
         * each tutorial steps. You can also create Cohorts between tutorial steps to know the how long
         * it takes your player to proceed in tutorial
         */
        case AppEventTutorial:
        {
            content = @[@{FBSDKAppEventParameterNameContentID: @"1",
                          FBSDKAppEventParameterNameDescription: @"Tutorial Step 1"},
                        @{FBSDKAppEventParameterNameContentID: @"2",
                          FBSDKAppEventParameterNameDescription: @"Tutorial Step 2"},
                        @{FBSDKAppEventParameterNameContentID: @"3",
                          FBSDKAppEventParameterNameDescription: @"Tutorial Step 3"},
                        @{FBSDKAppEventParameterNameContentID: @"4",
                          FBSDKAppEventParameterNameDescription: @"Tutorial Step 4"},
                        @{FBSDKAppEventParameterNameContentID: @"5",
                          FBSDKAppEventParameterNameDescription: @"Tutorial Step 5"}];
        }
            break;
            
        case AppEventPurchase:
        {
            /* 
             * explain here why player level is useful
             */
            content = @[@{FBSDKAppEventParameterNameContentID: @"10001",
                          FBSDKAppEventParameterNameDescription: @"$1.99 - 100 gems",
                          FBSDKAppEventParameterNameCurrency: @"USD",
                          @"PlayerLevel":@"10",
                          @"Value":@1.99},
                        @{FBSDKAppEventParameterNameContentID: @"10002",
                          FBSDKAppEventParameterNameDescription: @"$9.99 - 600 gems",
                          FBSDKAppEventParameterNameCurrency: @"USD",
                          @"PlayerLevel":@"20",
                          @"Value":@9.99},
                        @{FBSDKAppEventParameterNameContentID: @"10003",
                          FBSDKAppEventParameterNameDescription: @"$19.99 - 1300 gems",
                          FBSDKAppEventParameterNameCurrency: @"USD",
                          @"PlayerLevel":@"30",
                          @"Value":@19.99},
                        @{FBSDKAppEventParameterNameContentID: @"10004",
                          FBSDKAppEventParameterNameDescription: @"$49.99 - 3500 gems",
                          FBSDKAppEventParameterNameCurrency: @"USD",
                          @"PlayerLevel":@"40",
                          @"Value":@49.99},
                        @{FBSDKAppEventParameterNameContentID: @"10005",
                          FBSDKAppEventParameterNameDescription: @"$99.99 - 7200 gems",
                          FBSDKAppEventParameterNameCurrency: @"USD",
                          @"PlayerLevel":@"50",
                          @"Value":@99.99}];
        }
            break;
        case AppEventPlayerLevel:
        {
            /*
             * please note the default level achieved event is intended to use for player level
             */
            
            content = @[@{FBSDKAppEventParameterNameLevel: @"1",
                          FBSDKAppEventParameterNameDescription: @"Player level 1"},
                        @{FBSDKAppEventParameterNameLevel: @"2",
                          FBSDKAppEventParameterNameDescription: @"Player level 2"},
                        @{FBSDKAppEventParameterNameLevel: @"3",
                          FBSDKAppEventParameterNameDescription: @"Player level 3"},
                        @{FBSDKAppEventParameterNameLevel: @"4",
                          FBSDKAppEventParameterNameDescription: @"Player level 4"},
                        @{FBSDKAppEventParameterNameLevel: @"5",
                          FBSDKAppEventParameterNameDescription: @"Player level 5"}];
        }
            break;
        case AppEventAchievement:
        {
            content = @[@{FBSDKAppEventParameterNameContentID: @"1001",
                          FBSDKAppEventParameterNameDescription: @"Killed Boss Dragon"},
                        @{FBSDKAppEventParameterNameContentID: @"1002",
                          FBSDKAppEventParameterNameDescription: @"Have five builders"},
                        @{FBSDKAppEventParameterNameContentID: @"1003",
                          FBSDKAppEventParameterNameDescription: @"Gather 1000000 gold"},
                        @{FBSDKAppEventParameterNameContentID: @"1004",
                          FBSDKAppEventParameterNameDescription: @"Spent 10,000 gems in one day"},
                        @{FBSDKAppEventParameterNameContentID: @"1005",
                          FBSDKAppEventParameterNameDescription: @"Shared an app event"}];
        }
            break;
        /*
         * It is important to separate in game spending by hard currency and soft currency
         * You will be able to view the breakdown view of this event easier by doing this
         * 
         */
        case AppEventSpendHardCurrency:
        {
             content = @[@{FBSDKAppEventParameterNameContentID: @"20001",
                           FBSDKAppEventParameterNameDescription: @"150 Gems - Green Armor",
                           FBSDKAppEventParameterNameContentType: @"Hard Currency",
                           FBSDKAppEventParameterNameNumItems: @"1",
                           @"Value":@150},
                         @{FBSDKAppEventParameterNameContentID: @"20002",
                           FBSDKAppEventParameterNameDescription: @"350 Gems - Lightning Shoe",
                           FBSDKAppEventParameterNameContentType: @"Hard Currency",
                           FBSDKAppEventParameterNameNumItems: @"1",
                           @"Value":@350},
                         @{FBSDKAppEventParameterNameContentID: @"20003",
                           FBSDKAppEventParameterNameDescription: @"200 Gems - Magic Helm",
                           FBSDKAppEventParameterNameContentType: @"Hard Currency",
                           FBSDKAppEventParameterNameNumItems: @"1",
                           @"Value":@200},
                         @{FBSDKAppEventParameterNameContentID: @"20004",
                           FBSDKAppEventParameterNameDescription: @"900 Gems - Crystal Sword",
                           FBSDKAppEventParameterNameContentType: @"Hard Currency",
                           FBSDKAppEventParameterNameNumItems: @"1",
                           @"Value":@900},
                         @{FBSDKAppEventParameterNameContentID: @"20005",
                           FBSDKAppEventParameterNameDescription: @"450 Gems - Gold Shield",
                           FBSDKAppEventParameterNameContentType: @"Hard Currency",
                           FBSDKAppEventParameterNameNumItems: @"1",
                           @"Value":@450},
                         ];
        }
            break;
        case AppEventMapLevel:
        {
            content = @[@{FBSDKAppEventParameterNameLevel: @"1",
                          @"StarScore": @"1",
                          FBSDKAppEventParameterNameDescription: @"Map level 1"},
                        @{FBSDKAppEventParameterNameLevel: @"2",
                          @"StarScore": @"2",
                          FBSDKAppEventParameterNameDescription: @"Map level 2"},
                        @{FBSDKAppEventParameterNameLevel: @"3",
                          @"StarScore": @"3",
                          FBSDKAppEventParameterNameDescription: @"Map level 3"},
                        @{FBSDKAppEventParameterNameLevel: @"4",
                          @"StarScore": @"4",
                          FBSDKAppEventParameterNameDescription: @"Map level 4"},
                        @{FBSDKAppEventParameterNameLevel: @"5",
                          @"StarScore": @"5",
                          FBSDKAppEventParameterNameDescription: @"Map level 5"}];

        }
            break;
        case AppEventSpendSoftCurrency:
        {
            content = @[@{FBSDKAppEventParameterNameContentID: @"30001",
                          FBSDKAppEventParameterNameDescription: @"150 Coins - Green Armor Fragment",
                          FBSDKAppEventParameterNameContentType: @"Soft Currency",
                          FBSDKAppEventParameterNameNumItems: @"5",
                          @"Value":@150},
                        @{FBSDKAppEventParameterNameContentID: @"30002",
                          FBSDKAppEventParameterNameDescription: @"350 Coins - Lightning Shoe Fragment",
                          FBSDKAppEventParameterNameContentType: @"Soft Currency",
                          FBSDKAppEventParameterNameNumItems: @"4",
                          @"Value":@350},
                        @{FBSDKAppEventParameterNameContentID: @"30003",
                          FBSDKAppEventParameterNameDescription: @"200 Coins - Magic Helm Fragment",
                          FBSDKAppEventParameterNameContentType: @"Soft Currency",
                          FBSDKAppEventParameterNameNumItems: @"3",
                          @"Value":@200},
                        @{FBSDKAppEventParameterNameContentID: @"30004",
                          FBSDKAppEventParameterNameDescription: @"900 Coins - Crystal Sword Fragment",
                          FBSDKAppEventParameterNameContentType: @"Soft Currency",
                          FBSDKAppEventParameterNameNumItems: @"2",
                          @"Value":@900},
                        @{FBSDKAppEventParameterNameContentID: @"30005",
                          FBSDKAppEventParameterNameDescription: @"450 Coins - Gold Shield Fragment",
                          FBSDKAppEventParameterNameContentType: @"Soft Currency",
                          FBSDKAppEventParameterNameNumItems: @"1",
                          @"Value":@450},
                        ];
        }
            break;
        default:
            break;
    }
    
    [vc setEventName:[AppEventsController getEventName:[self lastButtonTag]] setContent: content];
}

@end
