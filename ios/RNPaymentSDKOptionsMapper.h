#import <Foundation/Foundation.h>
#import <LyraPaymentSDK/LyraPaymentSDK-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNPaymentSDKOptionsMapper : NSObject

+ (InitOptions *)initOptionsFromDictionary:(nullable NSDictionary *)dictionary;
+ (ProcessOptions *)processOptionsFromDictionary:(nullable NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
