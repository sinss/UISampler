//
//  InAppPurchaseManager.h
//  UICatalog
//
//  Created by Leo on 12/12/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

#define kSKProductKey @"product.key"
#define kInAppPurchaseSuccessNotification @"InAppPurchaseSuccessNotification.key"
#define kInAppPurchaseFailNotification @"InAppPurchaseSuccessNotification.key"

/*
 Consumable
  - 一次性購買內容
 Non-Consumable
  - 遊戲幣內購
 Auto-Renewable Subscriptions
  - 自動Review的項目(雜誌訂閱 - Newsstand)
 Free Subscription
  -  免費的購買項目
 Non-Renewing Subscription
  － 期間使用的內買項目(雜誌訂閱 - Newsstand)
 */
@interface InAppPurchaseManager : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (nonatomic, strong) NSArray *productIds;
@property (nonatomic, strong) SKProductsRequest *skRequest;

- (void)loadStore;

@end
