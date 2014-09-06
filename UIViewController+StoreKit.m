//
//  UIViewController+StoreKit.m
//  Picks
//
//  Created by Joe Fabisevich on 8/12/14.
//  Copyright (c) 2014 Snarkbots. All rights reserved.
//

#import "UIViewController+StoreKit.h"

#import <objc/runtime.h>
#import <NSString+Validation/NSString+Validation.h>

@import StoreKit;


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Constants

NSString * const affiliateTokenKey = @"at";
NSString * const campaignTokenKey = @"ct";
NSString * const iTunesAppleString = @"itunes.apple.com";


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

@interface UIViewController (SKStoreProductViewControllerDelegate)
<
    SKStoreProductViewControllerDelegate
>

@end


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Implementation

@implementation UIViewController (StoreKit)

- (void)presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier
{
    SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
    storeViewController.delegate = self;
    
    NSDictionary *parameters = @{
                                    SKStoreProductParameterITunesItemIdentifier: @(itemIdentifier),
                                    affiliateTokenKey : affiliateTokenKey,
                                    campaignTokenKey : self.campaignToken,
                                };
    
    if (self.loadingStoreKitItemBlock)
    {
        self.loadingStoreKitItemBlock();
    }
    [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError *error) {
        if (self.loadedStoreKitItemBlock)
        {
            self.loadedStoreKitItemBlock();
        }

        if (result && !error)
        {
            [self presentViewController:storeViewController animated:YES completion:nil];
        }
    }];
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Delegation - SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

+ (BOOL)containsITunesURLString:(NSString *)URLString
{
    return [URLString containsString:iTunesAppleString];
}

+ (NSInteger)IDFromITunesURL:(NSString *)URLString
{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"id\\d+" options:0 error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:URLString options:0 range:NSMakeRange(0, URLString.length)];
    
    NSString *idString = [URLString substringWithRange:match.range];
    if (idString.length > 0)
    {
        idString = [idString stringByReplacingOccurrencesOfString:@"id" withString:@""];
    }
    
    return [idString integerValue];
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Associated objects

- (void)setCampaignToken:(NSString *)campaignToken
{
    objc_setAssociatedObject(self, @selector(setCampaignToken:), campaignToken, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)campaignToken
{
    return objc_getAssociatedObject(self, @selector(setCampaignToken:));
}

- (void)setLoadingStoreKitItemBlock:(void (^)(void))loadingStoreKitItemBlock
{
    objc_setAssociatedObject(self, @selector(setLoadingStoreKitItemBlock:), loadingStoreKitItemBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))loadingStoreKitItemBlock
{
    return objc_getAssociatedObject(self, @selector(setLoadingStoreKitItemBlock:));
}

- (void)setLoadedStoreKitItemBlock:(void (^)(void))loadedStoreKitItemBlock
{
    objc_setAssociatedObject(self, @selector(setLoadedStoreKitItemBlock:), loadedStoreKitItemBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))loadedStoreKitItemBlock
{
    return objc_getAssociatedObject(self, @selector(setLoadedStoreKitItemBlock:));
}

@end
