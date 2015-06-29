//
//  FirstViewController.m
//  platformTest
//
//  Created by Pu Guannan on 4/7/15.
//  Copyright (c) 2015 Pu Guannan. All rights reserved.
//

#import "AppEventsControllerApp.h"
#import "PickerViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppEventsControllerApp ()
@end

@implementation AppEventsControllerApp

- (void)loadButtons
{
    self.lastY = 0.0;
    [self addButton:AppEventRegistration buttonText:@"Registation"];
    [self addButton:AppEventSearched buttonText:@"Search"];
    [self addButton:AppEventViewedContent buttonText:@"View Content"];
    [self addButton:AppEventAddedToWishlist buttonText:@"Add to Wishlist"];
    [self addButton:AppEventAddedToCart buttonText:@"Add to Cart"];
    [self addButton:AppEventPurchase buttonText:@"Purchase"];
    [self addButton:AppEventAddedPaymentInfo buttonText:@"Add Payment Info"];
    [self addButton:AppEventRated buttonText:@"Rated"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PickerViewController *vc = segue.destinationViewController;
    NSArray *content;
    
    switch ([self lastButtonTag]) {
        /*
         * provide description for most app events you are logging, by doing this, cross functional teams can easily look up
         * the right param to use for strategy or marketing
         */
        case AppEventRegistration:
        {
            content = @[@{FBSDKAppEventParameterNameRegistrationMethod: @"Facebook",
                          FBSDKAppEventParameterNameDescription: @"Facebook"},
                        @{FBSDKAppEventParameterNameRegistrationMethod: @"Google+",
                          FBSDKAppEventParameterNameDescription: @"Google+"},
                        @{FBSDKAppEventParameterNameRegistrationMethod: @"Email",
                          FBSDKAppEventParameterNameDescription: @"Email"},
                        @{FBSDKAppEventParameterNameRegistrationMethod: @"Guest",
                          FBSDKAppEventParameterNameDescription: @"Guest"}];
        }
            break;
            
        case AppEventSearched:
        {
            content = @[@{FBSDKAppEventParameterNameSearchString: @"Shirts",
                          FBSDKAppEventParameterNameDescription: @"Shirts"},
                        @{FBSDKAppEventParameterNameSearchString: @"Shorts",
                          FBSDKAppEventParameterNameDescription: @"Shorts"}];
        }
            break;
            
        case AppEventAddedPaymentInfo:
        {
            content = @[@{@"PaymentMethod": @"MasterCard",
                          FBSDKAppEventParameterNameDescription: @"MasterCard"},
                        @{@"PaymentMethod": @"VISA",
                          FBSDKAppEventParameterNameDescription: @"VISA"}];
        }
            break;
            
        case AppEventViewedContent:
        case AppEventAddedToWishlist:
        case AppEventAddedToCart:
        case AppEventRated:
        {
            content = @[@{FBSDKAppEventParameterNameContentID: @"10001",
                          FBSDKAppEventParameterNameContentType: @"Shirts",
                          FBSDKAppEventParameterNameDescription: @"$49.99 - Oxford Shirts",
                          FBSDKAppEventParameterNameCurrency: @"USD",
                          @"PromotionCode": @"12345",
                          @"Value":@49.99},
                        @{FBSDKAppEventParameterNameContentID: @"20001",
                          FBSDKAppEventParameterNameContentType: @"Shorts",
                          FBSDKAppEventParameterNameDescription: @"$59.99 - Oxford Shorts",
                          FBSDKAppEventParameterNameCurrency: @"USD",
                          @"PromotionCode": @"10000",
                          @"Value":@59.99}];
        }
            break;
            
        case AppEventPurchase:
        {
            content = @[@{FBSDKAppEventParameterNameContentID: @"10001",
                          FBSDKAppEventParameterNameContentType: @"Shirts",
                          FBSDKAppEventParameterNameDescription: @"$49.99 - Oxford Shirts",
                          FBSDKAppEventParameterNameNumItems: @"1",
                          FBSDKAppEventParameterNameCurrency: @"USD",
                          @"PromotionCode": @"12345",
                          @"Value":@49.99},
                        @{FBSDKAppEventParameterNameContentID: @"20001",
                          FBSDKAppEventParameterNameContentType: @"Shorts",
                          FBSDKAppEventParameterNameDescription: @"$59.99 - Oxford Shorts",
                          FBSDKAppEventParameterNameNumItems: @"1",
                          FBSDKAppEventParameterNameCurrency: @"USD",
                          @"PromotionCode": @"10000",
                          @"Value":@59.99}];
        }
            break;
            
        default:
            break;
    }
    
    [vc setEventName:[AppEventsController getEventName:[self lastButtonTag]] setContent: content];
}

@end
