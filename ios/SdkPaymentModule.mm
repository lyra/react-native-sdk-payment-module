#import "SdkPaymentModule.h"
#import <LyraPaymentSDK/LyraPaymentSDK-Swift.h>
#import <React/RCTUtils.h>

@implementation SdkPaymentModule 

RCT_EXPORT_MODULE()

- (NSNumber *)getFormTokenVersion{
  return [NSNumber numberWithInteger:[Lyra getFormTokenVersion]];
}

- (NSString *)getSdkVersion{
  return [Lyra getSDKVersion];
}

- (void)initialize:(nonnull NSString *)publicKey options:(nonnull NSDictionary *)configurationOptions resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject {
  NSError *error = nil;
  
  [Lyra initialize:publicKey :configurationOptions error:&error];
  
  if (error != nil) {
    reject(@"MOB_001", @"SDK initialization failed.", error);
  } else {
    resolve(@[]);
  }
}

- (void)process:(nonnull NSString *)formToken options:(nonnull NSDictionary *)configurationOptions resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject {
  UIViewController *presentedViewController = RCTPresentedViewController();
  NSError *error = nil;
  
  [Lyra process:presentedViewController :formToken
    onSuccess:^(LyraResponse *lyraResponse) {
        NSError *errorJSON = nil;
        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:lyraResponse.getResponseData options:kNilOptions error:&errorJSON];
        resolve(result);
    }
    onError:^(LyraError *lyraError, LyraResponse *lyraResponse) {
        reject(lyraError.errorCode, lyraError.errorMessage, nil);
        return;
    }
    :configurationOptions error:&error];

    if (error != nil) {
        reject(@"MOB_002", @"SDK initialization is required before calling process", error);
    }
  
}

- (void)cancelProcess{
  [Lyra cancelProcess];
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeSdkPaymentModuleSpecJSI>(params);
}

@end
