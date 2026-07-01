#import "RNPaymentSDKOptionsMapper.h"

@implementation RNPaymentSDKOptionsMapper

+ (InitOptions *)initOptionsFromDictionary:(nullable NSDictionary *)dictionary
{
    NSDictionary *dict = dictionary ?: @{};

    NSString *theme = dict[@"theme"];
    if (![theme isKindOfClass:[NSString class]]) {
        theme = @"";
    }

    NSNumber *cardScanningEnabledNum = dict[@"cardScanningEnabled"];
    BOOL cardScanningEnabled = [cardScanningEnabledNum isKindOfClass:[NSNumber class]]
        ? cardScanningEnabledNum.boolValue
        : NO;

    NSString *applePayMerchantId = dict[@"applePayMerchantId"];
    if (![applePayMerchantId isKindOfClass:[NSString class]]) {
        applePayMerchantId = @"";
    }

    NSString *applePayMerchantName = dict[@"applePayMerchantName"];
    if (![applePayMerchantName isKindOfClass:[NSString class]]) {
        applePayMerchantName = @"";
    }

  // Since we use let in InitOptions we don't expose setter so we have to init after retrieving all the value
    return [[InitOptions alloc] initWithTheme:theme
                           cardScanningEnabled:cardScanningEnabled
                            applePayMerchantId:applePayMerchantId
                          applePayMerchantName:applePayMerchantName];
}

- (LyraPaymentMethods)paymentMethodTypeFromNumber:(NSNumber *)value
{
    if ([value isKindOfClass:[NSNumber class]]) {
        NSInteger rawValue = value.integerValue;
        switch (rawValue) {
            case 0: return LyraPaymentMethodsAll;
            case 1: return LyraPaymentMethodsCard;
            case 2: return LyraPaymentMethodsApplePay;
            default: return LyraPaymentMethodsAll;
        }
    }
    return LyraPaymentMethodsAll;
}

+ (ProcessOptions *)processOptionsFromDictionary:(nullable NSDictionary *)dictionary
{
    NSDictionary *dict = dictionary ?: @{};

    NSString *customPayButtonLabel = dict[@"customPayButtonLabel"];
    if (![customPayButtonLabel isKindOfClass:[NSString class]]) {
        customPayButtonLabel = @"";
    }

    NSString *customHeaderLabel = dict[@"customHeaderLabel"];
    if (![customHeaderLabel isKindOfClass:[NSString class]]) {
        customHeaderLabel = @"";
    }

    NSString *customPopupLabel = dict[@"customPopupLabel"];
    if (![customPopupLabel isKindOfClass:[NSString class]]) {
        customPopupLabel = @"";
    }

    NSNumber *paymentMethodTypeNum = dict[@"paymentMethodType"];
    LyraPaymentMethods paymentMethodType = [self paymentMethodTypeFromNumber:paymentMethodTypeNum];

  // Since we use let in ProcessOptions we don't expose setter so we have to init after retrieving all the value
    return [[ProcessOptions alloc] initWithCustomPayButtonLabel:customPayButtonLabel
                                                customHeaderLabel:customHeaderLabel
                                                 customPopupLabel:customPopupLabel
                                                paymentMethodType:paymentMethodType];
}

+ (LyraPaymentMethods)paymentMethodTypeFromNumber:(nullable NSNumber *)value
{
    if ([value isKindOfClass:[NSNumber class]]) {
        NSInteger rawValue = value.integerValue;
        switch (rawValue) {
            case 0: return LyraPaymentMethodsAll;
            case 1: return LyraPaymentMethodsCard;
            case 2: return LyraPaymentMethodsApplePay; // NativePay côté TS
            default: return LyraPaymentMethodsAll;
        }
    }
    return LyraPaymentMethodsAll;
}

@end
