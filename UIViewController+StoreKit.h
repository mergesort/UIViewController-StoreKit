//
//  UIViewController+StoreKit.h
//  Picks
//
//  Created by Joe Fabisevich on 8/12/14.
//  Copyright (c) 2014 Snarkbots. All rights reserved.
//

#import <UIKit/UIKit.h>


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Constants

#define affiliateToken @"10laQX"


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

@interface UIViewController (StoreKit)

@property NSString *campaignToken;
@property (nonatomic, copy) void (^loadingStoreKitItemBlock)(void);
@property (nonatomic, copy) void (^loadedStoreKitItemBlock)(void);

- (void)presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier;

+ (BOOL)containsITunesURLString:(NSString *)URLString;
+ (NSInteger)IDFromITunesURL:(NSString *)URLString;

@end
